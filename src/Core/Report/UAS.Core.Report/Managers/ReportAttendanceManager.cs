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
            _coursePersister = new CoursePersister();
            _attendancePersister = new AttendancePersister();
        }

        internal List<AttendanceView> GetAttendance(int documentNumber, int roleId)
        {
            var currentRole = ModelEnumParser.RoleParser(roleId);
            var attendanceBase = _attendancePersister.GetAttendance();
            var attendance = new List<AttendanceView>();

            if (currentRole == DAL.Common.Model.Enums.Role.ADMIN || currentRole == DAL.Common.Model.Enums.Role.DIRECTOR)
            {
                return attendanceBase.ToList();
            }

            if (currentRole == DAL.Common.Model.Enums.Role.TEACHER)
            {
                var teacherNonAttendance =
                    attendanceBase.Where(
                        filter => filter.DocumentNumber == documentNumber).ToList();

                var teacherCourses = teacherNonAttendance.Select(
                    teacherAttendance => teacherAttendance.CourseId).Distinct().ToList();

                var studentsNonAttendance = attendanceBase
                .Where(filter => filter.RoleId == (int)DAL.Common.Model.Enums.Role.STUDENT &&
                     teacherCourses.Contains(filter.CourseId)).ToList();

                teacherNonAttendance.ForEach(
                    teacherAttendance => attendance.Add(teacherAttendance));

                studentsNonAttendance.ForEach(
                    studentAttendance => attendance.Add(studentAttendance));

                return attendance;
            }

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
