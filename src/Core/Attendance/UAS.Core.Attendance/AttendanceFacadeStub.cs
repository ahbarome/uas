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
            var spaces = "[{\"IdSpace\":10000,\"SpaceName\":\"301\",\"SpaceType\":\"Salón\"}," +
                "{\"IdSpace\":10001,\"SpaceName\":\"302\",\"SpaceType\":\"Salón\"}," +
                "{\"IdSpace\":10002,\"SpaceName\":\"303\",\"SpaceType\":\"Salón\"}," +
                "{\"IdSpace\":10003,\"SpaceName\":\"304\",\"SpaceType\":\"Salón\"}," +
                "{\"IdSpace\":10004,\"SpaceName\":\"401\",\"SpaceType\":\"Salón\"}," +
                "{\"IdSpace\":10005,\"SpaceName\":\"402\",\"SpaceType\":\"Salón\"}," +
                "{\"IdSpace\":10006,\"SpaceName\":\"403\",\"SpaceType\":\"Salón\"}," +
                "{\"IdSpace\":10007,\"SpaceName\":\"501\",\"SpaceType\":\"Sala\"}," +
                "{\"IdSpace\":10008,\"SpaceName\":\"502\",\"SpaceType\":\"Sala\"}," +
                "{\"IdSpace\":10009,\"SpaceName\":\"503\",\"SpaceType\":\"Sala\"}," +
                "{\"IdSpace\":10010,\"SpaceName\":\"504\",\"SpaceType\":\"Sala\"}]";
            return spaces;
        }
    }
}
