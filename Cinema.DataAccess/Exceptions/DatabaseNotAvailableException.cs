using System;

namespace Cinema.DataAccess.Exceptions
{
    public class DatabaseNotAvailableException : Exception
    {
        public DatabaseNotAvailableException() {}

        public DatabaseNotAvailableException(string message) : base(message) {}
    }
}