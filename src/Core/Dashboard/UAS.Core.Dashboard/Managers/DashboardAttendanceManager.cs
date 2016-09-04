namespace UAS.Core.Dashboard.Managers
{
    using System.Collections.Generic;
    using DAL.Common.Model;
    using DAL.Parsers;
    using DAL.Persisters;

    internal class DashboardAttendanceManager
    {
        private DashboardPersister _dashboardPersister;

        public DashboardAttendanceManager()
        {
            _dashboardPersister = new DashboardPersister();
        }

        internal AcademicPeriodView GetCurrentAcademicPeriod()
        {
            return _dashboardPersister.GetCurrentAcademicPeriod();
        }

        internal List<Statistic> GetStatistictsAttendanceVsNonAttendance(int documentNumber, int roleId)
        {
            var role = ModelEnumParser.RoleParser(roleId);

            if (role == DAL.Common.Model.Enums.Role.ADMIN || role == DAL.Common.Model.Enums.Role.DIRECTOR)
            {
                return _dashboardPersister.GetStatistictsAttendanceVsNonAttendance();
            }

            return _dashboardPersister.GetStatistictsAttendanceVsNonAttendance(documentNumber, roleId); ;
        }

        internal List<Statistic> GetTopStatistictsMajorMonthsAttendanceAndNonAttendance(int documentNumber, int roleId)
        {
            var role = ModelEnumParser.RoleParser(roleId);

            if (role == DAL.Common.Model.Enums.Role.ADMIN || role == DAL.Common.Model.Enums.Role.DIRECTOR)
            {
                var topStatistics =
                _dashboardPersister.GetTopStatistictsMajorMonthsAttendanceAndNonAttendance();
                var totalStatistics = SumStatisticsTotal(topStatistics);
                UpdateStatisticsPercentage(topStatistics, totalStatistics);
                return topStatistics;
            }
            else
            {
                var topStatistics =
                _dashboardPersister.GetTopStatistictsMajorMonthsAttendanceAndNonAttendance(documentNumber, roleId);
                var totalStatistics = SumStatisticsTotal(topStatistics);
                UpdateStatisticsPercentage(topStatistics, totalStatistics);
                return topStatistics;
            }
        }

        internal List<Statistic> GetTopStatistictAttendanceAndNonAttendanceTeacherCourse(int documentNumber, int roleId)
        {
            var topStatistics =
                _dashboardPersister.GetTopStatistictAttendanceAndNonAttendanceTeacherCourse(documentNumber, roleId);
            var totalStatistics = SumStatisticsTotal(topStatistics);
            UpdateStatisticsPercentage(topStatistics, totalStatistics);
            return topStatistics;
        }

        internal List<Statistic> GetTopStatistictAttendanceAndNonAttendanceStudentCourse(int documentNumber, int roleId)
        {
            var role = ModelEnumParser.RoleParser(roleId);

            if (role == DAL.Common.Model.Enums.Role.ADMIN || role == DAL.Common.Model.Enums.Role.DIRECTOR)
            {
                var topStatistics =
                _dashboardPersister.GetTopStatistictAttendanceAndNonAttendanceStudentCourse();
                var totalStatistics = SumStatisticsTotal(topStatistics);
                UpdateStatisticsPercentage(topStatistics, totalStatistics);
                return topStatistics;
            }
            else
            {
                var topStatistics =
                _dashboardPersister.GetTopStatistictAttendanceAndNonAttendanceStudentCourse(documentNumber, roleId);
                var totalStatistics = SumStatisticsTotal(topStatistics);
                UpdateStatisticsPercentage(topStatistics, totalStatistics);
                return topStatistics;
            }
        }

        internal List<Statistic> GetTopStatistictsMajorCourseAttendanceAndNonAttendance(int documentNumber, int roleId)
        {
            var role = ModelEnumParser.RoleParser(roleId);

            if (role == DAL.Common.Model.Enums.Role.ADMIN || role == DAL.Common.Model.Enums.Role.DIRECTOR)
            {
                var topStatistics =
                _dashboardPersister.GetTopStatistictsMajorCourseAttendanceAndNonAttendance();
                var totalStatistics = SumStatisticsTotal(topStatistics);
                UpdateStatisticsPercentage(topStatistics, totalStatistics);
                return topStatistics;
            }
            else
            {
                var topStatistics =
                _dashboardPersister.GetTopStatistictsMajorCourseAttendanceAndNonAttendance(documentNumber, roleId);
                var totalStatistics = SumStatisticsTotal(topStatistics);
                UpdateStatisticsPercentage(topStatistics, totalStatistics);
                return topStatistics;
            }
        }

        private void UpdateStatisticsPercentage(List<Statistic> statistics, int totalStatistics)
        {
            statistics.ForEach(
                statistic => statistic.Percentage = (decimal)statistic.Total / totalStatistics);
        }

        private int SumStatisticsTotal(List<Statistic> statistics)
        {
            var total = 0;
            statistics.ForEach(statistic => total += statistic.Total);
            return total;
        }
    }
}
