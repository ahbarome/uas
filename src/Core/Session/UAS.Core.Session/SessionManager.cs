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
        /// <summary>
        /// Manage the security 
        /// </summary>
        private WebSecurity _webSecurity;

        /// <summary>
        /// Builder method
        /// </summary>
        public SessionManager()
        {
            _webSecurity = new WebSecurity();
        }

        /// <summary>
        /// Create a new session for the current user
        /// </summary>
        /// <param name="username">Username of the current user</param>
        /// <param name="password">Plain password of the current user</param>
        public void CreateSession(string username, string password)
        {
            _webSecurity.ValidateLogin(username, password);
            Create(username, password);
        }

        /// <summary>
        /// Create the session
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        private void Create(string username, string password)
        {
            HttpContext.Current.Session[ConfigurationManager.SESSION_KEY] =
                            new Session
                            {
                                SessionId = Guid.NewGuid().ToString().ToUpper(),
                                SessionUser = new User { Username = username, Password = password }
                            };
        }

        /// <summary>
        /// 
        /// </summary>
        public void CloseSession()
        {
            if (HttpContext.Current.Session.Count > 0)
            {
                HttpContext.Current.Session.RemoveAll();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public Session GetSession()
        {
            var session = HttpContext.Current.Session[ConfigurationManager.SESSION_KEY] as Session;
            return session;
        }

        /// <summary>
        /// 
        /// </summary>
        private void RefreshSession() {

        }
    }
}
