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

        /// <summary>
        /// 
        /// </summary>
        public MovementManager() {
            _persister = new MovementPersister();
            _persister.SqlNotification += SqlDependencyNotifier;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Movement> Get() {
            
            return _persister.GetAllMovements();
        }

        private void SqlDependencyNotifier(object sender, System.Data.SqlClient.SqlNotificationEventArgs e)
        {
            System.Console.WriteLine("Pasó");
        }
    }
}
