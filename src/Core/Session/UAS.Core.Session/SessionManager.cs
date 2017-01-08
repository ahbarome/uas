using System;

namespace UAS.Core.Session
{
    using Builders;
    using Configuration;
    using Entities;
    using Interfaces;
    using Security;
    using System.Web;

    public class SessionManager : ISessionManager
    {
        /// <summary>
        /// 
        /// </summary>
        private string _username;
        /// <summary>
        /// 
        /// </summary>
        private string _password;
        /// <summary>
        /// 
        /// </summary>
        private DAL.Common.Model.User _user;
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
            _username = username;
            _password = password;
            _webSecurity.ValidateLogin(username, password);
            CreateNewSession(username, password);
        }

        /// <summary>
        /// Create the session
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        private void CreateNewSession(string username, string password)
        {
            _user = _user == null ? _webSecurity.GetUser(username, password) : _user;

            HttpContext.Current.Session[ConfigurationManager.SESSION_KEY] =
                    new SessionBuilder(_user, username, password).Build();
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
        private void RefreshSession()
        {
            CreateSession(_username, _password);
        }
    }
}
