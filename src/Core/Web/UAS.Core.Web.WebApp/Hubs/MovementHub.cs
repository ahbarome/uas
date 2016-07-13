using Microsoft.AspNet.SignalR;

namespace UAS.Core.Web.WebApp.Hubs
{
    public class MovementHub : Hub
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="message"></param>
        public void BroadcastMessages(string message) {
            Clients.All.writeMessage("Server: " + message);
        }
    }
}