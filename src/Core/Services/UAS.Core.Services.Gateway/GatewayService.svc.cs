using System;

namespace UAS.Core.Services.Gateway
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "GatewayService" en el código, en svc y en el archivo de configuración a la vez.
    // NOTA: para iniciar el Cliente de prueba WCF para probar este servicio, seleccione GatewayService.svc o GatewayService.svc.cs en el Explorador de soluciones e inicie la depuración.
    public class GatewayService : IGatewayService
    {
        public string JSONData(string id)
        {
            return "Message " + id;
        }
    }
}
