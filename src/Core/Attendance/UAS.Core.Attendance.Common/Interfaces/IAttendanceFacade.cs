namespace UAS.Core.Attendance.Interfaces
{
    public interface IAttendanceFacade
    {
        string GetAvailableSpacesForMovements();

        void GenerateMovement(string JSONMovementDTO);
    }
}
