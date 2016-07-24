using System;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class CoursePersister : BaseContext
    {
        public Course GetCourseByTeacherId(int teacherId)
        {
            var course = base.Entities.Courses.FirstOrDefault();
            return course;
        }
    }
}
