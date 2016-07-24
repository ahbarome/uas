using UAS.Core.Session.Entities;

namespace UAS.Core.Session.Builders
{
    public class UserBuilder
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
        public UserBuilder(DAL.Common.Model.User currentUser, string username, string password)
        {
            this._user = currentUser;
            this._username = username;
            this._password = password;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public User Build()
        {
            var user = new User
            {
                IdUser = _user.Id,
                Username = _username,
                Password = _password,
                IdRole = _user.IdRole,
                RoleName = _user.Role.Alias,
                Name = _user.Name,
                LastName = _user.LastName,
                ImageRelativePath = _user.ImageRelativePath,
                FullName = string.Format("{0} {1}", _user.Name, _user.LastName),
                IsActive = _user.IsActive,
                Pages = new PagesBuilder(_user.Role.PagePermissionByRoles).Build()
            };
            return user;
        }
    }
}
