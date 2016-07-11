using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using UAS.Core.Cryptography;

namespace UAS.Core.CryptographyTest
{
    [TestClass]
    public class CryptoManagerTest
    {
        private const string DATA_DECRYPTED = "{Data : {User: 'USER_TEST'}}";
        private const string DATA_ENCRYPTED = "1Etc8S3d3ESDGYsB7qIegI7m2oA+Vn2eVZFxtZXvrqo=";
        private CryptoManager _cryptoManager;

        [TestInitialize]
        public void SetUp() {
            _cryptoManager = new CryptoManager();
        }

        [TestMethod]
        public void EncryptTest()
        {
            var encrytedData = _cryptoManager.Encrypt(DATA_DECRYPTED);
            Assert.IsTrue(encrytedData.Equals(DATA_ENCRYPTED) );
        }

        [TestMethod]
        public void DecryptTest()
        {
            var decrytedData = _cryptoManager.Decrypt(DATA_ENCRYPTED);
            Assert.IsTrue(decrytedData.Equals(DATA_DECRYPTED));
        }
    }
}
