using System.Collections.Generic;
using System.Threading.Tasks;
using UAS.Core.DTO.Entities;
using UAS.Core.Mobile.BLL.Controller;

namespace UAS.Core.Mobile.BLL
{
    public static class CoreFacade
    {
        private static ServiceController service;

        private static ServiceController Service
        {
            get
            {
                service = service ?? new ServiceController();

                return service;
            }
        }

        public static async Task<SpaceDTOCollection> GetAvailableSpaces()
        {
            return await Service.GetAvailableSpaces();
        }

        public static async Task GenerateMovement(MovementDTO movement)
        {
            await Service.GenerateMovement(movement);
        }
    }
}
