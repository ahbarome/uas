
using System;
using System.Data.Entity.Validation;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class UserPersister : BaseContext
    {
        /// <summary>
        /// Save a user in the database
        /// </summary>
        /// <param name="user">User to persist in the database</param>
        public void Save(User user)
        {
            try
            {
                base.Entities.Users.Add(user);
                base.Entities.SaveChanges();
            }
            catch (DbEntityValidationException ex)
            {
                // Retrieve the error messages as a list of strings.
                var errorMessages = ex.EntityValidationErrors
                        .SelectMany(x => x.ValidationErrors)
                        .Select(x => x.ErrorMessage);

                // Join the list to a single string.
                var fullErrorMessage = string.Join("; ", errorMessages);

                // Combine the original exception message with the new one.
                var exceptionMessage = string.Concat(ex.Message, " The validation errors are: ", fullErrorMessage);

                // Throw a new DbEntityValidationException with the improved exception message.
                throw new DbEntityValidationException(exceptionMessage, ex.EntityValidationErrors);
            }
            catch (Exception exception)
            {
                throw;
            }

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public User GetUserById(int id)
        {
            try
            {
                var searchedUsed = Entities.Users.Where(user => user.Id == id).FirstOrDefault();
                return searchedUsed;
            }
            catch (Exception exception)
            {
                throw new Exception(
                    string.Format("EXC: El usuario con ID: {0} es inválido o no existe", id), exception);
            }
        }
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
