using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using Cinema.DataAccess;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.Services
{
    public class MovieService : IDisposable
    {
        private readonly IMovieRepository _movieRepository;
        private readonly IGenreRepository _genreRepository;
        private readonly IPersonRepository _personRepository;

        private bool _disposed;

        public MovieService(IMovieRepository movieRepository, IGenreRepository genreRepository, IPersonRepository personRepository)
        {
            _movieRepository = movieRepository;
            _genreRepository = genreRepository;
            _personRepository = personRepository;
        }

        public void Save()
        {
            _movieRepository.Save();
            _genreRepository.Save();
            _personRepository.Save();
        }

        public List<Movie> GetAllMovies()
        {
            return _movieRepository.Find(x => x.IsDeleted == false).ToList();
        }

        public Movie GetMovie(int id)
        {
            return _movieRepository.Find(x => x.Id == id && x.IsDeleted == false).FirstOrDefault();
        }

        public MovieLocalization GetMovieLocalization(int id, int languageId)
        {
            return _movieRepository.GetMovieLocalization(id, languageId);
        }

        public string GetGenreLocalizationName(int genreId, int languageId)
        {
            return _genreRepository.GetGenreLocalization(genreId, languageId).Name;
        }

        public List<string> GetActorLocalizations(ICollection<Person> actors, int languageId)
        {
            return _personRepository.GetActorLocalizations(actors, languageId);
        }

        public List<PersonLocalization> GetActorLocalizationsForMovies(List<int> personIds, int languageId)
        {
            return _personRepository.GetActorLocalizationsForMovies(personIds, languageId);
        }

        public string GetDirectorLocalization(int directorId, int languageId)
        {
            return _personRepository.GetPersonLocalization(directorId, languageId).Name;
        }

        public List<GenreLocalization> GetAllGenreLocalizations(int languageId)
        {
            return _genreRepository.GetAllGenreLocalizations(languageId);
        }

        public List<PersonLocalization> GetAllPersonLocalizations(int languageId)
        {
            return _personRepository.GetAllPersonLocalizations(languageId);
        }

        public Photo SetPhotoToDirectory(HttpPostedFileBase poster, string serverPath)
        {
            string extention = System.IO.Path.GetExtension(poster.FileName);
            var guid = Guid.NewGuid();
            string path = ConfigurationManager.AppSettings["PhotoDirectory"] + guid + extention;
            poster.SaveAs(serverPath + path);
            var photo = new Photo()
            {
                Filename = poster.FileName,
                GUID = guid,
                Path = path
            };
            return photo;
        }

        public List<Person> GetSelectedActors(List<int> actorIds)
        {
            return _personRepository.GetSelectedActors(actorIds);
        }

        public void AddMovieLocalization(MovieLocalization movieLocalization)
        {
            _movieRepository.AddMovieLocalization(movieLocalization);
        }

        public List<int> GetActorIdsForMovie(int movieId)
        {
            return _personRepository.GetActorIdsForMovie(movieId);
        }

        public void RemoveMovie(int id)
        {
            Movie movie = _movieRepository.Get(id);
            movie.IsDeleted = true;
            _movieRepository.Save();
        }

        public void DeletePreviousPhotoFromDirectory(Photo photo, string serverPath)
        {
            if (System.IO.File.Exists(serverPath + photo.Path))
            {
                System.IO.File.Delete(serverPath + photo.Path);
            }
            _movieRepository.DeletePhoto(photo);
        }

        public List<GenreLocalization> GetGenresForMovies(List<int> genreIds, int languageId)
        {
            return _genreRepository.GetGenresForMovies(genreIds, languageId);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _movieRepository.Dispose();
                    _genreRepository.Dispose();
                    _personRepository.Dispose();
                }
            }
            _disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}