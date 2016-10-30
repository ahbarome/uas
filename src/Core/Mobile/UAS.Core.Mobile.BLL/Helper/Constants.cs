namespace UAS.Core.Mobile.BLL.Helper
{
    internal static class Constants
    {
        internal const string BaseUrl = "http://uasgateway.azurewebsites.net/GatewayService.svc";

        internal const string OperationGetSpaces = "/json/GetAvailablesSpaces";

        internal const string OperationGenerateMovement = "/json/GenerateMovement/{0}";

        internal const string KeyContentType = "Content-Type";

        internal const string KeyContentTypeValue = "application/json; charset=utf-8";
    }
}
