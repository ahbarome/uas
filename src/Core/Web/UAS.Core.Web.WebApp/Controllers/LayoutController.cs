﻿using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class LayoutController : Controller
    {
        // GET: Layout
        public ActionResult Navigation()
        {
            return View();
        }
    }
}