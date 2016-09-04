using System;
using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Parsers;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.Report.Managers
{
    internal class ReportNonAttendanceManager
    {
        private CoursePersister _coursePersister;
        private NonAttendancePersister _nonAttendancePersister;

        public ReportNonAttendanceManager()
        {
            _nonAttendancePersister = new NonAttendancePersister();
        }

        internal List<NonAttendanceView> GetNonAttendance(int documentNumber, int roleId)
        {
            var currentRole = ModelEnumParser.RoleParser(roleId);

            var nonAttendanceBase = _nonAttendancePersister.GetNonAttendance();

            if (currentRole == DAL.Common.Model.Enums.Role.ADMIN || currentRole == DAL.Common.Model.Enums.Role.DIRECTOR)
            {
                return nonAttendanceBase.ToList(); ;
            }

            //if (currentRole == DAL.Common.Model.Enums.Role.TEACHER)
            //{
            //    var teacherNonAttendance =
            //        nonAttendanceBase.Where(
            //            filter => filter.DocumentNumber == documentNumber);

            //    var teacherStudentsNonAttendance =
            //        nonAttendanceBase.Where(filter => IsCouseFromTeacher(documentNumber, filter.CourseId));

            //    return teacherStudentsNonAttendance.Union(teacherNonAttendance).ToList();
            //}

            return nonAttendanceBase.Where(
            filter => filter.DocumentNumber == documentNumber).ToList();
        }

        private bool IsCouseFromTeacher(int documentNumber, int courseId)
        {
            var teacherCourses = _coursePersister.GetCoursesByTeacherDocumentNumber(documentNumber);

            return teacherCourses.Where(filter=> filter.Id == courseId).Any();
        }
    }
}
