using System.IO;
using System.Linq;
using System.Web;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.NonAttendance.Managers
{
    public class ExcuseManager
    {
        private ExcusePersister _excusePersister;

        public ExcuseManager()
        {
            _excusePersister = new ExcusePersister();
        }

        public IQueryable<Classification> GetExcuseClassifications()
        {
            return _excusePersister.GetExcuseClassifications();
        }

        public void Save(Excuse excuse)
        {
            //Here goes the logic
            foreach (var attachment in excuse.Files)
            {
                attachment.SaveAs(HttpContext.Current.Server.MapPath("~/files/attachments/")+ attachment.FileName);
            }

        }

        public IQueryable<Excuse> List()
        {
            return _excusePersister.List();
        }
    }
}
