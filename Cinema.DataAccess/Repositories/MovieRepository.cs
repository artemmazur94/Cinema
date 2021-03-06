﻿using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess.Repositories
{
    public class MovieRepository: GenericRepositrory<Movie>, IMovieRepository
    {
        private CinemaDatabaseEntities _movieContext => _context;

        public MovieRepository(CinemaDatabaseEntities context) : base(context)
        {
        }

        public MovieLocalization GetMovieLocalization(int id, int languageId)
        {
            return _movieContext.MovieLocalizations.First(x => x.MovieId == id && x.LanguageId == languageId);
        }

        public List<MovieLocalization> GetMovieLocalizationsForPersons(List<int> movieIds, int languageId)
        {
            return
                _movieContext.MovieLocalizations.Where(
                    x => movieIds.Contains(x.MovieId) && x.LanguageId == languageId).ToList();
        }

        public void DeletePhoto(Photo photo)
        {
            _movieContext.Photos.Remove(photo);
        }

        public Photo GetPhotoByMovieId(int movieId)
        {
            return _movieContext.Photos.FirstOrDefault(x => x.Movies.Any(z => z.Id == movieId));
        }

        public List<MovieLocalization> GetMovieLocalizations(List<int> movieIds, int languageId)
        {
            return
                _movieContext.MovieLocalizations.Where(
                    x => movieIds.Contains(x.MovieId) && x.LanguageId == languageId).ToList();
        }

        public void AddMovieLocalization(MovieLocalization movieLocalization)
        {
            _movieContext.MovieLocalizations.Add(movieLocalization);
        }
    }
}