namespace UAS.Core.Dashboard.Managers
{
    using DAL.Persisters;

    internal class DashboardAttendanceManager
    {
        private DashboardPersister _dashboardPersister;

        public DashboardAttendanceManager() {
            _dashboardPersister = new DashboardPersister();
        }

        internal void GetStatistictsAttendanceVsNonAttendance()
        {
            _dashboardPersister.GetStatistictsAttendanceVsNonAttendance();
        }
    }
}
