using System.Runtime.Serialization;

namespace UAS.Core.DTO.Entities
{
    [DataContract]
    public class MovementDTO
    {
        [DataMember]
        public int UserDocumentNumber { get; set; }
        [DataMember]
        public int Space { get; set; }
    }
}
