using System;
using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess;
using Cinema.DataAccess.Repositories.Contracts;
using Cinema.Services.Contracts;

namespace Cinema.Services
{
    public class PersonService : IPersonService
    {
        private readonly IPersonRepository _personRepository;
        private readonly IMovieRepository _movieRepository;

        private bool _disposed;

        public PersonService(IPersonRepository personRepository, IMovieRepository movieRepository)
        {
            _personRepository = personRepository;
            _movieRepository = movieRepository;
        }

        public void Save()
        {
            _personRepository.Save();
            _movieRepository.Save();
        }

        public List<Person> GetAllPersons()
        {
            return _personRepository.GetAll().ToList();
        }

        public Person GetPerson(int id)
        {
            return _personRepository.Get(id);
        }

        public List<PersonLocalization> GetAllPersonLocalizations(int languageId)
        {
            return _personRepository.GetAllPersonLocalizations(languageId);
        }

        public List<MovieLocalization> GetMovieLocalizations(List<int> movieIds, int languageId)
        {
            return _movieRepository.GetMovieLocalizationsForPersons(movieIds, languageId);
        }

        public void AddPersonLocalization(PersonLocalization personLocalization)
        {
            _personRepository.AddPersonLocalization(personLocalization);
        }

        public PersonLocalization GetPersonLocalization(int id, int languageId)
        {
            return _personRepository.GetPersonLocalization(id, languageId);
        }

        public void RemovePerson(Person person)
        {
            _personRepository.Remove(person);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _movieRepository.Dispose();
                    _personRepository.Dispose();
                }
                _disposed = true;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}