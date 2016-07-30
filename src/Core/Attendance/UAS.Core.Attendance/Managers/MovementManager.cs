using System;
using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.Attendance.Managers
{
    internal class MovementManager
    {
        private UserPersister _userPersister;
        /// <summary>
        /// 
        /// </summary>
        private MovementPersister _movementPersister;
        private Action<string> _dispatcher;
        /// <summary>
        /// 
        /// </summary>
        public MovementManager()
        {
            _movementPersister = new MovementPersister();
            _movementPersister.SqlNotification += SqlDependencyNotifier;

            _userPersister = new UserPersister();
        }

        /// <summary>
        /// 
        /// </summary>
        public MovementManager(Action<string> attendanceDispatcher = null)
        {
            _dispatcher = attendanceDispatcher;

            _movementPersister = new MovementPersister();
            _movementPersister.SqlNotification += SqlDependencyNotifier;

            _userPersister = new UserPersister();

            ActivateNotifications();
        }

        /// <summary>
        /// 
        /// </summary>
        public void ActivateNotifications()
        {
            _movementPersister.GetAllMovementsWithNotifications();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Movement> GetAllMovementsWithNotifications()
        {
            return _movementPersister.GetAllMovementsWithNotifications();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public List<StudentMovement> GetAllStudentMovementsWithoutNotificationsByTeacherId(int teacherId)
        {
            var teacher = _userPersister.GetUserById(teacherId);
            return _movementPersister.GetAllStudentMovementsWithoutNotificationsByTeacherDocumentNumber(teacher.DocumentNumber);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Movement> GetAllMovementsWithoutNotifications()
        {
            return _movementPersister.GetAllMovementsWithoutNotifications();
        }

        private void SqlDependencyNotifier(object sender, System.Data.SqlClient.SqlNotificationEventArgs e)
        {
            _dispatcher?.Invoke("Refresh");
        }

        public List<TeacherMovement> GetAllTeacherMovementsWithoutNotificationsByDirectorId(int directorId)
        {
            return _movementPersister.GetAllTeacherMovementsWithoutNotifications();
        }
    }
}
