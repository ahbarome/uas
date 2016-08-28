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

        public List<Statistic> GetTopStatistictExcuseClassifications()
        {
            return _dashboardPersister.GetTopStatistictExcuseClassifications();
        }

        public List<Statistic> GetStatistictExcuseStatus()
        {
            return _dashboardPersister.GetStatistictExcuseStatus();
        }
    }
}
