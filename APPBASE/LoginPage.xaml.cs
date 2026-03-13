using Plugin.Fingerprint;
using Plugin.Fingerprint.Abstractions;
using APPBASE.Services;

namespace APPBASE;

public partial class LoginPage : ContentPage
{
    FirebaseService _authService = new FirebaseService();

    public LoginPage()
    {
        InitializeComponent();
    }

    // ─── MOSTRAR VISTA CORRECTA ──────────────────────────────────────────────────
    private void MostrarVistaSegunModo()
    {
        bool usaBiometria = Preferences.Get("UsaBiometria", false);

        if (usaBiometria)
        {
            layoutCredenciales.IsVisible = false;
            layoutHuella.IsVisible = true;

            // Mostrar nombre del usuario guardado
            string nombre = Preferences.Get("NombreUsuario", "");
            lblNombreUsuario.Text = string.IsNullOrEmpty(nombre) ? "" : nombre;
        }
        else
        {
            layoutCredenciales.IsVisible = true;
            layoutHuella.IsVisible = false;
        }
    }

    // ─── BOTÓN "USAR CREDENCIALES" (desde vista biométrica) ──────────────────────
    private void OnUsarCredencialesClicked(object sender, EventArgs e)
    {
        layoutHuella.IsVisible = false;
        layoutCredenciales.IsVisible = true;
    }

    // ─── OnAppearing ACTUALIZADO ──────────────────────────────────────────────────
    protected override async void OnAppearing()
    {
        base.OnAppearing();

        MostrarVistaSegunModo();

        bool usaBiometria = Preferences.Get("UsaBiometria", false);

        if (usaBiometria)
        {
            await Task.Delay(600);
            await AutenticarConHuella();
        }
    }

    // ─── LOGIN NORMAL ────────────────────────────────────────────────────────────
    private async void OnLoginClicked(object sender, EventArgs e)
    {
        string user = txtUser.Text?.Trim();
        string pass = txtPass.Text?.Trim();

        if (string.IsNullOrEmpty(user) || string.IsNullOrEmpty(pass))
        {
            await DisplayAlert("Aviso", "Ingresa tus datos", "OK");
            return;
        }

        try
        {
            bool esValido = false;

            // ── Admin local ──────────────────────────────────────────────────────
            if (user == "admin" && pass == "1234")
            {
                esValido = true;
                Preferences.Set("EsAdmin", true);
                Preferences.Set("NombreUsuario", "Administrador");
            }
            else
            {
                // ── Usuarios Firebase ────────────────────────────────────────────
                var usuarioFirebase = await _authService.ValidarUsuarioAsync(user, pass);

                if (usuarioFirebase != null)
                {
                    esValido = true;

                    Preferences.Set("EsAdmin", false);
                    Preferences.Set("NombreUsuario", usuarioFirebase.Nombre);
                    Preferences.Set("ID_Casa", usuarioFirebase.ID_Casa ?? "");

                    // Guardar permisos con los nombres exactos del modelo
                    Preferences.Set("P_Peatonal", usuarioFirebase.PuedePeatonal);
                    Preferences.Set("P_Porton", usuarioFirebase.PuedePorton);
                    Preferences.Set("P_Alarma", usuarioFirebase.PuedeAlarma);
                    Preferences.Set("P_Historial", usuarioFirebase.PuedeHistorial);
                    Preferences.Set("P_Camaras", usuarioFirebase.PuedeCamaras);
                }
            }

            if (!esValido)
            {
                await DisplayAlert("Error", "Credenciales incorrectas", "OK");
                return;
            }

            // ── Login exitoso: ¿ofrecer biometría por primera vez? ───────────────
            bool yaConfigurada = Preferences.Get("UsaBiometria", false);

            if (!yaConfigurada)
            {
                var disponibilidad = await CrossFingerprint.Current.GetAvailabilityAsync();

                if (disponibilidad == FingerprintAvailability.Available)
                {
                    bool activar = await DisplayAlert(
                        "Biometría",
                        "¿Deseas activar el inicio de sesión con huella?",
                        "Sí", "No");

                    if (activar)
                    {
                        await SecureStorage.SetAsync("UsuarioGuardado", user);
                        await SecureStorage.SetAsync("PasswordGuardado", pass);
                        Preferences.Set("UsaBiometria", true);
                    }
                }
            }

            await Navigation.PushAsync(new MainPage());
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", ex.Message, "OK");
        }
    }

    // ─── BOTÓN HUELLA ────────────────────────────────────────────────────────────
    private async void OnHuellaClicked(object sender, EventArgs e)
    {
        await AutenticarConHuella();
    }

    // ─── LOGIN CON HUELLA ────────────────────────────────────────────────────────
    private async Task AutenticarConHuella()
    {
        try
        {
            var disponibilidad = await CrossFingerprint.Current.GetAvailabilityAsync();

            if (disponibilidad != FingerprintAvailability.Available)
            {
                await DisplayAlert("Aviso", "Biometría no disponible en este dispositivo", "OK");
                return;
            }

            var request = new AuthenticationRequestConfiguration(
                "Inicio de Sesión",
                "Coloca tu huella para entrar");

            var result = await CrossFingerprint.Current.AuthenticateAsync(request);

            if (result.Authenticated)
            {
                string user = await SecureStorage.GetAsync("UsuarioGuardado");
                string pass = await SecureStorage.GetAsync("PasswordGuardado");

                if (string.IsNullOrEmpty(user))
                {
                    await DisplayAlert("Error", "No se encontraron credenciales guardadas", "OK");
                    return;
                }

                // ── Restaurar preferencias según el usuario guardado ─────────────
                if (user == "admin" && pass == "1234")
                {
                    Preferences.Set("EsAdmin", true);
                    Preferences.Set("NombreUsuario", "Administrador");
                }
                else
                {
                    Preferences.Set("EsAdmin", false);
                    // Preferences.Set("NombreUsuario", ...);  // si lo tienes guardado
                }

                await Navigation.PushAsync(new MainPage());
            }
            else
            {
                if (result.Status == FingerprintAuthenticationResultStatus.TooManyAttempts)
                {
                    await DisplayAlert("Bloqueado", "Demasiados intentos fallidos. Usa tus credenciales.", "OK");
                }
                // Si cancela o falla, simplemente queda en la pantalla de login
                // para que pueda ingresar con usuario y contraseña
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error biométrico", ex.Message, "OK");
        }
    }
}