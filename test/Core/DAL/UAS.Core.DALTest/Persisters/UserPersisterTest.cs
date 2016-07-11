using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.DALTest
{
    [TestClass]
    public class UserPersisterTest
    {
        private UserPersister _persister;

        [TestInitialize]
        public void SetUp()
        {
            _persister = new UserPersister();
        }

        [TestMethod]
        public void GetUserByUsernameAndPasswordTest()
        {
            var user = _persister.GetUserByUsernameAndPassword("ahbarome", "1");
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
