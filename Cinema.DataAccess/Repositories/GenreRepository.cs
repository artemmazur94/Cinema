using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess.Repositories
{
    public class GenreRepository : GenericRepositrory<Genre>, IGenreRepository
    {
        private CinemaDatabaseEntities _genreContext => _context;

        public GenreRepository(CinemaDatabaseEntities context) : base(context)
        {
        }

        public GenreLocalization GetGenreLocalization(int genreId, int languageId)
        {
            return _genreContext.GenreLocalizations.First(x => x.GenreId == genreId && x.LanguageId == languageId);
        }

        public List<GenreLocalization> GetAllGenreLocalizations(int languageId)
        {
            return _genreContext.GenreLocalizations.Where(x => x.LanguageId == languageId).ToList();
        }

        public List<GenreLocalization> GetGenresForMovies(List<int> genreIds, int languageId)
        {
            return _genreContext.GenreLocalizations.Where(x => genreIds.Contains(x.GenreId) && x.LanguageId == languageId).ToList();
        }

        public void AddGenreLocalization(GenreLocalization genreLocalization)
        {
            _genreContext.GenreLocalizations.Add(genreLocalization);
        }
    }
}