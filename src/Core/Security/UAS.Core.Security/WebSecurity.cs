using UAS.Core.Security.Validator;

namespace UAS.Core.Security
{
    public class WebSecurity
    {
        private CredentialsValidator _credentialsValidator;
        private UserValidator _userValidator;

        public WebSecurity()
        {
            _credentialsValidator = new CredentialsValidator();
            _userValidator = new UserValidator();
        }

        public void ValidateLogin(string username, string password)
        {
            _credentialsValidator.Validate(username, password);
            _userValidator.Validate(username, password);
        }
    }
}
