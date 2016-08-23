namespace UAS.Core.Dashboard.Managers
{
    using System.Collections.Generic;
    using DAL.Common.Model;
    using DAL.Persisters;

    internal class DashboardAttendanceManager
    {
        private DashboardPersister _dashboardPersister;

        public DashboardAttendanceManager()
        {
            _dashboardPersister = new DashboardPersister();
        }

        internal List<Statistic> GetStatistictsAttendanceVsNonAttendance()
        {
            return _dashboardPersister.GetStatistictsAttendanceVsNonAttendance();
        }
    }
}
