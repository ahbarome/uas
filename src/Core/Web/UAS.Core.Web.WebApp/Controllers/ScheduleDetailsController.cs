using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class ScheduleDetailsController : FirewallController
    {
        private UASEntities db = new UASEntities();

        // GET: /ScheduleDetails/
        public ActionResult Index()
        {
            var scheduledetails = db.ScheduleDetails.Include(s => s.Schedule).Include(s => s.Space);
            return View(scheduledetails.ToList());
        }

        // GET: /ScheduleDetails/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ScheduleDetail scheduleDetail = db.ScheduleDetails.Find(id);
            if (scheduleDetail == null)
            {
                return HttpNotFound();
            }
            return View(scheduleDetail);
        }

        // GET: /ScheduleDetails/Create
        public ActionResult Create()
        {
            ViewBag.IdSchedule = new SelectList(db.Schedules, "Id", "Id");
            ViewBag.IdSpace = new SelectList(db.Spaces, "Id", "Name");
            return View();
        }

        // POST: /ScheduleDetails/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="Id,IdSchedule,DayOfTheWeek,StartTime,EndTime,RegisterDate,IdSpace")] ScheduleDetail scheduleDetail)
        {
            if (ModelState.IsValid)
            {
                db.ScheduleDetails.Add(scheduleDetail);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdSchedule = new SelectList(db.Schedules, "Id", "Description", scheduleDetail.IdSchedule);
            ViewBag.IdSpace = new SelectList(db.Spaces, "Id", "Name", scheduleDetail.IdSpace);
            return View(scheduleDetail);
        }

        // GET: /ScheduleDetails/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ScheduleDetail scheduleDetail = db.ScheduleDetails.Find(id);
            if (scheduleDetail == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdSchedule = new SelectList(db.Schedules, "Id", "Description", scheduleDetail.IdSchedule);
            ViewBag.IdSpace = new SelectList(db.Spaces, "Id", "Name", scheduleDetail.IdSpace);
            return View(scheduleDetail);
        }

        // POST: /ScheduleDetails/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="Id,IdSchedule,DayOfTheWeek,StartTime,EndTime,RegisterDate,IdSpace")] ScheduleDetail scheduleDetail)
        {
            if (ModelState.IsValid)
            {
                db.Entry(scheduleDetail).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdSchedule = new SelectList(db.Schedules, "Id", "Description", scheduleDetail.IdSchedule);
            ViewBag.IdSpace = new SelectList(db.Spaces, "Id", "Name", scheduleDetail.IdSpace);
            return View(scheduleDetail);
        }

        // GET: /ScheduleDetails/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ScheduleDetail scheduleDetail = db.ScheduleDetails.Find(id);
            if (scheduleDetail == null)
            {
                return HttpNotFound();
            }
            return View(scheduleDetail);
        }

        // POST: /ScheduleDetails/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ScheduleDetail scheduleDetail = db.ScheduleDetails.Find(id);
            db.ScheduleDetails.Remove(scheduleDetail);
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
