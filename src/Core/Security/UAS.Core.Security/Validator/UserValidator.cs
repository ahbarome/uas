using System;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.Security.Validator
{
    public class UserValidator
    {
        private UserPersister _persister;

        public UserValidator() {
            _persister = new UserPersister();
        }

        internal void Validate(string username, string password)
        {
            var user = _persister.GetUserByUsernameAndPassword(username, password);

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
