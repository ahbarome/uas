namespace UAS.Core.Dashboard.Managers
{
    using System;
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

        internal AcademicPeriodView GetCurrentAcademicPeriod()
        {
            return _dashboardPersister.GetCurrentAcademicPeriod();
        }

        internal List<Statistic> GetStatistictsAttendanceVsNonAttendance()
        {
            return _dashboardPersister.GetStatistictsAttendanceVsNonAttendance();
        }

        internal List<Statistic> GetTopStatistictsMajorMonthsAttendanceAndNonAttendance()
        {
            var topStatistics =
                _dashboardPersister.GetTopStatistictsMajorMonthsAttendanceAndNonAttendance();
            var totalStatistics = SumStatisticsTotal(topStatistics);
            UpdateStatisticsPercentage(topStatistics, totalStatistics);
            return topStatistics;
        }

        internal List<Statistic> GetTopStatistictAttendanceAndNonAttendanceTeacherCourse()
        {
            var topStatistics =
                _dashboardPersister.GetTopStatistictAttendanceAndNonAttendanceTeacherCourse();
            var totalStatistics = SumStatisticsTotal(topStatistics);
            UpdateStatisticsPercentage(topStatistics, totalStatistics);
            return topStatistics;
        }

        internal List<Statistic> GetTopStatistictAttendanceAndNonAttendanceStudentCourse()
        {
            var topStatistics =
                _dashboardPersister.GetTopStatistictAttendanceAndNonAttendanceStudentCourse();
            var totalStatistics = SumStatisticsTotal(topStatistics);
            UpdateStatisticsPercentage(topStatistics, totalStatistics);
            return topStatistics;
        }

        internal List<Statistic> GetTopStatistictsMajorCourseAttendanceAndNonAttendance()
        {
            var topStatistics =
                _dashboardPersister.GetTopStatistictsMajorCourseAttendanceAndNonAttendance();
            var totalStatistics = SumStatisticsTotal(topStatistics);
            UpdateStatisticsPercentage(topStatistics, totalStatistics);
            return topStatistics;
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
