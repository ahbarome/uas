using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(UAS.Core.Web.WebApp.Startup))]

namespace UAS.Core.Web.WebApp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.MapSignalR();
        }
    }
}
