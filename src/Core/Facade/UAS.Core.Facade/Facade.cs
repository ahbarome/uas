namespace UAS.Core.Facade
{
    using Attendance;
    using NonAttendance;
    using Session;
    using Session.Interfaces;
    using System;
    using DAL.Common.Model;
    using System.Collections.Generic;
    using Report;
    using Dashboard;
    using System.Threading.Tasks;

    public class Facade
    {
        static Facade instance = null;
        private ISessionManager _sessionManager;
        private AttendanceFacade _attendanceFacade;
        private NonAttendanceFacade _nonAttendanceFacade;
        private ReportFacade _reportFacade;
        private DashboardFacade _dashboardFacade;

        public static Facade Instance(Action<string> attendanceDispatcher = null)
        {
            if (instance == null)
                instance = new Facade(attendanceDispatcher);
            return instance;
        }

        public Facade()
        {
            _sessionManager = new SessionManager();
            _attendanceFacade = new AttendanceFacade();
            _nonAttendanceFacade = new NonAttendanceFacade();
            _reportFacade = new ReportFacade();
            _dashboardFacade = new DashboardFacade();
        }

        public Facade(Action<string> attendanceDispatcher = null)
        {
            _sessionManager = new SessionManager();
            _attendanceFacade = new AttendanceFacade(attendanceDispatcher);
            _nonAttendanceFacade = new NonAttendanceFacade();
            _reportFacade = new ReportFacade();
            _dashboardFacade = new DashboardFacade();
        }

        public void CreateSession(string username, string password)
        {
            _sessionManager.CreateSession(username, password);
        }

        public void CloseSession()
        {
            _sessionManager.CloseSession();
        }

        public dynamic GetSession()
        {
            return _sessionManager.GetSession();
        }

        public dynamic GetAllMovementsWithNotifications()
        {
            return _attendanceFacade.GetAllMovementsWithNotifications();
        }

        public dynamic GetAllMovementsWithoutNotifications()
        {
            return _attendanceFacade.GetAllMovementsWithoutNotifications();
        }

        public dynamic GetAllStudentMovementsWithoutNotificationsByTeacherId(int teacherId)
        {
            return _attendanceFacade.GetAllStudentMovementsWithoutNotificationsByTeacherId(teacherId);
        }

        public dynamic GetCourseByTeacherId(int teacherId)
        {
            return _attendanceFacade.GetCourseByTeacherId(teacherId);
        }

        public dynamic GetCurrentCourseByTeacherDocumentNumber(int teacherDocumentNumber)
        {
            return _attendanceFacade.GetCurrentCourseByTeacherDocumentNumber(teacherDocumentNumber);
        }

        public dynamic GetStatisticsByCourseAndTeacherId(int courseId, int teacherId)
        {
            return _attendanceFacade.GetStatisticsByCourseAndTeacherId(courseId, teacherId);
        }

        public dynamic GetNonAttendance(int documentNumber, int roleId)
        {
            return _reportFacade.GetNonAttendance(documentNumber, roleId);
        }

        public dynamic GetCourseStatistics(int courseId)
        {
            return _attendanceFacade.GetCourseStatistics(courseId);
        }

        public dynamic GetTeacherById(int teacherId)
        {
            return _attendanceFacade.GetTeacherById(teacherId);
        }

        public dynamic GetCourseAttendanceStatistics(int teacherDocumentNumber)
        {
            return _attendanceFacade.GetCourseAttendanceStatistics(teacherDocumentNumber);
        }

        public dynamic GetAllTeacherMovementsWithoutNotificationsByDirectorId(int directorId)
        {
            return _attendanceFacade.GetAllTeacherMovementsWithoutNotificationsByDirectorId(directorId);
        }

        public dynamic GetExcusesForApproval(int documentNumber, int roleId)
        {
            return _nonAttendanceFacade.GetExcusesForApproval(documentNumber, roleId);
        }

        public dynamic GetExcusesForApproval(int idExcuse)
        {
            return _nonAttendanceFacade.GetExcusesForApproval(idExcuse);
        }

        public dynamic GetTeacherAttendanceStatistics()
        {
            return _attendanceFacade.GetTeacherAttendanceStatistics();
        }

        public dynamic GetNonAttendancePendingForExcuse(int documentNumber, int roleId)
        {
            return _nonAttendanceFacade.GetNonAttendancePendingForExcuse(documentNumber, roleId);
        }

        public dynamic GetExcuseClassifications(int roleId)
        {
            return _nonAttendanceFacade.GetExcuseClassifications(roleId);
        }

        public dynamic GetAttachments(int idExcuse)
        {
            return _nonAttendanceFacade.GetAttachments(idExcuse);
        }

        public dynamic GetExcuseForApproval(int idExcuse)
        {
            return _nonAttendanceFacade.GetExcuseForApproval(idExcuse);
        }

        public void SaveExcuse(Excuse excuse)
        {
            _nonAttendanceFacade.SaveExcuse(excuse);
        }

        public dynamic GetExcuseStatus(int roleId)
        {
            return _nonAttendanceFacade.GetExcuseStatus(roleId);
        }

        public void ApproveExcuses(List<ExcuseApprovalView> excuses)
        {
            _nonAttendanceFacade.ApproveExcuses(excuses);
        }

        public dynamic GetExcuses(int documentNumber, int roleId)
        {
            return _nonAttendanceFacade.GetExcuses(documentNumber, roleId);
        }

        public dynamic GetAttendance(int documentNumber, int roleId)
        {
            return _reportFacade.GetAttendance(documentNumber, roleId);
        }

        public dynamic GetStatistictsAttendanceVsNonAttendance(int documentNumber, int roleId)
        {
            return _dashboardFacade.GetStatistictsAttendanceVsNonAttendance(documentNumber, roleId);
        }

        public async Task<dynamic> GetStatistictsAttendanceVsNonAttendanceAsync(int documentNumber, int roleId)
        {
            return await _dashboardFacade.GetStatistictsAttendanceVsNonAttendanceAsync(documentNumber, roleId);
        }

        public dynamic GetCurrentAcademicPeriod()
        {
            return _dashboardFacade.GetCurrentAcademicPeriod();
        }

        public dynamic GetTopStatistictExcuseClassifications(int documentNumber, int roleId)
        {
            return _dashboardFacade.GetTopStatistictExcuseClassifications(documentNumber, roleId);
        }

        public dynamic GetStatistictExcuseStatus(int documentNumber, int roleId)
        {
            return _dashboardFacade.GetStatistictExcuseStatus(documentNumber, roleId);
        }

        public dynamic GetTopStatistictsMajorMonthsAttendanceAndNonAttendance(int documentNumber, int roleId)
        {
            return _dashboardFacade.GetTopStatistictsMajorMonthsAttendanceAndNonAttendance(documentNumber, roleId);
        }

        public dynamic GetTopStatistictAttendanceAndNonAttendanceTeacherCourse(int documentNumber, int roleId)
        {
            return _dashboardFacade.GetTopStatistictAttendanceAndNonAttendanceTeacherCourse(documentNumber, roleId);
        }

        public dynamic GetTopStatistictAttendanceAndNonAttendanceStudentCourse(int documentNumber, int roleId)
        {
            return _dashboardFacade.GetTopStatistictAttendanceAndNonAttendanceStudentCourse(documentNumber, roleId);
        }

        public dynamic GetTopStatistictsMajorCourseAttendanceAndNonAttendance(int documentNumber, int roleId)
        {
            return _dashboardFacade.GetTopStatistictsMajorCourseAttendanceAndNonAttendance(documentNumber, roleId);
        }
    }
}
