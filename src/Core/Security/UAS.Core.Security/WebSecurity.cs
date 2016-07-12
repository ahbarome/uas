using UAS.Core.DAL.Common.Model;
using UAS.Core.Security.Validators;

namespace UAS.Core.Security
{
    public class WebSecurity
    {
        private CredentialsValidator _credentialsValidator;
        private UserValidator _userValidator;

        /// <summary>
        /// Builder method
        /// </summary>
        public WebSecurity()
        {
            _credentialsValidator = new CredentialsValidator();
            _userValidator = new UserValidator();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="page"></param>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public bool AllowAccessToPage(string page, string username, string password)
        {
            var allowAccess = _userValidator.AllowAccessToPage(page, username, password);
            return allowAccess;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        public void ValidateLogin(string username, string password)
        {
            _credentialsValidator.Validate(username, password);
            _userValidator.Validate(username, password);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public User GetUser(string username, string password)
        {
            var currentUser = _userValidator.GetUser(username, password);
            return currentUser;
        }
    }
}
