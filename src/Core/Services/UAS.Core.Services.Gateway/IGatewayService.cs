using System.ServiceModel;
using System.ServiceModel.Web;

namespace UAS.Core.Services.Gateway
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "IGatewayService" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface IGatewayService
    {
        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "json/{id}")]
        string JSONData(string id);
    }
}
