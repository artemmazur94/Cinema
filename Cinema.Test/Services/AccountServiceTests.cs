using System.Linq;
using Cinema.DataAccess;
using Cinema.DataAccess.Repositories;
using Cinema.Services;
using Cinema.Services.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Cinema.Test.Services
{
    [TestClass]
    public class AccountServiceTests
    {
        private readonly CinemaDatabaseEntities _context;
        private readonly AccountService _accountService;

        private Profile _profile;
        private string _password;

        public AccountServiceTests()
        {
            _context = new CinemaDatabaseEntities();
            _accountService = new AccountService(new AccountRepository(_context), new SecurityTokenRepository(_context));
        }

        [TestInitialize]
        public void Initialize()
        {
            _profile = new Profile()
            {
                Name = "name",
                Surname = "surname",
                Account = new Account()
                {
                    Email = "somemail@mail.com",
                    IsAdmin = false,
                    IsBlocked = false,
                    Password = "somepassword",
                    Login = "somelogin"
                }
            };
            _password = _profile.Account.Password;
            _accountService.CreatePassword(_profile.Account);
            _accountService.AddProfile(_profile);
            _accountService.Save();
        }

        [TestCleanup]
        public void RollBack()
        {
            _context.Accounts.RemoveRange(_context.Accounts.Where(x => x.Login == _profile.Account.Login));
            _context.SaveChanges();
        }

        [TestMethod]
        public void CreatePasswordSuccess()
        {
            var account = _profile.Account;
            Assert.AreEqual(account.Password, PasswordManager.GenerateSaltedPassword(_password, account.Salt));
        }

        [TestMethod]
        public void CreatePasswordFailed()
        {
            var password = "somepassword";
            var account = new Account()
            {
                Password = password
            };
            _accountService.CreatePassword(account);
            Assert.AreNotEqual(account.Password, PasswordManager.GenerateSaltedPassword(password+"2", account.Salt));
        }

        [TestMethod]
        public void IsValidLoginDataSuccess()
        {
            var account = new Account()
            {
                Login = "somelogin",
                Password = "somepassword"
            };
            Assert.IsTrue(_accountService.IsValidLoginData(account));
        }

        [TestMethod]
        public void IsvalidLoginDataWrongPassword()
        {
            var account = new Account()
            {
                Login = "somelogin",
                Password = "somewrongpassword"
            };
            Assert.IsFalse(_accountService.IsValidLoginData(account));
        }

        [TestMethod]
        public void IsExistUsernameSuccess()
        {
            Assert.IsTrue(_accountService.IsExistUsername("somelogin"));
            Assert.IsTrue(_accountService.IsExistUsername("SOMELOGIN"));
            Assert.IsTrue(_accountService.IsExistUsername("SOMElogin"));
            Assert.IsFalse(_accountService.IsExistUsername("somewronglogin"));
        }

        [TestMethod]
        public void IsExistEmailSuccess()
        {
            Assert.IsTrue(_accountService.IsExistEmail("somemail@mail.com"));
            Assert.IsTrue(_accountService.IsExistEmail("SOMEMAIL@MAIL.COM"));
            Assert.IsTrue(_accountService.IsExistEmail("someMAIL@mail.COM"));
            Assert.IsFalse(_accountService.IsExistEmail("somewrongmail@mail.com"));
        }
    }
}