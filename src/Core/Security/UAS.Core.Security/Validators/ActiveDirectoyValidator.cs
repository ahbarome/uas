using System.DirectoryServices;
using UAS.Core.Security.Interfaces;

namespace UAS.Core.Security.Validators
{
    public class ActiveDirectoyValidator: IUserSecurity
    {
        private const string SERVER_NAME = "LOCALHOST";
        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        public void Validate(string username, string password)
        {
            using (var activeDirectoryEntry = new DirectoryEntry(SERVER_NAME, username, password))
            {
                using (var activeDirectorySearcher = new DirectorySearcher(activeDirectoryEntry))
                {
                    var searchedUser = activeDirectorySearcher.FindOne();

                    if (searchedUser == null)
                    {
                        throw new System.Exception("Usuario o password inválidos");
                    }
                }
                
            }
        }
    }
}
