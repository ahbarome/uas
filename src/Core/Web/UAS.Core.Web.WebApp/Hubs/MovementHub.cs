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
        private Facade _facade;
        
        /// <summary>
        /// 
        /// </summary>
        public MovementHub()
        {
            _facade = new Facade();
        }

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
        /// <param name="value"></param>
        public void Initialize(string value)
        {
            Action<string> dispatcher = (t) => { DispatchToClient(); };
        }
    }
}