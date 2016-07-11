namespace UAS.Core.Facade
{
    using Session;
    using Session.Interfaces;

    public class Facade
    {
        private ISessionManager _sessionManager;

        public Facade() {
            _sessionManager = new SessionManager();
        }

        public void CreateSession(string username, string password) {
            _sessionManager.CreateSession(username, password);
        }
    }
}
