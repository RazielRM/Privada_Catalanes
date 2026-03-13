using MQTTnet;
using MQTTnet.Client;
using MQTTnet.Client.Options;
using System.Text;
using System.Text.Json;

namespace APPBASE.Services
{
    public class MqttService
    {
        private IMqttClient _client;
        private bool _continuarVibrando = false;

        // --- EL CANDADO ---
        // Esta variable evita que se disparen múltiples alertas si ya hay una en pantalla
        private bool _alertaActiva = false;

        private string GetUniqueClientId()
        {
            string deviceId = Preferences.Get("DeviceMqttId", string.Empty);
            if (string.IsNullOrEmpty(deviceId))
            {
                deviceId = $"{DeviceInfo.Name.Replace(" ", "_")}_{Guid.NewGuid().ToString().Substring(0, 5)}";
                Preferences.Set("DeviceMqttId", deviceId);
            }
            return deviceId;
        }

        public async Task ConnectAsync()
        {
            if (_client != null && _client.IsConnected) return;

            var factory = new MqttFactory();
            _client = factory.CreateMqttClient();

            var options = new MqttClientOptionsBuilder()
                .WithClientId(GetUniqueClientId())
                .WithWebSocketServer("ca773208669c41d8b2fdd366323c74d6.s1.eu.hivemq.cloud:8884/mqtt")
                .WithCredentials("Raz0911", "ROMR031109h")
                .WithTls()
                .WithCleanSession(false) // Mantenemos false para recibir lo que pasó mientras no estabas
                .Build();

            _client.UseDisconnectedHandler(async e =>
            {
                await Task.Delay(TimeSpan.FromSeconds(5));
                try { await _client.ConnectAsync(options); } catch { }
            });

            _client.UseConnectedHandler(async e =>
            {
                await _client.SubscribeAsync("Privada/AlertaGeneral");
            });

            _client.UseApplicationMessageReceivedHandler(e =>
            {
                if (e.ApplicationMessage.Topic == "Privada/AlertaGeneral")
                {
                    // VERIFICACIÓN DEL CANDADO:
                    // Si ya hay una alerta mostrándose, ignoramos cualquier mensaje nuevo
                    if (_alertaActiva) return;

                    MainThread.BeginInvokeOnMainThread(async () =>
                    {
                        try
                        {
                            _alertaActiva = true; // Cerramos el candado
                            _continuarVibrando = true;
                            _ = CicloDeVibracion();

                            // Esta línea detiene la ejecución hasta que el usuario presione "OK"
                            await Application.Current.MainPage.DisplayAlert("🚨 ALERTA", "¡Alarma activada en la privada!", "OK");

                            // Una vez presionado OK, limpiamos todo
                            _continuarVibrando = false;
                            Vibration.Default.Cancel();
                        }
                        finally
                        {
                            // Pequeña pausa de seguridad antes de permitir otra alerta
                            await Task.Delay(2000);
                            _alertaActiva = false; // Abrimos el candado para futuras emergencias
                        }
                    });
                }
            });

            try { await _client.ConnectAsync(options); } catch { }
        }

        private async Task CicloDeVibracion()
        {
            while (_continuarVibrando)
            {
                Vibration.Default.Vibrate(TimeSpan.FromSeconds(1));
                await Task.Delay(1100);
            }
        }

        // --- MÉTODOS DE CONTROL ---

        private async Task PublicarComandoAsync(string topico, int id, bool activar)
        {
            string nombreReal = Preferences.Get("NombreUsuario", DeviceInfo.Name);
            if (_client == null || !_client.IsConnected) await ConnectAsync();

            var payload = new { ID = id, Estatus = activar ? 1 : 0, Usuario = nombreReal };
            var message = new MqttApplicationMessageBuilder()
                .WithTopic(topico)
                .WithPayload(Encoding.UTF8.GetBytes(JsonSerializer.Serialize(payload)))
                .Build();
            await _client.PublishAsync(message);
        }

        public async Task AbrirPeatonalAsync(bool activar) => await PublicarComandoAsync("Privada/AbrirPuerta", 0, activar);
        public async Task AbrirPortonAsync(bool activar) => await PublicarComandoAsync("Privada/AbrirPorton", 1, activar);

        public async Task AlarmaVecinalAsync(bool activar)
        {
            string nombreVecino = Preferences.Get("NombreUsuario", "Vecino Desconocido");
            string mensajeAlerta = activar
                ? $"🚨 ¡ALERTA! {nombreVecino} ha ACTIVADO la alarma"
                : $"✅ {nombreVecino} ha desactivado la alarma";

            await PublicarComandoConMensajeAsync("Privada/AlarmaVecinal", 2, activar, mensajeAlerta);
        }

        private async Task PublicarComandoConMensajeAsync(string topico, int id, bool activar, string mensaje)
        {
            if (_client == null || !_client.IsConnected) await ConnectAsync();

            var payload = new
            {
                ID = id,
                Estatus = activar ? 1 : 0,
                Usuario = Preferences.Get("NombreUsuario", "Anonimo"),
                msg = mensaje
            };

            string json = JsonSerializer.Serialize(payload);

            var message = new MqttApplicationMessageBuilder()
                .WithTopic(topico)
                .WithPayload(Encoding.UTF8.GetBytes(json))
                .WithQualityOfServiceLevel(MQTTnet.Protocol.MqttQualityOfServiceLevel.AtLeastOnce)
                .Build();

            await _client.PublishAsync(message);
        }
    }
}