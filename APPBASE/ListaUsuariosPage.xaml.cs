using APPBASE.Models;
using APPBASE.Services;

namespace APPBASE
{
    public partial class ListaUsuariosPage : ContentPage
    {
        private FirebaseService _service = new FirebaseService();

        List<Usuario> listaCompleta = new List<Usuario>();

        public ListaUsuariosPage()
        {
            InitializeComponent();
            CargarUsuarios();
        }

        private async void CargarUsuarios()
        {
            try
            {
                listaCompleta = await _service.ObtenerTodosLosUsuariosAsync();

                lstUsuarios.ItemsSource = listaCompleta;
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", "No se pudieron cargar los vecinos: " + ex.Message, "OK");
            }
        }

        // BUSCADOR
        private void OnBuscarUsuario(object sender, TextChangedEventArgs e)
        {
            string texto = e.NewTextValue.ToLower();

            var filtrados = listaCompleta
                .Where(u => u.Nombre.ToLower().Contains(texto))
                .ToList();

            lstUsuarios.ItemsSource = filtrados;
        }

        // SELECCIONAR USUARIO
        private async void OnUsuarioSeleccionado(object sender, SelectionChangedEventArgs e)
        {
            if (e.CurrentSelection.Count == 0)
                return;

            var usuario = e.CurrentSelection.FirstOrDefault() as Usuario;

            if (usuario != null)
            {
                await Navigation.PushAsync(new RegistroPage(usuario));
            }

            ((CollectionView)sender).SelectedItem = null;
        }
    }
}