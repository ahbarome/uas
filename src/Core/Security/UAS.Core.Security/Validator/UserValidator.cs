namespace UAS.Core.Security.Validator
{
    using System;
    using Cryptography;
    using DAL.Persisters;
    using DAL.Common.Model;

    public class UserValidator
    {
        private CryptoManager _cryptoManager;
        private UserPersister _persister;
        private const string ABSOLUTE_PATH_CHAR_INDICATOR = "~";

        public UserValidator()
        {
            _cryptoManager = new CryptoManager();
            _persister = new UserPersister();
        }

        internal void Validate(string username, string password)
        {
            var user = GetUser(username, password);

            if (user == null)
            {
                throw new System.Exception("Usuario o password inválidos");
            }
            if (!user.IsActive)
            {
                throw new System.Exception("El usuario se encuentra inactivo");
            }
        }

        internal bool AllowAccessToPage(string page, string username, string password)
        {
            var user = GetUser(username, password);

            foreach (var pagePermission in user.Role.PagePermissionByRols)
            {
                var allowedPage = pagePermission.Page.MenuItem.Replace(ABSOLUTE_PATH_CHAR_INDICATOR, string.Empty);
                if (allowedPage.Equals(page))
                {
                    return true;
                }
            }
            return false;
        }

        private User GetUser(string username, string password)
        {
            var encryptedPassword = _cryptoManager.Encrypt(password);
            var user = _persister.GetUserByUsernameAndPassword(username, encryptedPassword);
            return user;
        }
    }
}
