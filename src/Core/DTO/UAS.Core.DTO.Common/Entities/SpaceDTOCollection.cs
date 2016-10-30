using System.Collections.Generic;

namespace UAS.Core.DTO.Entities
{
    public class SpaceDTOCollection : List<SpaceDTO>
    {
        public SpaceDTOCollection() : base() {}
        public SpaceDTOCollection(IEnumerable<SpaceDTO> collection) : base(collection) { }
    }
}
