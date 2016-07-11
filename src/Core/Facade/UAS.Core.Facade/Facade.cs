using UAS.Core.Security;
using UAS.Core.Security.Validator;

namespace UAS.Core.Facade
{
    public class Facade
    {
        private WebSecurity _webSecurity;

        public Facade() {
            _webSecurity = new WebSecurity();
        }

        public void Login(string username, string password) {
            _webSecurity.Login(username, password);
        }
    }
}
