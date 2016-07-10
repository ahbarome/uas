using System;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL
{
    public class BaseContext
    {
        private Entities _entities;

        protected Entities Entities { get { return _entities; } set { value = _entities; } }

        public BaseContext()
        {
            try
            {
                this._entities = new Entities();
            }
            catch (Exception exception)
            {
            }
        }
    }
}
