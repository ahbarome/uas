namespace UAS.Core.Facade
{
    using Attendance;
    using DAL.Common.Model;
    using Session;
    using Session.Interfaces;
    using System.Linq;

    public class Facade
    {
        private ISessionManager _sessionManager;
        private AttendanceFacade _attendanceFacade;

        public Facade() {
            _sessionManager = new SessionManager();
            _attendanceFacade = new AttendanceFacade();
        }

        public void CreateSession(string username, string password) {
            _sessionManager.CreateSession(username, password);
        }

        public void CloseSession()
        {
            _sessionManager.CloseSession();
        }

        public dynamic Get() {
            return _attendanceFacade.Get();
        }
    }
}
