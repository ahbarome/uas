using System;
using System.Threading.Tasks;
using UAS.Core.DTO.Entities;
using UAS.Core.DTO.Parsers;
using UAS.Core.Mobile.BLL;

namespace UAS.Core.Mobile.BLLTest
{
    class Program
    {
        static void Main(string[] args)
        {
            var value = "{\"DocumentNumber\":1144428800,\"Name\":\"Byron Vicente\",\"LastName\":\"Escobar Estrada\",\"Program\":3711,\"University\":\"Universidad Libre Seccional Cali\"}";

            QRCodeDTO qrCode = DTOParser.JSONToQRCodeDTO(value);

            Console.WriteLine(qrCode.Name);
            Console.ReadLine();

            Task<SpaceDTOCollection> spaces = CoreFacade.GetAvailableSpaces();

            foreach(SpaceDTO space in spaces.Result)
            {
                Console.WriteLine(space.SpaceType + " " + space.SpaceName);
            }

            Console.WriteLine("Finished");
            Console.ReadLine();
        }
    }
}
