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

        public List<Statistic> GetStatistictsAttendanceVsNonAttendance(int documentNumber, int roleId)
        {
            return _dashboarAttendanceManager.GetStatistictsAttendanceVsNonAttendance(documentNumber, roleId);
        }
        public List<Statistic> GetTopStatistictExcuseClassifications(int documentNumber, int roleId)
        {
            return _dashboardExcuseManager.GetTopStatistictExcuseClassifications(documentNumber, roleId);
        }

        public List<Statistic> GetStatistictExcuseStatus(int documentNumber, int roleId)
        {
            return _dashboardExcuseManager.GetStatistictExcuseStatus(documentNumber, roleId);
        }

        public List<Statistic> GetTopStatistictsMajorMonthsAttendanceAndNonAttendance(int documentNumber, int roleId)
        {
            return _dashboarAttendanceManager.
                GetTopStatistictsMajorMonthsAttendanceAndNonAttendance(documentNumber, roleId);
        }

        public List<Statistic> GetTopStatistictAttendanceAndNonAttendanceTeacherCourse(int documentNumber, int roleId)
        {
            return _dashboarAttendanceManager.
                GetTopStatistictAttendanceAndNonAttendanceTeacherCourse(documentNumber, roleId);
        }

        public List<Statistic> GetTopStatistictAttendanceAndNonAttendanceStudentCourse(int documentNumber, int roleId)
        {
            return _dashboarAttendanceManager.
                GetTopStatistictAttendanceAndNonAttendanceStudentCourse(documentNumber, roleId);
        }

        public List<Statistic> GetTopStatistictsMajorCourseAttendanceAndNonAttendance(int documentNumber, int roleId)
        {
            return _dashboarAttendanceManager.
                GetTopStatistictsMajorCourseAttendanceAndNonAttendance(documentNumber, roleId);
        }
    }
}
