using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Parsers;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.Report.Managers
{
    internal class ReportAttendanceManager
    {
        private CoursePersister _coursePersister;
        private AttendancePersister _attendancePersister;

        public ReportAttendanceManager()
        {
            _attendancePersister = new AttendancePersister();
        }

        internal List<AttendanceView> GetAttendance(int documentNumber, int roleId)
        {
            var currentRole = ModelEnumParser.RoleParser(roleId);

            var attendanceBase = _attendancePersister.GetAttendance();

            if (currentRole == DAL.Common.Model.Enums.Role.ADMIN || currentRole == DAL.Common.Model.Enums.Role.DIRECTOR)
            {
                return attendanceBase.ToList(); ;
            }

            //if (currentRole == DAL.Common.Model.Enums.Role.TEACHER)
            //{
            //    var teacherNonAttendance =
            //        attendanceBase.Where(
            //            filter => filter.DocumentNumber == documentNumber).ToList();

            //    var teacherStudentsNonAttendance =
            //        attendanceBase.Where(filter => IsCouseFromTeacher(documentNumber, filter.CourseId)).ToList();

            //    return teacherStudentsNonAttendance.Union(teacherNonAttendance).ToList();
            //}

            return attendanceBase.Where(
            filter => filter.DocumentNumber == documentNumber).ToList();
        }

        private bool IsCouseFromTeacher(int documentNumber, int courseId)
        {
            var teacherCourses = _coursePersister.GetCoursesByTeacherDocumentNumber(documentNumber);

            return teacherCourses.Where(filter => filter.Id == courseId).Any();
        }
    }
}
