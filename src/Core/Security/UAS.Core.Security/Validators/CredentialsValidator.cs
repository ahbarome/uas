namespace UAS.Core.Security.Validators
{
    public class CredentialsValidator
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        internal void Validate(string username, string password) {
            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password)) {
                throw new System.Exception("Usuario o password inválidos");
            }
        }
    }
}
