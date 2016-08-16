using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UAS.Core.Configuration;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.NonAttendance.Managers
{
    internal class ExcuseManager
    {
        private ExcusePersister _excusePersister;
        private NonAttendanceManager _nonAttendanceManager;
        public ExcuseManager()
        {
            _excusePersister = new ExcusePersister();
            _nonAttendanceManager = new NonAttendanceManager();
        }

        public IQueryable<Classification> GetExcuseClassifications()
        {
            return _excusePersister.GetExcuseClassifications();
        }

        public void Save(Excuse excuse)
        {
            var nonAttandanceIds = GetNonAttendanceIds(excuse.NonAttendanceIds);
            var excuses = GetExcuses(nonAttandanceIds, excuse);
            Save(excuses);   
        }

        private void Save(List<Excuse> excuses)
        {
            excuses.ForEach(excuseToSave =>
            {
                _excusePersister.Save(excuseToSave);
                _nonAttendanceManager.UpdateHasExcuse(excuseToSave.IdNonAttendance, true);
                GenerateApproversRegister(excuseToSave.IdNonAttendance, excuseToSave.Id);
            });
        }

        internal ExcuseApprovalView GetExcuseForApproval(int idExcuse)
        {
            return _excusePersister.GetExcusesForApproval(idExcuse);
        }

        internal List<Attachment> GetAttachments(int idExcuse)
        {
            return _excusePersister.GetAttachments(idExcuse).ToList();
        }

        internal List<ExcuseApprovalView> GetExcusesForApproval(int documentNumber, int roleId)
        {
            var excuses = _excusePersister.GetExcusesForApproval(documentNumber, roleId).ToList();
            return excuses;
        }

        private List<Excuse> GetExcuses(List<int> nonAttandanceIds, Excuse excuse)
        {
            var excuses = new List<Excuse>();

            nonAttandanceIds.ForEach(id => excuses.Add(new Excuse()
            {
                IdNonAttendance = id,
                DocumentNumber = excuse.DocumentNumber,
                IdRole = excuse.IdRole,
                IdStatus = (int)DAL.Common.Model.Enums.Status.PENDING,
                IdClassification = excuse.IdClassification,
                Attachments = StoreAttachments(excuse.Files),
                Justification = excuse.Justification,
                Observation = excuse.Observation,
                RegisterDate = DateTime.Now
            }));

            return excuses;
        }

        private void GenerateApproversRegister(int nonAttendanceId, int excuseId)
        {
            _excusePersister.GenerateApproversRegister(nonAttendanceId, excuseId);
        }

        private List<int> GetNonAttendanceIds(string nonAttendanceIds)
        {
            var idsToParse = nonAttendanceIds.Split(new[] { "," }, StringSplitOptions.None)
                .ToList();

            var ids = new List<int>();

            idsToParse.ForEach(idToParse => ids.Add(int.Parse(idToParse)));

            return ids;
        }

        private List<Attachment> StoreAttachments(IList<HttpPostedFileBase> filesCollection)
        {
            var attachments = new List<Attachment>();
            foreach (var file in filesCollection)
            {
                var attachmentPath = StoreFile(file);
                attachments.Add(new Attachment
                {
                    Path = attachmentPath,
                    RegisterDate = DateTime.Now
                });
            }
            return attachments;
        }

        private string StoreFile(HttpPostedFileBase attachmentFile)
        {
            var attachmentPath =
                    string.Concat(
                        HttpContext.Current.Server.MapPath(ConfigurationManager.AttachmentServerPath),
                        attachmentFile.FileName);
            attachmentFile.SaveAs(attachmentPath);
            return attachmentPath;
        }

        public IQueryable<Excuse> List()
        {
            return _excusePersister.List();
        }
    }
}
