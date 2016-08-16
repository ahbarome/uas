using System;
using System.IO;
using System.Web;
using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class FileManagerController : SessionController
    {
        public FileResult AsyncPdfDownload(string pdfPath)
        {
            try
            {
                var filepath = Server.MapPath(HttpUtility.HtmlDecode(pdfPath));

                return File(filepath, MimeMapping.GetMimeMapping(filepath), Path.GetFileName(pdfPath));
            }
            catch (Exception exception)
            {
                return null;
            }
        }
    }
}