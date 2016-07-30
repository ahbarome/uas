using System;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.Attendance.Managers
{
    internal class TeacherManager
    {
        UserPersister _userPersister;
        TeacherPersister _teacherPersister;
        public TeacherManager() {
            _userPersister = new UserPersister();
            _teacherPersister = new TeacherPersister();
        }

        internal Teacher GetTeacherById(int teacherId)
        {
            var teacher = _userPersister.GetUserById(teacherId);
            return _teacherPersister.GetTeacherByDocumentNumber(teacher.DocumentNumber);
        }

        internal Statistic GetTeacherAttendanceStatistics()
        {
            return _teacherPersister.GetTeacherAttendanceStatistics();
        }
    }
}
