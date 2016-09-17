using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace UAS.Core.Report.Test.Managers
{
    [TestClass]
    public class ReportAttendanceManagerTest
    {
        private ReportFacade _facade;

        [TestInitialize]
        public void SetUp()
        {
            _facade = new ReportFacade();
        }

        [TestCleanup]
        public void TearDown()
        {
            _facade = null;
        }

        [TestMethod]
        public void GetAttendanceForTeacherTest()
        {
            var documentNumber = 1130677692;
            var roleId = 3;
            var attendance = _facade.GetAttendance(documentNumber, roleId);
            Assert.IsTrue(attendance != null && attendance.Count > 0);
        }

        [TestMethod]
        public void GetNonAttendanceForTeacherTest()
        {
            var documentNumber = 1130677692;
            var roleId = 3;
            var attendance = _facade.GetNonAttendance(documentNumber, roleId);
            Assert.IsTrue(attendance != null && attendance.Count > 0);
        }
    }
}

