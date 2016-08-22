namespace UAS.Core.DAL.Persisters
{
    public  class DashboardPersister: BaseContext
    {
        public void GetStatistictsAttendanceVsNonAttendance()
        {
            var statistics = base.Entities.GetStatistictsAttendanceVsNonAttendance();
        }
    }
}
