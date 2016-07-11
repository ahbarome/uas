namespace UAS.Core.Security.Validator
{
    using Cryptography;
    using DAL.Persisters;

    public class UserValidator
    {
        private CryptoManager _cryptoManager;
        private UserPersister _persister;

        public UserValidator() {
            _cryptoManager = new CryptoManager();
            _persister = new UserPersister();
        }

        internal void Validate(string username, string password)
        {
            var encryptedPassword = _cryptoManager.Encrypt(password);

            var user = _persister.GetUserByUsernameAndPassword(username, encryptedPassword);

            if(user == null)
            {
                throw new System.Exception("Usuario o password inválidos");
            }
            if (!user.IsActive)
            {
                throw new System.Exception("El usuario se encuentra inactivo");
            }
        }
    }
}
