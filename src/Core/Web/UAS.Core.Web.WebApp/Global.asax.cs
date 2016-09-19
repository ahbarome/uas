using log4net;
using System;
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
        /// <summary>
        /// Logger for the controller
        /// </summary>
        private static readonly ILog _logger =
            LogManager.GetLogger(
                System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Builder for the connection strign
        /// </summary>
        private static EntityConnectionStringBuilder entityConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStringUASEntites);

        private static string _connectionString = entityConnectionString.ProviderConnectionString;

        /// <summary>
        /// Initialize the componentes requireds in the application
        /// </summary>
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            SqlDependency.Start(_connectionString);
        }

        /// <summary>
        /// Stops the components 
        /// </summary>
        protected void Application_End()
        {
            var connectionString = entityConnectionString.ProviderConnectionString;
            SqlDependency.Stop(_connectionString);
        }

        /// <summary>
        /// Capture global exceptions
        /// </summary>
        /// <param name="sender">Sender of the event</param>
        /// <param name="errorEvent">Event</param>
        protected void Application_Error(object sender, EventArgs errorEvent)
        {
            var raisedException = Server.GetLastError();
            // Process exception
            _logger.Fatal(raisedException.Message, raisedException);
        }
    }
}
