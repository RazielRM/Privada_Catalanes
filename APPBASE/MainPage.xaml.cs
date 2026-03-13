using APPBASE.Services;
using APPBASE.Models;
using System.Diagnostics;

namespace APPBASE
{
    public partial class MainPage : ContentPage
    {
        private MqttService _mqttService;
        private FirebaseService _firebaseService;

        public MainPage()
        {
            InitializeComponent();
            _mqttService = new MqttService();
            _firebaseService = new FirebaseService();

            CheckAndRequestNotificationPermission();

            // Conexión MQTT al iniciar
            Task.Run(async () =>
            {
                try
                {
                    await _mqttService.ConnectAsync();

                    MainThread.BeginInvokeOnMainThread(() =>
                    {
                        lblEstado.Text = "Estado: Conectado";
                        lblEstado.TextColor = Colors.Green;
                    });
                }
                catch (Exception ex)
                {
                    MainThread.BeginInvokeOnMainThread(async () =>
                    {
                        lblEstado.Text = "Estado: Error";
                        lblEstado.TextColor = Colors.Red;
                        await DisplayAlert("Error MQTT", "No se pudo conectar: " + ex.Message, "Aceptar");
                    });
                }
            });
        }
        protected override bool OnBackButtonPressed()
        {
            return true; // bloquea el botón atrás
        }

        private async void CheckAndRequestNotificationPermission()
        {
            PermissionStatus status = await Permissions.CheckStatusAsync<Permissions.PostNotifications>();

            if (status != PermissionStatus.Granted)
            {
                await Permissions.RequestAsync<Permissions.PostNotifications>();
            }
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();

            bool esAdmin = Preferences.Get("EsAdmin", false);
            string idCasa = Preferences.Get("ID_Casa", "");
            string nombre = Preferences.Get("NombreUsuario", "Usuario");

            lblBienvenida.Text = $"Bienvenido, {nombre}";

            if (esAdmin)
            {
                ConfigurarVistaAdmin();
                return; // IMPORTANTE: el admin ya no pasa por validaciones
            }

            await ValidarAccesoVecino(idCasa);
        }

        // =========================
        // VALIDAR ACCESO VECINO
        // =========================
        private async Task ValidarAccesoVecino(string idCasa)
        {
            try
            {
                var casa = await _firebaseService.ObtenerEstadoCasaAsync(idCasa);

                if (casa != null && casa.MantenimientoAlDia)
                {
                    lblEstado.Text = $"Casa {idCasa}: Al corriente";
                    lblEstado.TextColor = Colors.Green;

                    btnPeatonal.IsVisible = Preferences.Get("P_Peatonal", false);
                    btnPorton.IsVisible = Preferences.Get("P_Porton", false);
                    btnAlarma.IsVisible = Preferences.Get("P_Alarma", false);
                    btnVerHistorial.IsVisible = Preferences.Get("P_Historial", false);
                    btnCamaras.IsVisible = Preferences.Get("P_Camaras", false);

                    AdminPanel.IsVisible = false;
                    frameAdeudo.IsVisible = false;
                }
                else
                {
                    lblEstado.Text = "ACCESO RESTRINGIDO: ADEUDO";
                    lblEstado.TextColor = Colors.Red;

                    btnPeatonal.IsVisible = false;
                    btnPorton.IsVisible = false;
                    btnAlarma.IsVisible = false;
                    btnVerHistorial.IsVisible = false;
                    btnCamaras.IsVisible = false;
                    AdminPanel.IsVisible = false;

                    // Mostrar aviso de adeudo en pantalla en vez de popup
                    frameAdeudo.IsVisible = true;
                }

            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error validando casa: " + ex.Message);
            }
        }

        // =========================
        // VISTA ADMIN
        // =========================
        private void ConfigurarVistaAdmin()
        {
            lblEstado.Text = "Modo: Administrador";
            lblEstado.TextColor = Colors.Blue;

            btnPeatonal.IsVisible = true;
            btnPorton.IsVisible = true;
            btnAlarma.IsVisible = true;
            btnVerHistorial.IsVisible = true;
            btnCamaras.IsVisible = true;
            frameAdeudo.IsVisible = false;

            // Mostrar panel y sus botones
            AdminPanel.IsVisible = true;
            btnAdminCasas.IsVisible = true;
            btnAdminLista.IsVisible = true;
            btnAdminRegistrar.IsVisible = true;
        }

