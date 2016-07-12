namespace UAS.Core.Session.Builders
{
    using Entities;
    using System;

    public class SessionBuilder
    {
        /// <summary>
        /// 
        /// </summary>
        private DAL.Common.Model.User _user;
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
        /// <param name="currentUser"></param>
        public SessionBuilder(DAL.Common.Model.User currentUser, string username, string password)
        {
            this._user = currentUser;
            this._username = username;
            this._password = password;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public Session Build()
        {
            var session = new Session
            {
                SessionId = Guid.NewGuid().ToString().ToUpper(),
                SessionUser = new UserBuilder(_user, _username, _password).Build()
            };
            return session;
        }
    }
}
