using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.Attendance.Managers
{
    internal class CourseManager
    {
        private CoursePersister _coursePersister;

        public CourseManager() {
            _coursePersister = new CoursePersister();
        }

        internal Course GetCourseByTeacherId(int teacherId)
        {
            return _coursePersister.GetCourseByTeacherId(teacherId);
        }

        internal Course GetCurrentCourseByTeacherDocumentNumber(int teacherDocumentNumber)
        {
            return _coursePersister.GetCurrentCourseByTeacherDocumentNumber(teacherDocumentNumber);
        }

        internal object GetStatisticsByCourseAndTeacherId(int courseId, int teacherId)
        {
            return _coursePersister.GetCourseByTeacherId(teacherId);
        }
    }
}