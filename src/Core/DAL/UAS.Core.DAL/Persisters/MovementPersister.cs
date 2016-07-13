using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class MovementPersister : BaseContext
    {
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Movement> Get()
        {
            var query = base.Entities.Movements;

            Execute(query);

            return query;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="query"></param>
        private void Execute(DbSet<Movement> query)
        {
            using (var connection = new SqlConnection(base.EntityConnectionStringBuilder.ProviderConnectionString))
            {
                connection.Open();
                var command = new SqlCommand(query.ToString(), connection);
                var sqlDependency = new SqlDependency(command);
                sqlDependency.OnChange += new OnChangeEventHandler(SqlDependencyOnChange);
                // NOTE: You have to execute the command, or the notification will never fire.
                using (SqlDataReader reader = command.ExecuteReader()) { }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void SqlDependencyOnChange(object sender, SqlNotificationEventArgs e)
        {
            var info = e.Info;
            var source = e.Source;
            var type = e.Type;
            return;
        }
    }
}
