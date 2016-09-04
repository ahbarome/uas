using System.Linq;
using System.Collections.Generic;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    /// <summary>
    /// Manages
    /// </summary>
    public class DashboardPersister : BaseContext
    {
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public AcademicPeriodView GetCurrentAcademicPeriod()
        {
            var currentAcademicPeriod = base.Entities.GetCurrentAcademicPeriod().FirstOrDefault();

            var academicPeriod = new AcademicPeriodView
            {
                Id = currentAcademicPeriod.Id,
                Period = currentAcademicPeriod.Period,
                Semester = currentAcademicPeriod.Semester,
                SemesterAlias = currentAcademicPeriod.SemesterAlias,
                StartDate = currentAcademicPeriod.StartDate,
                EndDate = currentAcademicPeriod.EndDate,
                StartDateMonthName = currentAcademicPeriod.StartDateMonthName,
                EndDateMonthName = currentAcademicPeriod.EndDateMonthName
            };

            return academicPeriod;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public List<Statistic> GetStatistictsAttendanceVsNonAttendance(
            int? documentNumber = null, int? roleId = null)
        {
            var statistics = new List<Statistic>();

            var statisticsAttendanceVsNonAttendance =
                base.Entities.GetStatistictsAttendanceVsNonAttendance(documentNumber, roleId);

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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="documentNumber"></param>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public List<Statistic> GetTopStatistictExcuseClassifications(
            int? documentNumber = null, int? roleId = null)
        {
            var statistics = new List<Statistic>();

            var topStatistictExcuseClassifications = 
                base.Entities.GetTopStatistictExcuseClassifications(documentNumber, roleId);

            foreach (var statistictExcuseClassification in topStatistictExcuseClassifications)
            {
                var statistic = new Statistic() { Summary = new Dictionary<string, int>() };

                statistic.Description = statistictExcuseClassification.Classification;
                statistic.Total = statistictExcuseClassification.Total ?? 0;
                statistic.Percentage = decimal.Parse(statistictExcuseClassification.Percentage);
                statistic.Summary.Add(
                    statistictExcuseClassification.ResultAlias,
                    statistictExcuseClassification.Total ?? 0);

                statistics.Add(statistic);
            }

            return statistics;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="documentNumber"></param>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public List<Statistic> GetStatistictExcuseStatus(
            int? documentNumber = null, int? roleId = null)
        {
            var statistics = new List<Statistic>();

            var statisticExcuseStatus = 
                base.Entities.GetStatistictExcuseStates(documentNumber, roleId);

            foreach (var statistictExcuseStatus in statisticExcuseStatus)
            {
                var statistic = new Statistic() { Summary = new Dictionary<string, int>() };

                statistic.Description = statistictExcuseStatus.Status;
                statistic.Total = statistictExcuseStatus.Total ?? 0;
                statistic.Percentage = decimal.Parse(statistictExcuseStatus.Percentage);
                statistic.Summary.Add(
                    statistictExcuseStatus.ResultAlias,
                    statistictExcuseStatus.Total ?? 0);

                statistics.Add(statistic);
            }

            return statistics;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="documentNumber"></param>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public List<Statistic> GetTopStatistictsMajorMonthsAttendanceAndNonAttendance(
            int? documentNumber = null, int? roleId = null)
        {
            var statistics = new List<Statistic>();

            var statisticExcuseStatus = 
                base.Entities.GetTopStatistictsMajorMonthsAttendanceAndNonAttendance(
                    documentNumber, roleId);

            foreach (var statistictExcuseStatus in statisticExcuseStatus)
            {
                var statistic = new Statistic() { Summary = new Dictionary<string, int>() };

                statistic.EventType = statistictExcuseStatus.EventType;
                statistic.Description = statistictExcuseStatus.EventDateMonthName;
                statistic.Total = statistictExcuseStatus.EventTotal ?? 0;
                statistic.Summary.Add(
                    statistictExcuseStatus.EventType,
                    statistictExcuseStatus.EventTotal ?? 0);

                statistics.Add(statistic);
            }

            return statistics;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="documentNumber"></param>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public List<Statistic> GetTopStatistictAttendanceAndNonAttendanceStudentCourse(
            int? documentNumber = null, int? roleId = null)
        {
            var statistics = new List<Statistic>();

            var statisticExcuseStatus = 
                base.Entities.GetTopStatistictAttendanceAndNonAttendanceStudentCourse(
                    documentNumber, roleId);

            foreach (var statistictExcuseStatus in statisticExcuseStatus)
            {
                var statistic = new Statistic() { Summary = new Dictionary<string, int>() };

                statistic.EventType = statistictExcuseStatus.EventType;
                statistic.EventTypeAlias = statistictExcuseStatus.EventTypeAlias;
                statistic.ImageRelativePath = statistictExcuseStatus.PersonImageRelativePath;
                statistic.Description = statistictExcuseStatus.CourseName;
                statistic.AdditionalDescription = statistictExcuseStatus.PersonFullName;
                statistic.Total = statistictExcuseStatus.EventTotal ?? 0;
                statistic.Summary.Add(
                    statistictExcuseStatus.EventType,
                    statistictExcuseStatus.EventTotal ?? 0);

                statistics.Add(statistic);
            }

            return statistics;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="documentNumber"></param>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public List<Statistic> GetTopStatistictAttendanceAndNonAttendanceTeacherCourse(
            int? documentNumber = null, int? roleId = null)
        {
            var statistics = new List<Statistic>();

            var statisticExcuseStatus = base.Entities.GetTopStatistictAttendanceAndNonAttendanceTeacherCourse();

            foreach (var statistictExcuseStatus in statisticExcuseStatus)
            {
                var statistic = new Statistic() { Summary = new Dictionary<string, int>() };

                statistic.EventType = statistictExcuseStatus.EventType;
                statistic.EventTypeAlias = statistictExcuseStatus.EventTypeAlias;
                statistic.ImageRelativePath = statistictExcuseStatus.PersonImageRelativePath;
                statistic.Description = statistictExcuseStatus.CourseName;
                statistic.AdditionalDescription = statistictExcuseStatus.PersonFullName;
                statistic.Total = statistictExcuseStatus.EventTotal ?? 0;
                statistic.Summary.Add(
                    statistictExcuseStatus.EventType,
                    statistictExcuseStatus.EventTotal ?? 0);

                statistics.Add(statistic);
            }

            return statistics;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="documentNumber"></param>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public List<Statistic> GetTopStatistictsMajorCourseAttendanceAndNonAttendance(
            int? documentNumber = null, int? roleId = null)
        {
            var statistics = new List<Statistic>();

            var statisticExcuseStatus = 
                base.Entities.GetTopStatistictsMajorCourseAttendanceAndNonAttendance(
                    documentNumber, roleId);

            foreach (var statistictExcuseStatus in statisticExcuseStatus)
            {
                var statistic = new Statistic() { Summary = new Dictionary<string, int>() };

                statistic.EventType = statistictExcuseStatus.EventType;
                statistic.Description = statistictExcuseStatus.EventDateMonthName;
                statistic.AdditionalDescription = statistictExcuseStatus.EventCourseName;
                statistic.Total = statistictExcuseStatus.EventTotal ?? 0;
                statistic.Summary.Add(
                    statistictExcuseStatus.EventType,
                    statistictExcuseStatus.EventTotal ?? 0);

                statistics.Add(statistic);
            }

            return statistics;
        }
    }
}
