using System.Collections.Generic;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.Dashboard.Managers
{
    internal class DashboardExcuseManager
    {
        private DashboardPersister _dashboardPersister;

        public DashboardExcuseManager()
        {
            _dashboardPersister = new DashboardPersister();
        }

        public List<Statistic> GetTopStatistictExcuseClassifications(int documentNumber, int roleId)
        {
            return _dashboardPersister.GetTopStatistictExcuseClassifications(documentNumber, roleId);
        }

        public List<Statistic> GetStatistictExcuseStatus(int documentNumber, int roleId)
        {
            return _dashboardPersister.GetStatistictExcuseStatus(documentNumber, roleId);
        }
    }
}
