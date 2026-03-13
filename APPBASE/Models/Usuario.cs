namespace APPBASE.Models
{
    public class Usuario
    {
        public string Nombre { get; set; }
       public string Password { get; set; }
        public string ID_Casa { get; set; }

        // Nombres exactos como aparecen en tu captura de Firebase
        public bool PuedeAlarma { get; set; }
        public bool PuedeHistorial { get; set; }
        public bool PuedePeatonal { get; set; }
        public bool PuedePorton { get; set; }
        public bool PuedeCamaras { get; set; }
    }
}