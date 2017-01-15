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
        static string SEPARATOR = " | ";
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
            ViewBag.IdSchedule = GetSelectListSchedules();
            ViewBag.IdSpace = GetSelectListSpaces();
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

            ViewBag.IdSchedule = GetSelectListSchedules();
            ViewBag.IdSpace = GetSelectListSpaces();
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
            ViewBag.IdSchedule = GetSelectListSchedules(id);
            ViewBag.IdSpace = GetSelectListSpaces(scheduleDetail.IdSpace);
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
            ViewBag.IdSchedule = GetSelectListSchedules();
            ViewBag.IdSpace = GetSelectListSpaces();
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

        private IQueryable<SelectListItem> GetSelectListSchedules(int? id = null)
        {
            var selectList = from schedules in db.Schedules
                                  select new SelectListItem
                                  {
                                      Value = schedules.Id.ToString(),
                                      Text = schedules.Course.Name + SEPARATOR + schedules.AcademicPeriod.Period,
                                      Selected = schedules.Id == id ? true : false
                                  };


            return selectList;
      
        }

        private IQueryable<SelectListItem> GetSelectListSpaces(int? id = null)
        {
            var selectList = from spaces in db.Spaces
                                  select new SelectListItem
                                  {
                                      Value = spaces.Id.ToString(),
                                      Text = spaces.SpaceType.Type + SEPARATOR + spaces.Name,
                                      Selected = spaces.Id == id ? true : false
                                  };
            return selectList;
        }
    }
}
