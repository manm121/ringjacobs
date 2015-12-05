using System;
using System.Web.Services;
using System.Net;
using System.IO;
using System.Web.Script.Services;

namespace RingWayJacobsProxy
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string GetTrackingData()
        {
            string url = "https://api.masternautconnect.com/connect-webservices/services/public/v1/customer/26225/tracking/live";
            return MakeServiceRequest(url);
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string GetVehicleData()
        {
            string url = "https://api.masternautconnect.com/connect-webservices/services/public/v1/customer/26225/vehicle";
            return MakeServiceRequest(url);
        }

        private static string MakeServiceRequest(string url, string username = "RingwayJacobsAPI", string password = "qg073wwqas")
        {
            // Create a request for the URL. 
            WebRequest request = WebRequest.Create(url);

            String encoded = System.Convert.ToBase64String(System.Text.Encoding.GetEncoding("ISO-8859-1").GetBytes(username + ":" + password));
            request.Headers.Add("Authorization", "Basic " + encoded);

            WebResponse response = request.GetResponse();

            Stream dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();

            return responseFromServer;
        }
    }
}
