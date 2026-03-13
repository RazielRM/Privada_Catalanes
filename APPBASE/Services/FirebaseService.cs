using APPBASE.Models;
using Firebase.Database;
using Firebase.Database.Query;
using System.Diagnostics;

namespace APPBASE.Services
{
    public class FirebaseService
    {
        private readonly FirebaseClient _client;

        public FirebaseService()
        {
            _client = new FirebaseClient("https://controlprivada-default-rtdb.firebaseio.com/");
        }

        // LOGIN: Busca si existe el teléfono y si la contraseña coincide
        // MÉTODO DE LOGIN MEJORADO
        // LOGIN: Busca por Nombre
        public async Task<Usuario> LoginAsync(string nombre, string password)
        {
            try
            {
                // Buscamos directamente en el nodo del nombre
                var user = await _client
                    .Child("Usuarios")
                    .Child(nombre)
                    .OnceSingleAsync<Usuario>();

                if (user != null && user.Password.Trim() == password.Trim())
                {
                    return user;
                }
                return null;
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error en Login: " + ex.Message);
                return null;
            }
        }
        // REGISTRO: Usa el Nombre como ID
        public async Task<bool> RegistrarUsuarioAsync(Usuario nuevoUsuario)
        {
            try
            {
                // Guardamos usando el Nombre como llave del nodo
                await _client
                    .Child("Usuarios")
                    .Child(nuevoUsuario.Nombre)
                    .PutAsync(nuevoUsuario);

                return true;
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error en Registro: " + ex.Message);
                return false;
            }
        }
        // Cambia bool por Usuario
        public async Task<Usuario> ValidarUsuarioAsync(string usuario, string password)
        {
            try
            {
                var usuarioEncontrado = (await _client
                    .Child("Usuarios")
                    .OnceAsync<Usuario>())
                    .FirstOrDefault(u => u.Object.Nombre == usuario
                                      && u.Object.Password == password);

                return usuarioEncontrado?.Object;
            }
            catch
            {
                return null;
            }
        }
        public async Task RegistrarEventoAsync(string accion)
        {
            try
            {
                var nuevoEvento = new Evento
                {
                    Usuario = Preferences.Get("NombreUsuario", "Desconocido"),
                    Accion = accion,
                    Fecha = DateTime.Now.ToString("dd/MM/yyyy"),
                    Hora = DateTime.Now.ToString("HH:mm:ss")
                };

                await _client
                    .Child("Historial")
                    .PostAsync(nuevoEvento); // Post genera un ID único para cada entrada
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al guardar historial: " + ex.Message);
            }
        }

        public async Task<List<Evento>> ObtenerHistorialAsync()
        {
            try
            {
                // Consultamos todos los registros de la carpeta "Historial"
                var historialData = await _client
                    .Child("Historial")
                    .OnceAsync<Evento>();

                // Convertimos la respuesta en una lista de C#
                return historialData.Select(item => new Evento
                {
                    // El objeto "item.Object" contiene Usuario, Accion, Fecha y Hora
                    Usuario = item.Object.Usuario,
                    Accion = item.Object.Accion,
                    Fecha = item.Object.Fecha,
                    Hora = item.Object.Hora
                }).ToList();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al obtener historial: " + ex.Message);
                return new List<Evento>(); // Devolvemos lista vacía para que la app no truene
            }
        }
        //public async Task<bool> ElUsuarioYaExisteAsync(string telefono)
        //{
        //    try
        //    {
        //        var usuarios = await _client
        //            .Child("Usuarios")
        //            .OnceAsync<Usuario>();

        //        // Verificamos si algún objeto tiene ya ese número de teléfono
        //        return usuarios.Any(u => u.Object.Nombre);
        //    }
        //    catch
        //    {
        //        return false; // Si hay error, por seguridad permitimos intentar el registro
        //    }
        //}
        public async Task<List<Usuario>> ObtenerTodosLosUsuariosAsync()
        {
            var usuarios = await _client.Child("Usuarios").OnceAsync<Usuario>();
            return usuarios.Select(u => u.Object).ToList();
        }
        // Obtener lista de casas
        public async Task<List<Casa>> ObtenerTodasLasCasasAsync()
        {
            var casas = await _client.Child("Casas").OnceAsync<Casa>();
            return casas.Select(c => c.Object).OrderBy(c => c.NumeroCasa).ToList();
        }

        // Actualizar si pagó o no
        public async Task ActualizarEstadoCasaAsync(Casa casa)
        {
            await _client.Child("Casas").Child(casa.NumeroCasa).PutAsync(casa);
        }
        // Obtener el estado de una casa específica por su ID
        // Obtener una casa específica por su ID (ejemplo: "01")
        public async Task<Casa> ObtenerEstadoCasaAsync(string idCasa)
        {
            try
            {
                // Buscamos en el nodo "Casas" el hijo que tenga el nombre de la casa
                return await _client
                    .Child("Casas")
                    .Child(idCasa)
                    .OnceSingleAsync<Casa>();
            }
            catch (Exception)
            {
                // Si hay error de red o no existe, devolvemos null
                return null;
            }
        }
    }
}