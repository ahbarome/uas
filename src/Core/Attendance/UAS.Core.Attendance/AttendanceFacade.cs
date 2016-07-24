using System;
using System.Collections.Generic;
using System.Linq;
using UAS.Core.Attendance.Managers;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.Attendance
{
    public class AttendanceFacade
    {
        private CourseManager _courseManager;
        private TeacherManager _teacherManager;
        private MovementManager _movementManager;
        private Action<string> _dispatcher;

        public AttendanceFacade(Action<string> dispatcher = null)
        {
            this._dispatcher = dispatcher;
            _movementManager = new MovementManager(dispatcher);
            _courseManager = new CourseManager();
            _teacherManager = new TeacherManager();
        }

        public IQueryable<Movement> GetAllMovementsWithNotifications()
        {
            return _movementManager.GetAllMovementsWithNotifications();
        }
        public IQueryable<Movement> GetAllMovementsWithoutNotifications()
        {
            return _movementManager.GetAllMovementsWithoutNotifications();
        }

        public List<StudentMovement> GetAllStudentMovementsWithoutNotificationsByTeacherId(int teacherId)
        {
            return _movementManager.GetAllStudentMovementsWithoutNotificationsByTeacherId(teacherId);
        }

        public Course GetCourseByTeacherId(int teacherId)
        {
            return _courseManager.GetCourseByTeacherId(teacherId);
        }

        public object GetStatisticsByCourseAndTeacherId(int courseId, int teacherId)
        {
            return _courseManager.GetStatisticsByCourseAndTeacherId(courseId, teacherId);
        }

        public Teacher GetTeacherById(int teacherId)
        {
            return _teacherManager.GetTeacherById(teacherId);
        }
    }
}
