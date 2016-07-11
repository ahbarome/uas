using System;

namespace UAS.Core.Session
{
    using Configuration;
    using Entities;
    using Interfaces;
    using Security;
    using System.Web;

    public class SessionManager : ISessionManager
    {
        private WebSecurity _webSecurity;

        public SessionManager()
        {
            _webSecurity = new WebSecurity();
        }

        public void CreateSession(string username, string password)
        {
            _webSecurity.ValidateLogin(username, password);
            Create(username, password);
        }

        private void Create(string username, string password)
        {
            HttpContext.Current.Session[ConfigurationManager.SESSION_KEY] =
                            new Session
                            {
                                SessionId = Guid.NewGuid().ToString(),
                                SessionUser = new User { Username = username, Password = password }
                            };
        }

        public void DestroySession()
        {
            if (HttpContext.Current.Session.Count > 0)
            {
                HttpContext.Current.Session[ConfigurationManager.SESSION_KEY] = null;
            }
        }

        public Session GetSession()
        {
            var session = HttpContext.Current.Session[ConfigurationManager.SESSION_KEY] as Session;
            return session;
        }
    }
}
