using System.Net;
using System.Net.Mail;
using System.Text;
using System.Configuration;

namespace Cinema.Services.Helpers
{
    public static class EmailManager
    {
        public static void RestorePasswordEmail(string restoreUrl, string toEmail, string username)
        {
            using (var mailMessage = new MailMessage(ConfigurationManager.AppSettings["SenderEmail"], toEmail))
            {
                var emailBody = new StringBuilder();
                emailBody.AppendFormat("Dear {0},<br/><br/>", username);
                emailBody.Append("Please click on the following link to restore your password:<br/>");
                emailBody.Append(restoreUrl);
                emailBody.Append("<br/><br/>");
                emailBody.Append("<strong>Cinema administration</strong>");

                mailMessage.IsBodyHtml = true;
                mailMessage.Body = emailBody.ToString();
                mailMessage.Subject = "Restore password";

                using (var smtpClient = new SmtpClient("smtp.gmail.com", 587))
                {
                    smtpClient.UseDefaultCredentials = false;
                    smtpClient.Credentials = new NetworkCredential()
                    {
                        UserName = ConfigurationManager.AppSettings["SenderEmail"],
                        Password = ConfigurationManager.AppSettings["PasswordEmail"]
                    };
                    smtpClient.EnableSsl = true;

                    smtpClient.Send(mailMessage);
                }
            }
        }
    }
}
