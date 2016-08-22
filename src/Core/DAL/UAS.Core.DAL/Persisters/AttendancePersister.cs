using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class AttendancePersister : BaseContext
    {
        public IQueryable<AttendanceView> GetAttendance()
        {
            var attendances = base.Entities.AttendanceView;
            return attendances;
        }
    }
}
