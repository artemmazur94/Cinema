using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using Cinema.DataAccess;
using Cinema.Services.Contracts;
using Cinema.Web.Helpers;
using Cinema.Web.Models;

namespace Cinema.Web.Controllers
{
    [HandleLogError]
    public class AccountController : Controller
    {
        private readonly IAccountService _accountService;
        private readonly IBookingService _bookingService;
        private readonly IMovieService _movieService;

        private const string MESSAGE_KEY = "Message";

        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
            LanguageHelper.InitializeCulture(HttpContext);
        }

        public AccountController(IAccountService accountService, IBookingService bookingService, IMovieService movieService)
        {
            _accountService = accountService;
            _bookingService = bookingService;
            _movieService = movieService;
        }

        public ActionResult Register()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterViewModel model)
        {
            if (!ModelState.IsValid) return View();
            if (!_accountService.IsExistUsername(model.Username))
            {
                if (!_accountService.IsExistEmail(model.Email))
                {
                    model.Email = model.Email.ToLower();
                    var profile = new Profile()
                    {
                        Name = model.Name,
                        Surname = model.Surname,
                        Account = new Account()
                        {
                            Email = model.Email,
                            Login = model.Username,
                            Password = model.Password
                        }
                    };
                    _accountService.CreatePassword(profile.Account);
                    _accountService.AddProfile(profile);
                    _accountService.Commit();
                    FormsAuthentication.SetAuthCookie(model.Username, true);
                    return RedirectToAction("Index", "Movie");
                }
                ModelState.AddModelError("", "User with this email already exists");
                return View(model);
            }
            ModelState.AddModelError("", "User with this username already exists");
            return View(model);
        }

        public ActionResult Login()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            return View();
        }

        [HttpPost]
        // TODO: Post from 2 different login pages in one browser (antiforgety tocken expects loged in user)
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model)
        {
            if (!ModelState.IsValid) return View();
            if (!_accountService.IsExistUsername(model.Username))
            {
                ModelState.AddModelError("", "There is no user with such username");
                return View();
            }
            if (_accountService.IsValidLoginData(model.ToAccount()))
            {
                FormsAuthentication.SetAuthCookie(model.Username, model.RememberMe);
                return RedirectToAction("Index", "Movie");
            }
            ModelState.AddModelError("", "Wrong password");
            return View();
        }

        public ActionResult RestorePassword()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RestorePassword(EmailViewModel model)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            if (ModelState.IsValid)
            {
                if (_accountService.IsExistEmail(model.Email))
                {
                    _accountService.RestorePassword(model.Email, Request.Url.Authority);
                    _accountService.Commit();
                    Session[MESSAGE_KEY] = "Message for restoring password was sent to your email.";
                    return RedirectToAction("ShowMessage");
                }
                ModelState.AddModelError("", "There is no user with such email.");
            }
            return View();
        }

        [Authorize]
        public ActionResult LogOut()
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Movie");
        }

        public ActionResult UpdatePassword(string token)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            Guid guid;
            if (!Guid.TryParse(token, out guid))
            {
                Session[MESSAGE_KEY] = "Invalid security token.";
                return RedirectToAction("ShowMessage");
            }
            var username = _accountService.GetUsernameByToken(guid);
            if (username == null)
            {
                Session[MESSAGE_KEY] = "Link is invalid or out of date.";
                return RedirectToAction("ShowMessage");
            }
            var model = new UpdatePasswordViewModel()
            {
                Username = username,
                Token = guid
            };
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdatePassword(UpdatePasswordViewModel model)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            if (ModelState.IsValid)
            {
                _accountService.UpdatePassword(model.Username, model.Password);
                _accountService.UseSecurityToken(model.Token);
                _accountService.Commit();
                Session[MESSAGE_KEY] = "Your password was updated.";
                return RedirectToAction("ShowMessage");
            }
            return View(model);
        }

        public ActionResult ShowMessage()
        {
            if (Session[MESSAGE_KEY] == null)
            {
                return RedirectToAction("Index", "Movie");
            }
            string message = (string)Session[MESSAGE_KEY];
            Session[MESSAGE_KEY] = null;
            return View("ShowMessage", model: message);
        }

        [Authorize]
        public ActionResult MyProfile()
        {
            Profile profile = _accountService.GetProfileByUsername(User.Identity.Name);
            var model = new ProfileViewModel()
            {
                Id = profile.Id,
                Name = profile.Name,
                Surname = profile.Surname,
                ImageBytes = profile.ImageData
            };
            if (profile.Phone != null)
            {
                model.Phone = PhoneNumberHelper.GetMaskFormPhone(profile.Phone);
            }
            return View(model);
        }

        [Authorize]
        public ActionResult ChangePassword()
        {
            return View();
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChangePassword(ChangePasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                var account = new Account()
                {
                    Login = User.Identity.Name,
                    Password = model.OldPassword
                };
                if (_accountService.IsValidLoginData(account))
                {
                    _accountService.ChangePassword(account.Login, model.NewPassword);
                    _accountService.Commit();
                    return RedirectToAction("MyProfile", "Account");
                }
                ModelState.AddModelError("key", "Wrong old password.");
            }
            return View(model);
        }

        [Authorize]
        public ActionResult EditProfile()
        {
            Profile profile = _accountService.GetProfileByUsername(User.Identity.Name);
            var model = new ProfileViewModel()
            {
                Id = profile.Id,
                Name = profile.Name,
                Surname = profile.Surname
            };
            if (profile.Phone != null)
            {
                model.Phone = PhoneNumberHelper.GetMaskFormPhone(profile.Phone);
            }
            return View(model);
        }

        [Authorize]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult EditProfile(ProfileViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.Photo == null || ImageHelper.IsImage(model.Photo.FileName))
                {
                    Profile profile = _accountService.GetProfileByUsername(User.Identity.Name);
                    profile.Name = model.Name;
                    profile.Surname = model.Surname;
                    profile.Phone = !String.IsNullOrEmpty(model.Phone) ? PhoneNumberHelper.GetPhoneFromMask(model.Phone) : null;
                    if (model.Photo != null)
                    {
                        profile.ImageData = ImageHelper.ConvertImageToByteArray(model.Photo);
                    }
                    _accountService.Commit();
                    return RedirectToAction("MyProfile", "Account");
                }
                ModelState.AddModelError("", "Photo has bad format.Allowed formats are '.png', '.jpeg', '.jpg'.");
            }
            return View(model);
        }

        [Authorize]
        public ActionResult MyTickets()
        {
            int accountId = _accountService.GetAccountByUsername(User.Identity.Name).Id;
            List<Ticket> tickets = _bookingService.GetTicketsForUser(accountId);
            List<int> movieIds = (from ticket in tickets select ticket.Seance.MovieId).Distinct().ToList();
            List<MovieLocalization> movieLocalizations = _movieService.GetMovieLocalizations(movieIds, LanguageHelper.CurrnetCulture);
            List<TicketViewModel> ticketViewModels = (from ticket in tickets select new TicketViewModel()
            {
                Date = ticket.Seance.DateTime.Date,
                Time = ticket.Seance.DateTime.TimeOfDay,
                HallName = ticket.Seance.Hall.Name,
                Id = ticket.Id,
                MovieName = (from movieLocalization in movieLocalizations where ticket.Seance.MovieId == movieLocalization.MovieId select movieLocalization.Name).First(),
                Price = ticket.Seance.Price,
                Seat = new HallSeat()
                {
                    Row = ticket.Row,
                    Place = ticket.Place,
                    Type = _bookingService.GetSeatType(ticket.Seance.HallId, ticket.Row, ticket.Place)
                }
            }).ToList();
            MyTicketsViewModel model = new MyTicketsViewModel()
            {
                PastTickets =
                    (from ticketViewModel in ticketViewModels
                        where ticketViewModel.Date < DateTime.UtcNow
                        select ticketViewModel).ToList(),
                UpcomingTickets =
                    (from ticketViewModel in ticketViewModels
                        where ticketViewModel.Date >= DateTime.UtcNow
                        select ticketViewModel).ToList()
            };
            return View(model);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _accountService.Dispose();
                _bookingService.Dispose();
                _movieService.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}