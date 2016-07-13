using System.Linq;
using UAS.Core.Attendance.Managers;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.Attendance
{
    public class AttendanceFacade
    {
        private MovementManager _movementManager;

        public AttendanceFacade() {
            _movementManager = new MovementManager();
        }

        public IQueryable<Movement> Get() {
            return _movementManager.Get();
        }
    }
}
