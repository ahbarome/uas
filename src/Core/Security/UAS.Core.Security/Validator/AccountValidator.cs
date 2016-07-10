namespace UAS.Core.Security.Validator
{
    public class AccountValidator
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
