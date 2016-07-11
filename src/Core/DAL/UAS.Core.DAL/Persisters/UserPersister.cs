
using System;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class UserPersister : BaseContext
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public User GetUserByUsernameAndPassword(string username, string password)
        {
            try
            {
                var searchedUsed = Entities.Users.Where(user => user.Username.Equals(username)
                    && user.Password.Equals(password)).FirstOrDefault();
                return searchedUsed;
            }
            catch (Exception exception)
            {
                throw new Exception("EXC: Usuario o contraseña inválidos", exception);
            }
        }
    }
}
