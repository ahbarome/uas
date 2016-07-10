using Microsoft.VisualStudio.TestTools.UnitTesting;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.DALTest
{
    [TestClass]
    public class UserPersisterTest
    {
        [TestMethod]
        public void GetUserByUsernameAndPasswordTest()
        {
            var persister = new UserPersister();
            var user = persister.GetUserByUsernameAndPassword("", "");
            Assert.IsNotNull(user);
        }
    }
}
