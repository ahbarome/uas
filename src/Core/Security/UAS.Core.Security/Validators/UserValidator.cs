namespace UAS.Core.Security.Validators
{
    using System;
    using Cryptography;
    using DAL.Persisters;
    using DAL.Common.Model;
    using Interfaces;
    using System.Collections.Generic;
    using System.Linq;

    public class UserValidator : IUserSecurity
    {
        /// <summary>
        /// Current user
        /// </summary>
        private User _user;
        /// <summary>
        /// 
        /// </summary>
        private CryptoManager _cryptoManager;
        /// <summary>
        /// 
        /// </summary>
        private UserPersister _persister;
        /// <summary>
        /// 
        /// </summary>
        private static string ABSOLUTE_PATH_CHAR_INDICATOR = "~";
        /// <summary>
        /// 
        /// </summary>
        private static string PATH_SEPARATOR = "/";

        /// <summary>
        /// Builder method
        /// </summary>
        public UserValidator()
        {
            _cryptoManager = new CryptoManager();
            _persister = new UserPersister();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        public void Validate(string username, string password)
        {
            _user = _user == null ? GetUser(username, password): _user;

            if (_user == null)
            {
                throw new Exception("Usuario o password inválidos");
            }
            if (!_user.IsActive)
            {
                throw new Exception("El usuario se encuentra inactivo");
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="page"></param>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        internal bool AllowAccessToPage(string page, string username, string password)
        {
            _user = _user == null ? GetUser(username, password) : _user;

            if (_user.Role != null && _user.Role.PagePermissionByRoles != null)
            {
                var path = new List<string>();
                if (page.Contains(PATH_SEPARATOR))
                {
                    path =
                        page.Split(
                            new string[] { PATH_SEPARATOR },
                            StringSplitOptions.None)
                            .ToList();
                }

                foreach (var pagePermission in _user.Role.PagePermissionByRoles)
                {
                    var allowedPage =
                        pagePermission.Page.MenuItem.Replace(
                            ABSOLUTE_PATH_CHAR_INDICATOR,
                            string.Empty);

                    var allowedController = pagePermission.Page.Controller;
                    var allowedAction = pagePermission.Page.Action;

                    if (path.Contains(allowedController) && path.Contains(allowedAction))
                    {
                        return true;
                    }

                    if (allowedPage.Equals(page))
                    {
                        return true;
                    }
                }
            }
            
            return false;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        internal User GetUser(string username, string password)
        {
            var encryptedPassword = _cryptoManager.Encrypt(password);
            var user = _persister.GetUserByUsernameAndPassword(username, encryptedPassword);
            return user;
        }
    }
}
