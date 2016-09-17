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
            _coursePersister = new CoursePersister();
            _nonAttendancePersister = new NonAttendancePersister();
        }

        internal List<NonAttendanceView> GetNonAttendance(int documentNumber, int roleId)
        {
            var currentRole = ModelEnumParser.RoleParser(roleId);
            var nonAttendanceBase = _nonAttendancePersister.GetNonAttendance();
            var nonAttendance = new List<NonAttendanceView>();

            if (currentRole == DAL.Common.Model.Enums.Role.ADMIN || currentRole == DAL.Common.Model.Enums.Role.DIRECTOR)
            {
                return nonAttendanceBase.ToList(); ;
            }

            if (currentRole == DAL.Common.Model.Enums.Role.TEACHER)
            {
                var teacherNonAttendance =
                    nonAttendanceBase.Where(
                        filter => filter.DocumentNumber == documentNumber).ToList();

                var teacherCourses = teacherNonAttendance.Select(
                    teacherAttendance => teacherAttendance.CourseId).Distinct().ToList();

                var studentsNonAttendance = nonAttendanceBase
                    .Where(
                        filter => 
                            filter.RoleId.Equals(
                                ((int)DAL.Common.Model.Enums.Role.STUDENT).ToString())  &&
                            teacherCourses.Contains(filter.CourseId)).ToList();

                teacherNonAttendance.ForEach(
                    currentTeacherNonAttendance => nonAttendance.Add(currentTeacherNonAttendance));

                studentsNonAttendance.ForEach(
                    studentAttendance => nonAttendance.Add(studentAttendance));

                return nonAttendance;
            }

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
