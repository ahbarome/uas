using System;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class ExcusePersister : BaseContext
    {
        public IQueryable<Classification> GetExcuseClassifications()
        {
            var classfications = base.Entities.Classifications;
            return classfications;
        }

        public void Save(Excuse excuse)
        {
            try
            {
                base.Entities.Excuses.Add(excuse);
                base.Entities.SaveChangesAsync();
            }
            catch (Exception exception)
            {
                throw new Exception("EXC: Se presentaron inconvenientes guardando la excusa", exception);
            }
        }

        public IQueryable<Excuse> List()
        {
            var excuses = base.Entities.Excuses;
            return excuses;
        }
    }
}
