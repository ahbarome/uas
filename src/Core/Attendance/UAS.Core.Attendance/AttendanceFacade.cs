using System;
using System.Linq;
using UAS.Core.Attendance.Managers;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.Attendance
{
    public class AttendanceFacade
    {
        private MovementManager _movementManager;
        private Action<string> _dispatcher;

        public AttendanceFacade(Action<string> dispatcher = null)
        {
            this._dispatcher = dispatcher;
            _movementManager = new MovementManager(dispatcher);
        }

        public IQueryable<Movement> GetAllMovementsWithNotifications()
        {
            return _movementManager.GetAllMovementsWithNotifications();
        }
        public IQueryable<Movement> GetAllMovementsWithoutNotifications()
        {
            return _movementManager.GetAllMovementsWithoutNotifications();
        }

    }
}
