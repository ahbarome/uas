using System.ServiceModel;
using System.ServiceModel.Web;

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
        string GetAvailablesSpaces();


        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "json/GenerateMovement/{JSONMovement}")]
        void GenerateMovement(string JSONMovement);
    }
}
