using System;
using System.IO;
using System.Web;
using System.Web.Mvc;
using UAS.Core.Configuration;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class FileManagerController : SessionController
    {
        /// <summary>
        /// Allows the download of files
        /// </summary>
        /// <param name="filename">Filename to download</param>
        /// <returns>Binary content of the file is this exist</returns>
        public FileResult AsyncDownload(string filename)
        {
            try
            {
                var filepath = Server.MapPath(
                    Path.Combine(
                        ConfigurationManager.AttachmentServerPath, 
                        HttpUtility.HtmlDecode(filename)));

                return File(
                    filepath, MimeMapping.GetMimeMapping(filepath), Path.GetFileName(filename));
            }
            catch (Exception exception)
            {
                return null;
            }
        }
    }
}