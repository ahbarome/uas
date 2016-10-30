using Microsoft.VisualStudio.TestTools.UnitTesting;
using UAS.Core.DTO.Parsers;
using UAS.Core.DTO.Entities;
using System.Collections.Generic;

namespace UAS.Core.DTOTest
{
    [TestClass]
    public class DTOParserTest
    {
        [TestMethod]
        public void SpaceDTOToJSONTest()
        {
            var expectedJSONSpaceDTO = "{\"IdSpace\":1,\"SpaceName\":\"404\"}";
            var spaceDTO = new SpaceDTO { IdSpace = 1, SpaceName = "404" };
            var JSONSpaceDTO = DTOParser.SpaceDTOToJSON(spaceDTO);
            Assert.IsTrue(expectedJSONSpaceDTO.Equals(JSONSpaceDTO));
        }

        [TestMethod]
        public void JSONToSpaceDTOTest()
        {
            var JSONSpaceDTO = "{\"IdSpace\":1,\"SpaceName\":\"404\"}";
            var expectedSpaceDTO = new SpaceDTO { IdSpace = 1, SpaceName = "404" };
            var spaceDTO = DTOParser.JSONToSpaceDTO(JSONSpaceDTO);
            Assert.IsTrue(
                expectedSpaceDTO.IdSpace == spaceDTO.IdSpace &&
                expectedSpaceDTO.SpaceName == spaceDTO.SpaceName);
        }

        [TestMethod]
        public void MovementDTOToJSONTest()
        {
            var expectedJSONMovementDTO =
                "{\"UserId\":1130673647,\"Space\":{ \"IdSpace\":1,\"SpaceName\":\"404\"}}";
            var movementDTO = new MovementDTO
            {
                UserDocumentNumber = 1130673647,
                Space = 1
            };
            var JSONMovementeDTO = DTOParser.MovementDTOToJSON(movementDTO);
            Assert.IsTrue(expectedJSONMovementDTO.Equals(expectedJSONMovementDTO));
        }

        [TestMethod]
        public void JSONToMovementDTOTest()
        {
            var JSONMovementDTO =
                "{\"UserId\":1130673647,\"Space\":{ \"IdSpace\":1,\"SpaceName\":\"404\"}}";
            var expectedmovementDTO = new MovementDTO
            {
                UserDocumentNumber = 1130673647,
                Space = 1
            };
            var movementDTO = DTOParser.JSONToMovementDTO(JSONMovementDTO);
            Assert.IsTrue(
                expectedmovementDTO.UserDocumentNumber == movementDTO.UserDocumentNumber &&
                expectedmovementDTO.Space == movementDTO.Space);
        }

        [TestMethod]
        public void SpacesDTOToJSONTest()
        {
            var spacesDTO = 
                new List<SpaceDTO> {
                    new SpaceDTO { IdSpace = 1, SpaceName = "401", SpaceType= "Salón" },
                    new SpaceDTO { IdSpace = 2, SpaceName = "404", SpaceType= "Salón"  }
            };

            var expectedJSONSpacesDTO = "[{\"IdSpace\":1,\"SpaceName\":\"401\",\"SpaceType\":\"Salón\"},{\"IdSpace\":2,\"SpaceName\":\"404\",\"SpaceType\":\"Salón\"}]";
            var JSONSpacesDTO = DTOParser.SpacesDTOToJSON(spacesDTO);
            Assert.IsTrue(expectedJSONSpacesDTO.Equals(JSONSpacesDTO));
        }

        [TestMethod]
        public void JSONToSpacesDTOTest()
        {
            var expectedSpacesDTO =
                new List<SpaceDTO> {
                    new SpaceDTO { IdSpace = 1, SpaceName = "401" },
                    new SpaceDTO { IdSpace = 2, SpaceName = "404" }
            };

            var JSONSpacesDTO = "[{\"IdSpace\":1,\"SpaceName\":\"401\",\"SpaceType\":\"Salón\"},{\"IdSpace\":2,\"SpaceName\":\"404\",\"SpaceType\":\"Salón\"}]";
            var spacesDTO = DTOParser.JSONToSpacesDTO(JSONSpacesDTO);
            Assert.IsTrue(expectedSpacesDTO.Count == spacesDTO.Count);
        }
    }
}
