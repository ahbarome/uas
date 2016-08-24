using System.Collections.Generic;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class DashboardPersister : BaseContext
    {
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public List<Statistic> GetStatistictsAttendanceVsNonAttendance()
        {
            var statistics = new List<Statistic>();

            var statisticsAttendanceVsNonAttendance =
                base.Entities.GetStatistictsAttendanceVsNonAttendance();

            foreach (var statisticAttendanceVsNonAttendance in statisticsAttendanceVsNonAttendance)
            {
                var statistic = new Statistic() { Summary = new Dictionary<string, int>() };
                statistic.Description = statisticAttendanceVsNonAttendance.EventDateMonthName;
                statistic.Summary.Add(
                    statisticAttendanceVsNonAttendance.EventType,
                    statisticAttendanceVsNonAttendance.EventTotal ?? 0);
                statistics.Add(statistic);
            }

            return statistics;
        }
    }
}
