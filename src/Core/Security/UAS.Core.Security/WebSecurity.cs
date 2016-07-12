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

        public bool AllowAccessToPage(string page, string username, string  password) {
            var allowAccess = _userValidator.AllowAccessToPage(page, username, password);
            return allowAccess;
        }

        public void ValidateLogin(string username, string password)
        {
            _credentialsValidator.Validate(username, password);
            _userValidator.Validate(username, password);
        }
    }
}
