using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using UAS.Core.Security.Validators;

namespace UAS.Core.SecurityTest
{
    [TestClass]
    public class ActiveDirectoryValidatorTest
    {
        //@TODO: Change username
        private const string USERNAME = "TMP";
        //@TODO: Change password
        private const string PASSWORD = "TMP";
        private ActiveDirectoyValidator _validator;

        [TestInitialize]
        public void SetUp()
        {
            _validator = new ActiveDirectoyValidator();
        }

        [TestMethod]
        public void ValidateTest()
        {
            _validator.Validate(USERNAME, PASSWORD);
            Assert.IsTrue(true);
        }
    }
}
