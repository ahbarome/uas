using System;
using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.NonAttendance.Managers
{
    internal class NonAttendanceManager
    {
        private NonAttendancePersister _nonAttendancePersister;
        public NonAttendanceManager()
        {
            _nonAttendancePersister = new NonAttendancePersister();
        }

        internal List<NonAttendanceView> GetNonAttendances(int documentNumber, int roleId)
        {
            return _nonAttendancePersister.GetNonAttendances(documentNumber, roleId).ToList();
        }

        internal void UpdateHasExcuse(int id, bool hasExcuse)
        {
            _nonAttendancePersister.UpdateHasExcuse(id, hasExcuse);
        }
    }
}