        // =========================
        // VALIDACIÓN DE ACCIONES
        // =========================
        private async Task<bool> TienePermisoAccion()
        {
            bool esAdmin = Preferences.Get("EsAdmin", false);

            if (esAdmin)
                return true;

            string idCasa = Preferences.Get("ID_Casa", "");

            var casa = await _firebaseService.ObtenerEstadoCasaAsync(idCasa);

            if (casa == null || !casa.MantenimientoAlDia)
            {
                await DisplayAlert("Acceso Denegado",
                    "Se ha detectado un adeudo reciente. Acceso desactivado.",
                    "Aceptar");

                await ValidarAccesoVecino(idCasa);

                return false;
            }

            return true;
        }

        // =========================
        // BOTONES
        // =========================

        private async void OnAbrirPuertaClicked(object sender, EventArgs e)
        {
            if (!await TienePermisoAccion()) return;

            try
            {
                await _mqttService.AbrirPeatonalAsync(true);
                await _firebaseService.RegistrarEventoAsync("Abrió Puerta Peatonal");

                await DisplayAlert("Comando Enviado",
                    "La puerta peatonal se está abriendo...",
                    "Aceptar");
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error",
                    "No se pudo abrir la puerta: " + ex.Message,
                    "OK");
            }
        }

        private async void OnAbrirPortonClicked(object sender, EventArgs e)
        {
            if (!await TienePermisoAccion()) return;

            try
            {
                await _mqttService.AbrirPortonAsync(true);
                await _firebaseService.RegistrarEventoAsync("Abrió Portón");

                await DisplayAlert("Comando Enviado",
                    "El portón vehicular se está abriendo...",
                    "Aceptar");
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error",
                    "No se pudo abrir el portón: " + ex.Message,
                    "OK");
            }
        }

        private async void OnAlarmaVecinalClicked(object sender, EventArgs e)
        {
            if (!await TienePermisoAccion()) return;

            try
            {
                await _mqttService.AlarmaVecinalAsync(true);
                await _firebaseService.RegistrarEventoAsync("Activó ALARMA");

                await DisplayAlert("Alarma Activada",
                    "Se ha enviado la señal de alerta a todos los vecinos.",
                    "Aceptar");
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error",
                    "No se pudo activar la alarma: " + ex.Message,
                    "OK");
            }
        }

        private async void OnVerCamarasClicked(object sender, EventArgs e)
        {
            if (!await TienePermisoAccion()) return;

            await Navigation.PushAsync(new CamarasPage());
        }

        // =========================
        // NAVEGACIÓN
        // =========================

        private async void OnIrARegistroClicked(object sender, EventArgs e)
            => await Navigation.PushAsync(new RegistroPage());

        private async void OnVerHistorialClicked(object sender, EventArgs e)
            => await Navigation.PushAsync(new HistorialPage());

        private async void OnVerListaUsuariosClicked(object sender, EventArgs e)
            => await Navigation.PushAsync(new ListaUsuariosPage());

        private async void OnIrAGestionCasasClicked(object sender, EventArgs e)
            => await Navigation.PushAsync(new GestionCasasPage());

        // =========================
        // CERRAR SESIÓN
        // =========================

        private async void OnCerrarSesionClicked(object sender, EventArgs e)
        {
            if (await DisplayAlert("Salir", "¿Cerrar sesión?", "Sí", "No"))
            {
                // ❌ Preferences.Clear();  <-- esto borraba UsaBiometria también

                // ✅ Solo limpia datos de sesión activa
                Preferences.Remove("EsAdmin");
                Preferences.Remove("NombreUsuario");
                Preferences.Remove("ID_Casa");

                // UsaBiometria y las credenciales en SecureStorage se conservan

                Application.Current.MainPage = new NavigationPage(new LoginPage());
            }
        }
    }
}