using System.Data.SqlClient;

namespace UAS.Core.DAL.Notifiers
{
    public delegate void SqlNotificationEventHandler(object sender, SqlNotificationEventArgs e);
}
