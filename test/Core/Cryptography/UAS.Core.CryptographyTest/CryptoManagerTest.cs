using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using UAS.Core.Cryptography;

namespace UAS.Core.CryptographyTest
{
    [TestClass]
    public class CryptoManagerTest
    {
        private const string DATA_DECRYPTED = "{Data : {User: 'USER_TEST'}}";
        private const string DATA_ENCRYPTED = "AWNDJNVDQUr82nrK9h4hGhPEhwjtEVwHbPZJk8joJqxW02JZ7LHNROdLIED54hiqjU/sYNeSSEfFUQLlIEGQySW/makMatpMZkb/LTsbNcxbAvfI662dT5AmFd1oBOgOaArbGa5cEInXut1sQA6U4ST6vTK2/Fx7vOLtzLw37mU=";
        private CryptoManager _cryptoManager;

        [TestInitialize]
        public void SetUp() {
            _cryptoManager = new CryptoManager();
        }

        [TestMethod]
        public void EncryptTest()
        {
            var encrytedData = _cryptoManager.Encrypt(DATA_DECRYPTED);
            Assert.Equals(encrytedData, DATA_ENCRYPTED);
        }

        [TestMethod]
        public void DecryptTest()
        {
            var decrytedData = _cryptoManager.Decrypt(DATA_ENCRYPTED);
            Assert.Equals(decrytedData, DATA_DECRYPTED);
        }
    }
}
