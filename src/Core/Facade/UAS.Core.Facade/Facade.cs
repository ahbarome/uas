namespace UAS.Core.Facade
{
    using Attendance;
    using Session;
    using Session.Interfaces;
    using System;

    public class Facade
    {
        static Facade instance = null;
        private ISessionManager _sessionManager;
        private AttendanceFacade _attendanceFacade;

        public static Facade Instance(Action<string> attendanceDispatcher) {
            if (instance == null)
                instance = new Facade(attendanceDispatcher);
            return instance; 
        }

        public Facade()
        {
            _sessionManager = new SessionManager();
            _attendanceFacade = new AttendanceFacade();
        }

        public Facade(Action<string> attendanceDispatcher = null) {
            _sessionManager = new SessionManager();
            _attendanceFacade = new AttendanceFacade(attendanceDispatcher);
        }

        public void CreateSession(string username, string password) {
            _sessionManager.CreateSession(username, password);
        }

        public void CloseSession()
        {
            _sessionManager.CloseSession();
        }

        public dynamic GetAllMovementsWithNotifications() {
            return _attendanceFacade.GetAllMovementsWithNotifications();
        }

        public dynamic GetAllMovementsWithoutNotifications()
        {
            return _attendanceFacade.GetAllMovementsWithoutNotifications();
        }
    }
}
