using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace Cinema.Web.Helpers
{
    public class ImageHelper
    {
        private const string FORMAT_JPG = ".jpg";
        private const string FORMAT_PNG = ".png";
        private const string FORMAT_JPEG = ".jpeg";
        private static List<string> AllowedFormats => new List<string>() { FORMAT_JPEG, FORMAT_JPG, FORMAT_PNG };

        public static bool IsImage(string filename)
        {
            return AllowedFormats.Any(format => filename.EndsWith(format, StringComparison.OrdinalIgnoreCase));
        }

        public static byte[] ConvertImageToByteArray(HttpPostedFileBase file)
        {
            byte[] data = new byte[file.ContentLength];
            using (Stream stream = file.InputStream)
            {
                stream.Read(data, 0, file.ContentLength);
            }
            return data;
        }

        //public static HttpPostedFileBase ConvertByteArrayToImage(byte[] data)
        //{
        //    HttpPostedFileBase file = new HttpPostedFileWrapper(null);
        //    using (Stream stream = file.InputStream)
        //    {
        //        stream.Write(data, 0, data.Length);
        //    }
        //    return file;
        //}
    }
}