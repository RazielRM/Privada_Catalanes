using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace APPBASE.Models
{
    public class Casa
    {
        public string NumeroCasa { get; set; } // Ejemplo: "Casa 01"
        public bool MantenimientoAlDia { get; set; } // True = Pagado, False = Deuda
    }
}