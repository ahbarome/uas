namespace UAS.Core.Security.Validators
{
    using System;
    using Cryptography;
    using DAL.Persisters;
    using DAL.Common.Model;

    public class UserValidator
    {
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
        private const string ABSOLUTE_PATH_CHAR_INDICATOR = "~";

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
        internal void Validate(string username, string password)
        {
            var user = GetUser(username, password);

            if (user == null)
            {
                throw new Exception("Usuario o password inválidos");
            }
            if (!user.IsActive)
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
            var user = GetUser(username, password);

            foreach (var pagePermission in user.Role.PagePermissionByRoles)
            {
                var allowedPage = pagePermission.Page.MenuItem.Replace(ABSOLUTE_PATH_CHAR_INDICATOR, string.Empty);
                if (allowedPage.Equals(page))
                {
                    return true;
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
