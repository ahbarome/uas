using System.ServiceModel;
using System.ServiceModel.Web;
using UAS.Core.DTO.Entities;

namespace UAS.Core.Services.Gateway
{
    [ServiceContract]
    public interface IGatewayService
    {
        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "json/JSONData/{id}")]
        string JSONData(string id);

        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "json/GetAvailablesSpaces")]
        SpaceDTOCollection GetAvailablesSpaces();


        [OperationContract]
        [WebInvoke(Method = "POST",
            ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "json/GenerateMovement")]
        void GenerateMovement(MovementDTO movement);
    }
}
