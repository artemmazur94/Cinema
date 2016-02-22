﻿using System.Collections.Generic;
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

        // GET: Booking/BookTikets/5
        public ActionResult BookTickets(int? id)
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
            var model = new SeanceViewModel()
            {
                Id = seance.Id,
                Date = seance.DateTime.Date,
                Time = seance.DateTime.TimeOfDay,
                Price = seance.Price,
                HallName = seance.Hall.Name,
                MovieName = _movieService.GetMovieLocalization(seance.MovieId, LanguageHelper.CurrnetCulture).Name
            };
            List<Sector> sectors = _bookingService.GetSectorsByHallId(seance.HallId);
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