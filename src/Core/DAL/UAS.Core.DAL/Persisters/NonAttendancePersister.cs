using System;
using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class NonAttendancePersister : BaseContext
    {
        public IQueryable<NonAttendanceView> GetNonAttendances(int documentNumber, int roleId)
        {
            var nonAttendancesBase = base.Entities.NonAttendanceView.Where(
                filter => filter.DocumentNumber == documentNumber &&
                    filter.RoleId.Equals(roleId.ToString()));

            var nonAttendances = nonAttendancesBase.Where(filter => !filter.HasExcuse);

            return nonAttendances;
        }

        public IQueryable<NonAttendanceView> GetNonAttendance()
        {
            var nonAttendance = base.Entities.NonAttendanceView;
            return nonAttendance;
        }

        public void UpdateHasExcuse(int id, bool hasExcuse)
        {
            var nonAttendance = base.Entities.NonAttendances.Where(
                filter => filter.Id == id).FirstOrDefault();
            nonAttendance.HasExcuse = hasExcuse;
            base.Entities.SaveChanges();
        }
    }
}
