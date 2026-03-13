using APPBASE.Models;
using APPBASE.Services;

namespace APPBASE
{
    public partial class GestionCasasPage : ContentPage
    {
        private FirebaseService _service = new FirebaseService();
        List<Casa> listaCompleta = new List<Casa>();

        public GestionCasasPage()
        {
            InitializeComponent();
            CargarCasas();
        }

        private async void CargarCasas()
        {
            // Traemos la lista de casas de Firebase
            var casas = await _service.ObtenerTodasLasCasasAsync();
            listaCompleta = casas ?? new List<Casa>();
            lstCasas.ItemsSource = casas;
        }

        private void OnBuscarCasa(object sender, TextChangedEventArgs e)
        {
            // Manejo de nulos para evitar errores al borrar todo el texto
            string texto = e.NewTextValue?.ToLower() ?? string.Empty;

            if (string.IsNullOrWhiteSpace(texto))
            {
                // Si no hay texto, mostramos todo de nuevo
                lstCasas.ItemsSource = listaCompleta;
            }
            else
            {
                // Ahora sí, filtramos sobre la lista que ya tiene datos
                var filtrados = listaCompleta
                    .Where(u => u.NumeroCasa != null && u.NumeroCasa.ToLower().Contains(texto))
                    .ToList();

                lstCasas.ItemsSource = filtrados;
            }
        }

        private async void OnMantenimientoToggled(object sender, ToggledEventArgs e)
        {
            var sw = (Switch)sender;
            var casa = (Casa)sw.BindingContext;

            if (casa != null)
            {
                casa.MantenimientoAlDia = e.Value;
                // Guardamos el cambio de pago en Firebase inmediatamente
                await _service.ActualizarEstadoCasaAsync(casa);
            }
        }
    }
}