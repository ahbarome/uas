using System;
using System.Linq;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.Attendance.Managers
{
    internal class MovementManager
    {
        /// <summary>
        /// 
        /// </summary>
        private MovementPersister _persister;
        private Action<string> _dispatcher;
        /// <summary>
        /// 
        /// </summary>
        public MovementManager()
        {
            _persister = new MovementPersister();
            _persister.SqlNotification += SqlDependencyNotifier;
        }

        /// <summary>
        /// 
        /// </summary>
        public MovementManager(Action<string> attendanceDispatcher = null)
        {
            _dispatcher = attendanceDispatcher;
            _persister = new MovementPersister();
            _persister.SqlNotification += SqlDependencyNotifier;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Movement> GetAllMovementsWithNotifications()
        {
            return _persister.GetAllMovementsWithNotifications();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Movement> GetAllMovementsWithoutNotifications()
        {
            return _persister.GetAllMovementsWithoutNotifications();
        }

        private void SqlDependencyNotifier(object sender, System.Data.SqlClient.SqlNotificationEventArgs e)
        {
            _dispatcher?.Invoke("Refresh");
        }
    }
}
