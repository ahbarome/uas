using RestSharp;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using UAS.Core.Mobile.BLL.Helper;

namespace UAS.Core.Mobile.BLL.Proxy
{
    internal class UASProxy
    {
        #region Properties

        protected internal string BaseURL
        {
            get
            {
                return Constants.BaseUrl;
            }
        }

        protected WebHeaderCollection HeaderCollection
        {
            get
            {
                WebHeaderCollection headerCollection = new System.Net.WebHeaderCollection();
                headerCollection.Add(Constants.KeyContentType, Constants.KeyContentTypeValue);

                return headerCollection;
            }
        }

        protected WebClient ServiceWebClient
        {
            get
            {
                WebClient webClient = new WebClient();
                webClient.Headers = this.HeaderCollection;

                return webClient;
            }
        }

        protected RestClient ServiceRestClient
        {
            get
            {
                return new RestClient(BaseURL);
            }
        }

        #endregion

        #region Methods

        private RestRequest BuildRequest(string operation, string parameters = "")
        {
            var request = new RestRequest(operation, Method.GET);

            return request;
        }

        protected internal string Execute(string operation, string parameters = "")
        {
            var result = string.Empty;

            var request = BuildRequest(operation, parameters);
            var response = ServiceRestClient.Execute(request);

            if (response.ResponseStatus.Equals(ResponseStatus.Completed))
            {
                result = response.Content;
            }

            return result;
        }

        protected internal async Task<string> ExecuteAsync(string operation, string parameters = "")
        {
            var result = string.Empty;

            var request = BuildRequest(operation, parameters);
            var token = new CancellationTokenSource();
            var response = await ServiceRestClient.ExecuteTaskAsync(request, token.Token);

            if (response.ResponseStatus.Equals(ResponseStatus.Completed))
            {
                result = response.Content;
            }

            return result;
        }

        #endregion
    }
}
