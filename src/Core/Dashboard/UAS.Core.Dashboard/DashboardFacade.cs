using System.Collections.Generic;
using UAS.Core.DAL.Common.Model;
using UAS.Core.Dashboard.Managers;

namespace UAS.Core.Dashboard
{
    public class DashboardFacade
    {
        private DashboardAttendanceManager _dashboarAttendanceManager;

        public DashboardFacade()
        {
            _dashboarAttendanceManager = new DashboardAttendanceManager();
        }

        public List<Statistic> GetStatistictsAttendanceVsNonAttendance()
        {
            return _dashboarAttendanceManager.GetStatistictsAttendanceVsNonAttendance();
        }
    }
}
