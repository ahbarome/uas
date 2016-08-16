using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class NonAttendancePersister : BaseContext
    {
        public List<NonAttendanceView> GetNonAttendances(int documentNumber, int roleId)
        {
            var nonAttendances = base.Entities.NonAttendanceView.Where(
                filter => filter.DocumentNumber == documentNumber && 
                    filter.RoleId.Equals(roleId.ToString()) &&
                    !filter.HasExcuse)
                .ToList();

            return nonAttendances;
        }

        public void UpdateHasExcuse(int id, bool hasExcuse) {
            var nonAttendance = base.Entities.NonAttendances.Where(
                filter => filter.Id == id).FirstOrDefault();
            nonAttendance.HasExcuse = hasExcuse;
            base.Entities.SaveChanges();
        }
    }
}
