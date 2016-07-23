using UAS.Core.Security.Interfaces;

namespace UAS.Core.Security.Validators
{
    public class CredentialsValidator : IUserSecurity
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        public void Validate(string username, string password) {
            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password)) {
                throw new System.Exception("Usuario o password inválidos");
            }
        }
    }
}
