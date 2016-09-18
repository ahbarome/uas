using Newtonsoft.Json;
using System.Collections.Generic;
using UAS.Core.DTO.Entities;

namespace UAS.Core.DTO.Parsers
{
    /// <summary>
    /// Parser for DTO's
    /// </summary>
    public static class DTOParser
    {
        /// <summary>
        /// Parse a SpaceDTO entity into a JSON structure
        /// </summary>
        /// <param name="spaceDTO">DTO to parse into a JSON</param>
        /// <returns>JSON representation of the current DTO object</returns>
        public static string SpaceDTOToJSON(SpaceDTO spaceDTO)
        {
            return JsonConvert.SerializeObject(spaceDTO);
        }

        /// <summary>
        /// Parse a List of SpaceDTO entities into a JSON structure
        /// </summary>
        /// <param name="spacesDTO">List of DTO's to parse into a JSON</param>
        /// <returns>JSON representation of the current List of DTO's objects</returns>
        public static string SpacesDTOToJSON(List<SpaceDTO> spacesDTO)
        {
            return JsonConvert.SerializeObject(spacesDTO);
        }

        /// <summary>
        /// Convert a JSON into a SpaceDTO entity
        /// </summary>
        /// <param name="JSONSpaceDTO">JSON string to parse into the DTO entity</param>
        /// <returns>SpaceDTO object</returns>
        public static SpaceDTO JSONToSpaceDTO(string JSONSpaceDTO)
        {
            var spaceDTO = JsonConvert.DeserializeObject<SpaceDTO>(JSONSpaceDTO);
            return spaceDTO;
        }

        /// <summary>
        /// Parse a MovementDTO entity into a JSON structure
        /// </summary>
        /// <param name="spaceDTO">DTO to parse into a JSON</param>
        /// <returns>JSON representation of the current DTO object</returns>
        public static string MovementDTOToJSON(MovementDTO movementDTO)
        {
            return JsonConvert.SerializeObject(movementDTO);
        }

        /// <summary>
        /// Convert a JSON into a MovementDTO entity
        /// </summary>
        /// <param name="jsonSpaceDTO">JSON string to parse into the DTO entity</param>
        /// <returns>MovementDTO object</returns>
        public static MovementDTO JSONToMovementDTO(string JSONMovementDTO)
        {
            var movementDTO = JsonConvert.DeserializeObject<MovementDTO>(JSONMovementDTO);
            return movementDTO;
        }
    }
}
