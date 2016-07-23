using System.Collections.Generic;

namespace UAS.Core.Security
{
    using DAL.Common.Model;
    using Interfaces;
    using Validators;

    public class WebSecurity
    {
        private List<IUserSecurity> _validators;

        /// <summary>
        /// Builder method
        /// </summary>
        public WebSecurity()
        {
            _validators = new List<IUserSecurity> {
                new CredentialsValidator(),
                new UserValidator()
            };
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
            foreach (var validator in _validators) {
                if (validator is UserValidator) {
                    var userValidator = validator as UserValidator;
                    var allowAccess = userValidator.AllowAccessToPage(page, username, password);
                    return allowAccess;
                }
            }
            return false;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        public void ValidateLogin(string username, string password)
        {
            foreach (var validator in _validators)
            {
                validator.Validate(username, password);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public User GetUser(string username, string password)
        {
            foreach (var validator in _validators)
            {
                if (validator is UserValidator)
                {
                    var userValidator = validator as UserValidator;
                    var currentUser = userValidator.GetUser(username, password);
                    return currentUser;
                }
            }
            return null;
        }
    }
}
