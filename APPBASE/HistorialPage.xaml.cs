using APPBASE.Models; // Asegúrate de tener tu modelo aquí
using APPBASE.Services;

namespace APPBASE
{
    public partial class HistorialPage : ContentPage
    {
        FirebaseService _firebaseService = new FirebaseService();

        // Esta lista guarda TODO lo que bajamos de Firebase
        List<Evento> listaCompleta = new List<Evento>();

        public HistorialPage()
        {
            InitializeComponent();
            CargarDatos();
        }

        private async void CargarDatos()
        {
            try
            {
                loader.IsRunning = true;
                var lista = await _firebaseService.ObtenerHistorialAsync();

                if (lista != null)
                {
                    // Ordenamos y guardamos en la variable global
                    listaCompleta = lista
                        .OrderByDescending(e => DateTime.ParseExact(e.Fecha, "dd/MM/yyyy", null))
                        .ThenByDescending(e => TimeSpan.Parse(e.Hora))
                        .ToList();

                    // Mostramos la lista completa al inicio
                    listaHistorial.ItemsSource = listaCompleta;
                }
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", "No se pudieron cargar los datos: " + ex.Message, "OK");
            }
            finally
            {
                loader.IsRunning = false;
            }
        }

        // Método que filtra por Fecha y por Hora
        private void OnFiltroCambiado(object sender, EventArgs e)
        {
            if (listaCompleta == null || listaCompleta.Count == 0) return;

            string fechaBusqueda = filtroFecha.Date.ToString("dd/MM/yyyy");
            TimeSpan horaBusqueda = filtroHora.Time;

            // Filtramos la lista local
            var filtrados = listaCompleta.Where(h =>
                h.Fecha == fechaBusqueda &&
                TimeSpan.Parse(h.Hora) >= horaBusqueda
            ).ToList();

            listaHistorial.ItemsSource = filtrados;
        }

        // Botón para resetear los filtros y ver todo de nuevo
        private void OnLimpiarFiltro(object sender, EventArgs e)
        {
            // Resetear controles visuales
            filtroFecha.Date = DateTime.Now;
            filtroHora.Time = new TimeSpan(0, 0, 0);

            // Mostrar la lista original
            listaHistorial.ItemsSource = listaCompleta;
        }
    }
}