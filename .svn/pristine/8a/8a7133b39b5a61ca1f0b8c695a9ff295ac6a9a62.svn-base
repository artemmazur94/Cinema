using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using System.Web.Routing;
using Cinema.DataAccess;
using Cinema.Services;
using Cinema.Web.Helpers;
using Cinema.Web.Models;

namespace Cinema.Web.Controllers
{
    public class BookingController : Controller
    {
        private readonly BookingService _bookingService;
        private readonly MovieService _movieService;

        public BookingController(BookingService bookingService, MovieService movieService)
        {
            _bookingService = bookingService;
            _movieService = movieService;
        }

        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
            LanguageHelper.InitializeCulture(HttpContext);
        }

        // GET: Booking
        public ActionResult Seances(int? movieId)
        {
            if (movieId == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Movie movie = _movieService.GetMovie(movieId.Value);
            if (movie == null)
            {
                return HttpNotFound();
            }
            List<Seance> seances = _bookingService.GetActiveSeancesByMovieId(movieId.Value);
            var seanceModels = seances.Select(seance => new SeanceViewModel()
            {
                Date = seance.DateTime.Date,
                Time = seance.DateTime.TimeOfDay,
                HallName = seance.Hall.Name,
                Price = seance.Price
            }).ToList();
            var model = new MovieSeanceViewModel()
            {
                Name = _movieService.GetMovieLocalization(movieId.Value, LanguageHelper.CurrnetCulture).Name,
                Poster = movie.Photo,
                Seances = seanceModels
            };
            return View(model);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _movieService.Dispose();
                _bookingService.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}