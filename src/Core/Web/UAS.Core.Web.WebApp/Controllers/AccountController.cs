using System;
using System.Web.Mvc;
using UAS.Core.Security.Validator;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class AccountController : Controller
    {
        private readonly AccountValidator _validator = new AccountValidator();
        public AccountController()
        {
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login(string username, string password)
        {
            try {
                _validator.Validate(username, password);
                return RedirectToAction("Index", "Home"); ;
            }
            catch (Exception exception) {
                return Index();
            }
        }

    }
}
