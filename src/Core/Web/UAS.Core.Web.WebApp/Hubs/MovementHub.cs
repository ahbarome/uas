using Microsoft.AspNet.SignalR;
using System;

namespace UAS.Core.Web.WebApp.Hubs
{
    using Facade;

    public class MovementHub : Hub
    {
        
        /// <summary>
        /// 
        /// </summary>
        /// <param name="message"></param>
        public void BroadcastMessages(string message)
        {
            Clients.All.writeMessage("Server: " + message);
        }

        /// <summary>
        /// 
        /// </summary>
        public void DispatchToClient()
        {
            Clients.All.broadcastMessage("Refresh");
        }

        /// <summary>
        /// 
        /// </summary>
        public void Initialize()
        {
            Action<string> dispatcher = (t) => { DispatchToClient(); };
            var instance = Facade.Instance(dispatcher);
            instance.GetAllMovementsWithNotifications();
        }
    }
}