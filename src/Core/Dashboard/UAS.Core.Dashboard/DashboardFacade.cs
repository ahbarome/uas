using System.Collections.Generic;
using UAS.Core.DAL.Common.Model;
using UAS.Core.Dashboard.Managers;

namespace UAS.Core.Dashboard
{
    public class DashboardFacade
    {
        private DashboardAttendanceManager _dashboarAttendanceManager;
        private DashboardExcuseManager _dashboardExcuseManager;

        public DashboardFacade()
        {
            _dashboarAttendanceManager = new DashboardAttendanceManager();
            _dashboardExcuseManager = new DashboardExcuseManager();
        }

        public AcademicPeriodView GetCurrentAcademicPeriod()
        {
            return _dashboarAttendanceManager.GetCurrentAcademicPeriod();
        }

        public List<Statistic> GetStatistictsAttendanceVsNonAttendance()
        {
            return _dashboarAttendanceManager.GetStatistictsAttendanceVsNonAttendance();
        }
        public List<Statistic> GetTopStatistictExcuseClassifications()
        {
            return _dashboardExcuseManager.GetTopStatistictExcuseClassifications();
        }

        public List<Statistic> GetStatistictExcuseStatus()
        {
            return _dashboardExcuseManager.GetStatistictExcuseStatus();
        }

        public List<Statistic> GetTopStatistictsMajorMonthsAttendanceAndNonAttendance()
        {
            return _dashboarAttendanceManager.GetTopStatistictsMajorMonthsAttendanceAndNonAttendance();
        }

        public List<Statistic> GetTopStatistictAttendanceAndNonAttendanceTeacherCourse()
        {
            return _dashboarAttendanceManager.GetTopStatistictAttendanceAndNonAttendanceTeacherCourse();
        }

        public List<Statistic> GetTopStatistictAttendanceAndNonAttendanceStudentCourse()
        {
            return _dashboarAttendanceManager.GetTopStatistictAttendanceAndNonAttendanceStudentCourse();
        }

        public List<Statistic> GetTopStatistictsMajorCourseAttendanceAndNonAttendance()
        {
            return _dashboarAttendanceManager.GetTopStatistictsMajorCourseAttendanceAndNonAttendance();
        }
    }
}
