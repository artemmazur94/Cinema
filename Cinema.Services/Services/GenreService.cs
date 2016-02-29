using System;
using Cinema.DataAccess;
using Cinema.DataAccess.Repositories.Contracts;
using Cinema.Services.Contracts;

namespace Cinema.Services
{
    public class GenreService : IGenreService
    {
        private readonly IGenreRepository _genreRepository;

        private bool _disposed;

        public GenreService(IGenreRepository genreRepository)
        {
            _genreRepository = genreRepository;
        }

        public void Save()
        {
            _genreRepository.Save();
        }

        public Genre GetGenre(int id)
        {
            return _genreRepository.Get(id);
        }

        public GenreLocalization GetGenreLocalization(int id, int languageId)
        {
            return _genreRepository.GetGenreLocalization(id, languageId);
        }

        public void AddGenreLocalization(GenreLocalization genreLocalization)
        {
            _genreRepository.AddGenreLocalization(genreLocalization);
        }

        public void RemoveGenre(Genre genre)
        {
            _genreRepository.Remove(genre);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _genreRepository.Dispose();
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