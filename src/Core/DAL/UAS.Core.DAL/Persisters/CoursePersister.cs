using System;
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
    }
}
