using Microsoft.VisualStudio.TestTools.UnitTesting;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.DALTest
{
    [TestClass]
    public class UserPersisterTest
    {
        static int DEFAULT_DOCUMENT_NUMBER = 123456;
        static string ADMIN_USERNAME = "admin";
        static string DEFAULT_BY_PASSWORD = "NXo/ao4xL5ix30tACkl6jg==";
        private UserPersister _persister;

        [TestInitialize]
        public void SetUp()
        {
            _persister = new UserPersister();
        }

        [TestMethod]
        public void SaveDirectorUserTest()
        {
            var newUser = new User
            {
                Username = "TEST",
                DocumentNumber = DEFAULT_DOCUMENT_NUMBER,
                Password = DEFAULT_BY_PASSWORD,
                IdRole = 1,
                CreatedBy = ADMIN_USERNAME
            };
            _persister.Save(newUser);
            Assert.IsTrue(true);
        }

        [TestMethod]
        public void GetUserByUsernameAndPasswordTest()
        {
            var user = _persister.GetUserByUsernameAndPassword("fcastillo", DEFAULT_BY_PASSWORD);
            Assert.IsNotNull(user);
        }

        [TestMethod]
        public void GetUserByUsernameAndPasswordEmptyTest()
        {
            var user = _persister.GetUserByUsernameAndPassword(string.Empty, string.Empty);
            Assert.IsNull(user);
        }
    }
}
