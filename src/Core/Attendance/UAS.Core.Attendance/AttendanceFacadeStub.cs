using UAS.Core.Attendance.Interfaces;

namespace UAS.Core.Attendance
{
    public class AttendanceFacadeStub : IAttendanceFacade
    {
        public void GenerateMovement(string JSONMovementDTO)
        {
            return;
        }

        public string GetAvailableSpacesForMovements()
        {
            var spaces = "[{\"IdSpace\":10000,\"SpaceName\":\"301\"},{\"IdSpace\":10001,\"SpaceName\":\"302\"},{\"IdSpace\":10002,\"SpaceName\":\"303\"},{\"IdSpace\":10003,\"SpaceName\":\"304\"},{\"IdSpace\":10004,\"SpaceName\":\"401\"},{\"IdSpace\":10005,\"SpaceName\":\"402\"},{\"IdSpace\":10006,\"SpaceName\":\"403\"},{\"IdSpace\":10007,\"SpaceName\":\"501\"},{\"IdSpace\":10008,\"SpaceName\":\"502\"},{\"IdSpace\":10009,\"SpaceName\":\"503\"},{\"IdSpace\":10010,\"SpaceName\":\"504\"}]";
            return spaces;
        }
    }
}
