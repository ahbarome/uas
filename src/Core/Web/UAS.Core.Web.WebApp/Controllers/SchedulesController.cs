using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class SchedulesController : FirewallController
    {
        private UASEntities db = new UASEntities();

        // GET: /Schedules/
        public ActionResult Index()
        {
            var schedules = db.Schedules.Include(s => s.AcademicPeriod).Include(s => s.Course).Include(s => s.Teacher);
            return View(schedules.ToList());
        }

        // GET: /Schedules/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Schedule schedule = db.Schedules.Find(id);
            if (schedule == null)
            {
                return HttpNotFound();
            }
            return View(schedule);
        }

        // GET: /Schedules/Create
        public ActionResult Create()
        {
            ViewBag.IdAcademicPeriod = new SelectList(db.AcademicPeriods, "Id", "Id");
            ViewBag.IdCourse = new SelectList(db.Courses, "Id", "Name");
            ViewBag.TeacherDocumentNumber = new SelectList(db.Teachers, "DocumentNumber", "Name");
            return View();
        }

        // POST: /Schedules/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="Id,TeacherDocumentNumber,IdCourse,IdAcademicPeriod,Description,RegisterDate")] Schedule schedule)
        {
            if (ModelState.IsValid)
            {
                db.Schedules.Add(schedule);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdAcademicPeriod = new SelectList(db.AcademicPeriods, "Id", "Id", schedule.IdAcademicPeriod);
            ViewBag.IdCourse = new SelectList(db.Courses, "Id", "Name", schedule.IdCourse);
            ViewBag.TeacherDocumentNumber = new SelectList(db.Teachers, "DocumentNumber", "Name", schedule.TeacherDocumentNumber);
            return View(schedule);
        }

        // GET: /Schedules/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Schedule schedule = db.Schedules.Find(id);
            if (schedule == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdAcademicPeriod = new SelectList(db.AcademicPeriods, "Id", "Id", schedule.IdAcademicPeriod);
            ViewBag.IdCourse = new SelectList(db.Courses, "Id", "Name", schedule.IdCourse);
            ViewBag.TeacherDocumentNumber = new SelectList(db.Teachers, "DocumentNumber", "Name", schedule.TeacherDocumentNumber);
            return View(schedule);
        }

        // POST: /Schedules/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="Id,TeacherDocumentNumber,IdCourse,IdAcademicPeriod,Description,RegisterDate")] Schedule schedule)
        {
            if (ModelState.IsValid)
            {
                db.Entry(schedule).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdAcademicPeriod = new SelectList(db.AcademicPeriods, "Id", "Id", schedule.IdAcademicPeriod);
            ViewBag.IdCourse = new SelectList(db.Courses, "Id", "Name", schedule.IdCourse);
            ViewBag.TeacherDocumentNumber = new SelectList(db.Teachers, "DocumentNumber", "Name", schedule.TeacherDocumentNumber);
            return View(schedule);
        }

        // GET: /Schedules/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Schedule schedule = db.Schedules.Find(id);
            if (schedule == null)
            {
                return HttpNotFound();
            }
            return View(schedule);
        }

        // POST: /Schedules/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Schedule schedule = db.Schedules.Find(id);
            db.Schedules.Remove(schedule);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
