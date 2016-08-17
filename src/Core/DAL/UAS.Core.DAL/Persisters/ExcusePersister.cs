using System;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class ExcusePersister : BaseContext
    {
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Classification> GetExcuseClassifications()
        {
            var classfications = base.Entities.Classifications;
            return classfications;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="excuse"></param>
        public void Save(Excuse excuse)
        {
            try
            {
                base.Entities.Excuses.Add(excuse);
                base.Entities.SaveChanges();
            }
            catch (Exception exception)
            {
                throw new Exception(
                    "EXC: Se presentaron inconvenientes guardando la excusa", exception);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IQueryable<Excuse> List()
        {
            var excuses = base.Entities.Excuses;
            return excuses;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="nonAttendanceId"></param>
        /// <param name="excuseId"></param>
        public void GenerateApproversRegister(int nonAttendanceId, int excuseId)
        {
            try
            {
                base.Entities.GenerateApproversRegister(nonAttendanceId, excuseId);
            }
            catch (Exception exception)
            {
                throw new Exception(
                    "EXC: Se presentaron inconvenientes generando los registros para la aprobación",
                    exception);
            }

        }

        public IQueryable<Attachment> GetAttachments(int idExcuse)
        {
            var attachments = base.Entities.Attachments.Where(
                filter => filter.IdExcuse == idExcuse);

            return attachments;
        }

        public ExcuseApprovalView GetExcusesForApproval(int idExcuse)
        {
            var excuse = base.Entities.ExcuseApprovalView.Where(
                filter => filter.IdExcuse == idExcuse).FirstOrDefault();

            return excuse;
        }

        public IQueryable<ExcuseApprovalView> GetExcusesForApproval(int documentNumber, int roleId)
        {
            var excusesBase = base.Entities.ExcuseApprovalView.Where(
                filter => filter.Approver == documentNumber && filter.IdRoleApprover == roleId);

            var excuses = excusesBase.Where(filter => filter.IdStatusApproval == 1);

            return excuses;
        }

        public IQueryable<Status> GetStatus() {
            var status = base.Entities.Status;
            return status;
        }

        public void UpdateExcuseApprovalStatus(int id, int statusId)
        {
            var excuse = base.Entities.ExcuseApprovals.Where(
                filter => filter.Id == id).FirstOrDefault();

            excuse.IdStatus = statusId;
            base.Entities.SaveChanges();
        }
    }
}
