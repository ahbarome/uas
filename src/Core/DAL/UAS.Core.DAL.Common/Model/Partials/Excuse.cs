using System.Collections.Generic;
using System.Web;

namespace UAS.Core.DAL.Common.Model
{
    public partial class Excuse
    {
        public string NonAttendanceIds { get; set; }
        public IList<HttpPostedFileBase> Files { get; set; }
    }
}
