using System;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL
{
    public class BaseContext
    {
        private UASEntities _entities;

        protected UASEntities Entities { get { return _entities; } set { value = _entities; } }

        public BaseContext()
        {
            try
            {
                this._entities = new UASEntities();
            }
            catch (Exception exception)
            {
                throw new Exception("EXC: No fué posible realiza la conexión con la base de datos", exception);
            }
        }
    }
}
