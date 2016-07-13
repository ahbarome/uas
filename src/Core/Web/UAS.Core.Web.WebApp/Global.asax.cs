using System.Data.Entity.Core.EntityClient;
using System.Data.SqlClient;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using UAS.Core.Configuration;

namespace UAS.Core.Web.WebApp
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        private static EntityConnectionStringBuilder entityConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStringUASEntites);

        protected void Application_Start()
        {
            var connectionString = entityConnectionString.ConnectionString;
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            SqlDependency.Start(connectionString);
        }

        protected void Application_End() {
            var connectionString = entityConnectionString.ConnectionString;
            SqlDependency.Stop(connectionString);
        }
    }
}
