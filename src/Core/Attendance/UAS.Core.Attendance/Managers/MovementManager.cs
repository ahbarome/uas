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
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Movement> Get() {
            return _persister.Get();
        }
    }
}
