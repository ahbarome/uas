using System;
using System.Data.Entity.Core.EntityClient;
using UAS.Core.Configuration;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL
{
    public class BaseContext
    {

        protected EntityConnectionStringBuilder EntityConnectionStringBuilder;

        protected UASEntities Entities;

        public BaseContext()
        {
            try
            {
                Entities = new UASEntities();
                EntityConnectionStringBuilder = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStringUASEntites);
            }
            catch (Exception exception)
            {
                throw new Exception("EXC: No fué posible realiza la conexión con la base de datos", exception);
            }
        }

    }
}
