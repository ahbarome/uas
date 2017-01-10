using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using UAS.Core.DTO.Entities;
using UAS.Core.DTO.Parsers;
using UAS.Core.Mobile.BLL.Helper;
using UAS.Core.Mobile.BLL.Proxy;

namespace UAS.Core.Mobile.BLL.Controller
{
    internal class ServiceController
    {
        private UASProxy proxy;

        private UASProxy Proxy
        {
            get
            {
                proxy = proxy ?? new UASProxy();

                return proxy;
            }
        }

        internal async Task<SpaceDTOCollection> GetAvailableSpaces()
        {
            var response = await Proxy.ExecuteAsync(Constants.OperationGetSpaces, RestSharp.Method.GET);

            var result = DTOParser.JSONToSpacesDTOResult(response);

            return result;
        }

        internal async Task GenerateMovement(MovementDTO movement)
        {
            var request = DTOParser.MovementDTOToJSON(movement);

            await Proxy.ExecuteAsync(Constants.OperationGenerateMovement, RestSharp.Method.POST, bodyObject: movement);
        }
    }
}
