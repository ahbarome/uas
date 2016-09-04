using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class CoursePersister : BaseContext
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="teacherId"></param>
        /// <returns></returns>
        public Course GetCourseByTeacherId(int teacherId)
        {
            var course = base.Entities.Courses.FirstOrDefault();
            return course;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="teacherDocumentNumber"></param>
        /// <returns></returns>
        public Course GetCurrentCourseByTeacherDocumentNumber(int teacherDocumentNumber)
        {
            var current = base.Entities.GetCurrentCourseByTeacherDocumentNumber(teacherDocumentNumber).FirstOrDefault();

            if (current != null)
            {
                var course = new Course
                {
                    Id = current.CourseId,
                    Name = current.CourseName,
                    NumberOfCredits = current.CourseCredits,
                    Semester = current.AcademicSemester,
                    SpaceDescription = string.Format("{0} {1}", current.SpaceType, current.SpaceName),
                    StartTime = current.StartTime,
                    EndTime = current.EndTime
                };

                return course;
            }

            return null;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="teacherDocumentNumber"></param>
        /// <returns></returns>
        public List<Course> GetCoursesByTeacherDocumentNumber(int teacherDocumentNumber)
        {
            var courses = new List<Course>();
            var currentCourses = base.Entities.GetCurrentCourseByTeacherDocumentNumber(teacherDocumentNumber);

            if (currentCourses != null)
            {
                foreach (var currentCourse in currentCourses)
                {
                    var course = new Course
                    {
                        Id = currentCourse.CourseId,
                        Name = currentCourse.CourseName,
                        NumberOfCredits = currentCourse.CourseCredits,
                        Semester = currentCourse.AcademicSemester,
                        SpaceDescription = string.Format("{0} {1}", currentCourse.SpaceType, currentCourse.SpaceName),
                        StartTime = currentCourse.StartTime,
                        EndTime = currentCourse.EndTime
                    };

                    courses.Add(course);
                }
            }

            return courses;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="courseId"></param>
        /// <returns></returns>
        public Statistic GetCourseStatistics(int courseId)
        {
            var currentStatistics = base.Entities.GetCourseSummaryById(courseId);

            var statistic = new Statistic { Summary = new Dictionary<string, int>() };

            foreach (var currentStatistic in currentStatistics)
            {
                statistic.Id = currentStatistic.CourseId;
                statistic.Description = currentStatistic.CourseName;

                if (statistic.Summary.ContainsKey(currentStatistic.EnrollmentStatus))
                {
                    statistic.Summary[currentStatistic.EnrollmentStatus] +=
                        statistic.Summary[currentStatistic.EnrollmentStatus] + currentStatistic.Total ?? 0;
                }
                else
                {
                    statistic.Summary.Add(currentStatistic.EnrollmentStatus, currentStatistic.Total ?? 0);
                }
            }

            return statistic;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="teacherDocumentNumber"></param>
        /// <returns></returns>
        public Statistic GetCurrentCourseStatistics(int teacherDocumentNumber)
        {
            var currentStatistics = base.Entities.GetCurrentCourseSummaryByTeacherDocumentNumber(teacherDocumentNumber);

            var statistic = new Statistic { Summary = new Dictionary<string, int>() };

            foreach (var currentStatistic in currentStatistics)
            {
                statistic.Id = currentStatistic.CourseId ?? 0;
                statistic.Description = currentStatistic.CourseName;

                if (statistic.Summary.ContainsKey(currentStatistic.EnrollmentStatus))
                {
                    statistic.Summary[currentStatistic.EnrollmentStatus] +=
                        statistic.Summary[currentStatistic.EnrollmentStatus] + currentStatistic.Total ?? 0;
                }
                else
                {
                    statistic.Summary.Add(currentStatistic.EnrollmentStatus, currentStatistic.Total ?? 0);
                }
            }

            return statistic;
        }
    }
}
