﻿using System;
using System.Collections.Generic;
using System.Linq;
using UAS.Core.Attendance.Interfaces;
using UAS.Core.Attendance.Managers;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DTO.Entities;

namespace UAS.Core.Attendance
{
    public class AttendanceFacade : IAttendanceFacade
    {
        private CourseManager _courseManager;
        private TeacherManager _teacherManager;
        private MovementManager _movementManager;
        private Action<string> _dispatcher;

        public AttendanceFacade(Action<string> dispatcher = null)
        {
            this._dispatcher = dispatcher;
            _movementManager = new MovementManager(dispatcher);
            _courseManager = new CourseManager();
            _teacherManager = new TeacherManager();
        }

        public IQueryable<Movement> GetAllMovementsWithNotifications()
        {
            return _movementManager.GetAllMovementsWithNotifications();
        }
        public IQueryable<Movement> GetAllMovementsWithoutNotifications()
        {
            return _movementManager.GetAllMovementsWithoutNotifications();
        }

        public List<StudentMovement> GetAllStudentMovementsWithoutNotificationsByTeacherId(int teacherId)
        {
            return _movementManager.GetAllStudentMovementsWithoutNotificationsByTeacherId(teacherId);
        }

        public Course GetCourseByTeacherId(int teacherId)
        {
            return _courseManager.GetCourseByTeacherId(teacherId);
        }

        public Course GetCurrentCourseByTeacherDocumentNumber(int teacherDocumentNumber)
        {
            return _courseManager.GetCurrentCourseByTeacherDocumentNumber(teacherDocumentNumber);
        }

        public object GetStatisticsByCourseAndTeacherId(int courseId, int teacherId)
        {
            return _courseManager.GetStatisticsByCourseAndTeacherId(courseId, teacherId);
        }

        public Statistic GetCourseStatistics(int courseId)
        {
            return _courseManager.GetCourseStatistics(courseId);
        }

        public Teacher GetTeacherById(int teacherId)
        {
            return _teacherManager.GetTeacherById(teacherId);
        }

        public Statistic GetCourseAttendanceStatistics(int teacherDocumentNumber)
        {
            return _courseManager.GetCourseAttendanceStatistics(teacherDocumentNumber);
        }

        public List<TeacherMovement> GetAllTeacherMovementsWithoutNotificationsByDirectorId(int directorId)
        {
            return _movementManager.GetAllTeacherMovementsWithoutNotificationsByDirectorId(directorId);
        }

        public Statistic GetTeacherAttendanceStatistics()
        {
            return _teacherManager.GetTeacherAttendanceStatistics();
        }

        public SpaceDTOCollection GetAvailableSpacesForMovements()
        {
            return _movementManager.GetAvailableSpacesForMovements();
        }

        public void GenerateMovement(MovementDTO movementDTO)
        {
            _movementManager.GenerateMovement(movementDTO);
        }
    }
}
