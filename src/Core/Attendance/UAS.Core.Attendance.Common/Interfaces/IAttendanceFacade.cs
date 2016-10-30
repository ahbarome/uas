using UAS.Core.DTO.Entities;

namespace UAS.Core.Attendance.Interfaces
{
    public interface IAttendanceFacade
    {
        SpaceDTOCollection GetAvailableSpacesForMovements();

        void GenerateMovement(MovementDTO movementDTO);
    }
}
