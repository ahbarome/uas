using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Notifiers;

namespace UAS.Core.DAL.Persisters
{
    public class MovementPersister : BaseContext
    {
        /// <summary>
        /// 
        /// </summary>
        public event SqlNotificationEventHandler SqlNotification;
        
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Movement> GetAllMovementsWithNotifications()
        {
            var query = base.Entities.Movements;

            RegisterForNotifications(query);

            return query;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Movement> GetAllMovementsWithoutNotifications()
        {
            var query = base.Entities.Movements;

            return query;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        private DbSet<Movement> GetAll()
        {
            var query = base.Entities.Movements;

            return query;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="query"></param>
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
        private void RegisterForNotifications(DbSet<Movement> query)
        {
            using (var connection = new SqlConnection(base.EntityConnectionStringBuilder.ProviderConnectionString))
            {
                connection.Open();

                var command = new SqlCommand(query.ToString(), connection);
                var sqlDependency = new SqlDependency(command);
                sqlDependency.OnChange += new OnChangeEventHandler(OnChangeDependency);

                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void OnChangeDependency(object sender, SqlNotificationEventArgs e)
        {
            if (SqlNotification != null)
                SqlNotification(sender, e);

            RegisterForNotifications(GetAll());
        }
    }
}
