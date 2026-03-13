using APPBASE.Models;
using APPBASE.Services;

namespace APPBASE
{
    public partial class RegistroPage : ContentPage
    {
        private FirebaseService _firebaseService = new FirebaseService();
        private bool _esEdicion = false;

        public RegistroPage()
        {
            InitializeComponent();
            _esEdicion = false;
            CargarCasas();
        }

        public RegistroPage(Usuario usuario)
        {
            InitializeComponent();
            _esEdicion = true;
            CargarDatosEdicion(usuario);
        }

        private async void CargarCasas()
        {
            var casas = await _firebaseService.ObtenerTodasLasCasasAsync();
            pickerCasas.ItemsSource = casas;
        }

        // --- NUEVO MÉTODO PARA REGISTRAR CASAS DESDE AQUÍ ---
        private async void OnAgregarNuevaCasaClicked(object sender, EventArgs e)
        {
            // Pedimos el número de casa al admin
            string resultado = await DisplayPromptAsync("Nueva Casa",
                "Ingrese el número de la casa (Ej: 01, 15, 20):",
                "Guardar", "Cancelar", "Número de casa", 2, Keyboard.Numeric);

            if (!string.IsNullOrWhiteSpace(resultado))
            {
                var nuevaCasa = new Casa
                {
                    NumeroCasa = resultado,
                    MantenimientoAlDia = true // Por defecto inicia con acceso activo
                };

                // Guardamos en Firebase
                await _firebaseService.ActualizarEstadoCasaAsync(nuevaCasa);

                // Recargamos el Picker para que aparezca la nueva casa
                CargarCasas();

                await DisplayAlert("Éxito", $"Casa {resultado} registrada correctamente", "OK");
            }
        }

        private async void CargarDatosEdicion(Usuario usuario)
        {
            var casas = await _firebaseService.ObtenerTodasLasCasasAsync();
            pickerCasas.ItemsSource = casas;
            txtNombre.Text = usuario.Nombre;
            txtPassword.Text = usuario.Password;
           

            // Seleccionamos la casa del usuario en el picker
            pickerCasas.SelectedItem = casas.FirstOrDefault(c => c.NumeroCasa == usuario.ID_Casa);

            chkPeatonal.IsChecked = usuario.PuedePeatonal;
            chkPorton.IsChecked = usuario.PuedePorton;
            chkAlarma.IsChecked = usuario.PuedeAlarma;
            chkHistorial.IsChecked = usuario.PuedeHistorial;
            chkCamaras.IsChecked = usuario.PuedeCamaras;

            btnGuardar.Text = "Actualizar Vecino";
        }

        private async void BtnGuardar_Clicked(object sender, EventArgs e)
        {
            var casaSeleccionada = (Casa)pickerCasas.SelectedItem;

            if (string.IsNullOrEmpty(txtNombre.Text) || casaSeleccionada == null)
            {
                await DisplayAlert("Error", "Nombre, Teléfono y Casa son obligatorios", "OK");
                return;
            }

            loader.IsRunning = true;
            btnGuardar.IsEnabled = false;

            var user = new Usuario
            {
                Nombre = txtNombre.Text,
               Password = txtPassword.Text,
                ID_Casa = casaSeleccionada.NumeroCasa,
                PuedePeatonal = chkPeatonal.IsChecked,
                PuedePorton = chkPorton.IsChecked,
                PuedeAlarma = chkAlarma.IsChecked,
                PuedeHistorial = chkHistorial.IsChecked,
                PuedeCamaras = chkCamaras.IsChecked
            };

            bool exito = await _firebaseService.RegistrarUsuarioAsync(user);

            if (exito)
            {
                await DisplayAlert("Éxito", "Vecino guardado correctamente", "OK");
                await Navigation.PopAsync();
            }
            else
            {
                await DisplayAlert("Error", "No se pudo guardar en Firebase", "OK");
            }

            loader.IsRunning = false;
            btnGuardar.IsEnabled = true;
        }
    }
}