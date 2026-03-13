namespace APPBASE
{
    public partial class CamarasPage : ContentPage
    {
        private Services.FirebaseService _firebaseService = new Services.FirebaseService();

        public CamarasPage()
        {
            InitializeComponent();
            RegistrarAcceso();
        }

        private async void RegistrarAcceso()
        {
            await _firebaseService.RegistrarEventoAsync("Visualizó Cámaras de Vigilancia");
        }
    }
}