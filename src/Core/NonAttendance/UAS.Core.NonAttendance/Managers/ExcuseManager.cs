using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UAS.Core.NonAttendance.Managers
{
    using Configuration;
    using DAL.Common.Model;
    using DAL.Parsers;
    using DAL.Persisters;
    using ModelEnums = DAL.Common.Model.Enums;

    internal class ExcuseManager
    {
        private ExcusePersister _excusePersister;
        private NonAttendanceManager _nonAttendanceManager;
        public ExcuseManager()
        {
            _excusePersister = new ExcusePersister();
            _nonAttendanceManager = new NonAttendanceManager();
        }

        public IQueryable<ClassificationByRoleView> GetExcuseClassifications(int roleId)
        {
            return _excusePersister.GetExcuseClassifications(roleId);
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
                GenerateApproversRegister(excuseToSave.IdNonAttendance, excuseToSave.Id);
                _nonAttendanceManager.UpdateHasExcuse(excuseToSave.IdNonAttendance, true);
            });
        }

        internal ExcuseApprovalView GetExcuseForApproval(int idExcuse)
        {
            return _excusePersister.GetExcuseForApproval(idExcuse);
        }

        internal List<Attachment> GetAttachments(int idExcuse)
        {
            return _excusePersister.GetAttachments(idExcuse).ToList();
        }

        internal List<StatusByRoleView> GetExcuseStatus(int roleId)
        {
            return _excusePersister.GetStatus(roleId).ToList();
        }

        internal void ApproveExcuses(List<ExcuseApprovalView> excuseApprovals)
        {
            excuseApprovals.ForEach(
                excuseApproval =>
                {
                    var approvalStatus = ModelEnumParser.StatusParser(excuseApproval.IdStatusApproval);
                    var approverRole = ModelEnumParser.RoleParser(excuseApproval.IdRoleApprover);
                    var wasApprovedByTeacher = WasApprovedByTeacher(approverRole, approvalStatus);
                    var wasApprovedByDirector = WasApprovedByDirector(approverRole, approvalStatus);

                    if (wasApprovedByTeacher)
                    {
                        GenerateApproversRegister(excuseApproval.IdNonAttendance, excuseApproval.IdExcuse);
                    }

                    _excusePersister.UpdateExcuseApprovalStatus(
                        excuseApproval.Id, excuseApproval.IdStatusApproval);

                    if (wasApprovedByDirector)
                    {
                        _excusePersister.UpdateExcuseStatus(
                            excuseApproval.IdExcuse, excuseApproval.IdStatusApproval);
                    }

                    if (approvalStatus == ModelEnums.Status.REJECTED)
                    {
                        _excusePersister.UpdateExcuseStatus(
                            excuseApproval.IdExcuse, excuseApproval.IdStatusApproval);
                        _nonAttendanceManager.UpdateHasExcuse(excuseApproval.IdNonAttendance, false);
                    }
                });
        }

        internal List<ExcuseView> GetExcuses(int documentNumber, int roleId)
        {
            var currentRole = ModelEnumParser.RoleParser(roleId);
            var allExcuses = _excusePersister.GetExcuses(documentNumber, roleId);

            if (currentRole == ModelEnums.Role.ADMIN || currentRole == ModelEnums.Role.DIRECTOR) {
                return allExcuses.ToList();
            }

            var excuses = allExcuses.Where(
                filter => filter.TruantDocumentNumber == documentNumber && filter.IdRole == roleId);

            return excuses.ToList();
        }

        private bool WasApprovedByTeacher(ModelEnums.Role approverRole, ModelEnums.Status approvalStatus)
        {
            var wasApproved = approverRole == ModelEnums.Role.TEACHER &&
                        approvalStatus == ModelEnums.Status.APPROVED;
            return wasApproved;
        }

        private bool WasApprovedByDirector(ModelEnums.Role approverRole, ModelEnums.Status approvalStatus)
        {
            var wasApproved = approverRole == ModelEnums.Role.DIRECTOR &&
                        approvalStatus == ModelEnums.Status.APPROVED;
            return wasApproved;
        }

        internal List<ExcuseApprovalView> GetExcusesForApproval(int idExcuse)
        {
            var excuses = _excusePersister.GetExcusesForApproval(idExcuse).ToList();
            return excuses;
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
                IdStatus = (int)ModelEnums.Status.PENDING,
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
            const string ID_SEPARATOR = ",";
            var ids = new List<int>();
            var idsToParse = nonAttendanceIds.Split(new[] { ID_SEPARATOR }, StringSplitOptions.None)
                .ToList();

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
            const string SEPARATOR = "_";

            var attachmentPath =
                    string.Concat(
                        HttpContext.Current.Server.MapPath(
                            ConfigurationManager.AttachmentServerPath),
                            Guid.NewGuid().ToString().ToUpper(),
                            SEPARATOR,
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