using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using System.Web.Routing;
using Cinema.DataAccess;
using Cinema.Services.Contracts;
using Cinema.Web.Helpers;
using Cinema.Web.Models;

namespace Cinema.Web.Controllers
{
    [HandleLogError]
    public class BookingController : Controller
    {
        private readonly IBookingService _bookingService;
        private readonly IMovieService _movieService;
        private readonly IAccountService _accountService;

        private const string MESSAGE_KEY = "Message";

        public BookingController(IBookingService bookingService, IMovieService movieService, IAccountService accountService)
        {
            _bookingService = bookingService;
            _movieService = movieService;
            _accountService = accountService;
        }

        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
            LanguageHelper.InitializeCulture(HttpContext);
        }

        // GET: Booking/Seances/5
        public ActionResult Seances(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Movie movie = _movieService.GetMovie(id.Value);
            if (movie == null)
            {
                return HttpNotFound();
            }
            List<Seance> seances = _bookingService.GetActiveSeancesByMovieId(id.Value);
            var seanceModels = seances.Select(seance => new SeanceViewModel()
            {
                Id = seance.Id,
                Date = seance.DateTime.Date,
                Time = seance.DateTime.TimeOfDay,
                HallName = seance.Hall.Name,
                Price = seance.Price
            }).ToList();
            var model = new MovieSeanceViewModel()
            {
                Id = movie.Id,
                Name = _movieService.GetMovieLocalization(id.Value, LanguageHelper.CurrnetCulture).Name,
                Poster = movie.Photo,
                Seances = seanceModels
            };
            return View(model);
        }

        [Authorize]
        // GET: Booking/BookTikets/5
        public ActionResult SelectSeats(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadGateway);
            }
            Seance seance = _bookingService.GetSeance(id.Value);
            if (seance == null)
            {
                return HttpNotFound();
            }
            MovieLocalization movieLocalization = _movieService.GetMovieLocalization(seance.MovieId,
                LanguageHelper.CurrnetCulture);
            var model = new SeanceViewModel()
            {
                Id = seance.Id,
                Date = seance.DateTime.Date,
                Time = seance.DateTime.TimeOfDay,
                Price = seance.Price,
                HallName = seance.Hall.Name,
                MovieName = movieLocalization.Name,
                MovieId = movieLocalization.MovieId
            };
            List<Sector> sectors = _bookingService.GetSectorsByHallId(seance.HallId);
            if (sectors.Count > 0)
            {
                model.HallPlan = HallHelper.CreateHallPlan(sectors);
                int accountId = _accountService.GetAccountByUsername(User.Identity.Name).Id;
                List<Ticket> seanceTickets = _bookingService.GetSeanceTickets(seance.Id);
                List<TicketPreOrder> seanceTicketPreOrders = _bookingService.GetSeanceTicketPreOrdersOfOtherUsers(seance.Id, accountId);
                model.Seats = HallSeat.GetAllSeats(seanceTickets, seanceTicketPreOrders);
                model.SelectedSeats = HallSeat.GetAllSeats(_bookingService.GetSeanceTicketPreOrdersForCurrentUser(seance.Id, accountId));
            }
            if (TempData[MESSAGE_KEY] != null)
            {
                ViewBag.Message = TempData[MESSAGE_KEY].ToString();
            }
            return View(model);
        }
        
        [Authorize]
        [HttpPost]
        public ActionResult ChangePlaceStatus(int row, int place, int seanceId)
        {
            int accountId = _accountService.GetAccountByUsername(User.Identity.Name).Id;
            if (_bookingService.IsTicketAbleToBook(row, place, seanceId) && !_bookingService.IsSeatBindedToOtherUser(row, place, seanceId, accountId))
            {
                if (_bookingService.IsSeatBindedByCurrnetUser(row, place, seanceId, accountId))
                {
                    _bookingService.RemoveTicketPreOrderForUser(row, place, seanceId, accountId);
                    _bookingService.Commit();
                    return Json(new
                    {
                        Status = "free",
                        Success = true
                    });
                }
                var ticketPreOrder = new TicketPreOrder()
                {
                    DateTime = DateTime.UtcNow,
                    Place = place,
                    Row = row,
                    SeanceId = seanceId
                };
                if (User.Identity.IsAuthenticated)
                {
                    ticketPreOrder.AccountId = _accountService.GetAccountByUsername(User.Identity.Name).Id;
                }
                _bookingService.AddTicketPreOrder(ticketPreOrder);
                _bookingService.Commit();
                return Json(new
                {
                    Status = "occupied",
                    Success = true
                });
            }
            return Json(new
            {
                Success = false
            });
        }

        [Authorize]
        public ActionResult CancelSelectedSeats(int? seanceId)
        {
            if (seanceId == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadGateway);
            }
            Seance seance = _bookingService.GetSeance(seanceId.Value);
            if (seance == null)
            {
                return HttpNotFound();
            }
            _bookingService.MarkTicketPreOrdersAsDeletedForUser(seanceId.Value,
                _accountService.GetAccountByUsername(User.Identity.Name).Id);
            _bookingService.Commit();
            return RedirectToAction("Seances", new { id = seance.MovieId});
        }

        [Authorize]
        public ActionResult ConfirmSelectedSeats(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadGateway);
            }
            Seance seance = _bookingService.GetSeance(id.Value);
            if (seance == null)
            {
                return HttpNotFound();
            }
            MovieLocalization movieLocalization = _movieService.GetMovieLocalization(seance.MovieId,
                LanguageHelper.CurrnetCulture);
            var model = new SeanceViewModel()
            {
                Id = seance.Id,
                Date = seance.DateTime.Date,
                Time = seance.DateTime.TimeOfDay,
                Price = seance.Price,
                HallName = seance.Hall.Name,
                MovieName = movieLocalization.Name,
                MovieId = movieLocalization.MovieId,
                SelectedSeats =
                    HallSeat.GetAllSeats(_bookingService.GetSeanceTicketPreOrdersForCurrentUser(seance.Id,
                        _accountService.GetAccountByUsername(User.Identity.Name).Id))
            };
            List<Sector> sectors = _bookingService.GetSectorsByHallId(seance.HallId);
            HallSeat.SetSeatTypes(model.SelectedSeats, sectors);
            return View(model);
        }

        public ActionResult BookTickets(int? seanceId)
        {
            if (seanceId == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadGateway);
            }
            Seance seance = _bookingService.GetSeance(seanceId.Value);
            if (seance == null)
            {
                return HttpNotFound();
            }
            int accountId = _accountService.GetAccountByUsername(User.Identity.Name).Id;
            List<TicketPreOrder> ticketPreOrders = _bookingService.GetSeanceTicketPreOrdersForCurrentUser(seanceId.Value,accountId);
            if (ticketPreOrders.Count == 0)
            {
                TempData[MESSAGE_KEY] = "Sorry, choosen tickets are already booked. You can choose other onces.";
                return RedirectToAction("SelectSeats", new { id = seance.Id });
            }
            List<Ticket> tickets = (from ticketPreOrder in ticketPreOrders
                select new Ticket()
                {
                    Place = ticketPreOrder.Place,
                    Row = ticketPreOrder.Row,
                    SaleDate = DateTime.UtcNow,
                    Seance = seance,
                    AccountId = accountId
                }).ToList();
            _bookingService.RemoveTicketPreOrdersForUser(seance.Id, accountId);
            _bookingService.AddTickets(tickets);
            _bookingService.Commit();
            return RedirectToAction("Index", "Movie");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _movieService.Dispose();
                _bookingService.Dispose();
                _accountService.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}