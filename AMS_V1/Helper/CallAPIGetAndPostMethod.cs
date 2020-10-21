using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Net;
using System.Net.Http;
using System.IO;
using Newtonsoft.Json.Linq;
using AMS_V1.Models;
using System.Text;
using System.Web.Configuration;
using System.Data;
using System.Threading.Tasks;

namespace AMS_V1.Helper
{
    public class CallAPIGetAndPostMethod
    {
        public async Task<DataTable> getDropDownValues(string methodName)
        {
            string uriUrl = WebConfigurationManager.AppSettings["apiUrl"].ToString() + methodName; //"http://localhost:57080/api/Asset/" + methodName;
            DataTable retDt = new DataTable();
            try
            {
                string apiUrl = uriUrl;

                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = new Uri(apiUrl);
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));

                    HttpResponseMessage response = await client.GetAsync(apiUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        retDt = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(await response.Content.ReadAsStringAsync());
                    }


                }
            }
            catch (Exception ex)
            {
                var x = ex.ToString();
            }
            return retDt;
        }

        public async Task<string> executeScalar(string methodName)
        {
            string uriUrl = WebConfigurationManager.AppSettings["apiUrl"].ToString() + methodName; //"http://localhost:57080/api/Asset/" + methodName;
            string retVal = "";
            try
            {     
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = new Uri(uriUrl);
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));

                    HttpResponseMessage response = await client.GetAsync(uriUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        retVal = await response.Content.ReadAsStringAsync();
                    }
                }
            }
            catch (Exception ex)
            {
                var x = ex.ToString();
            }
            return retVal;
        }
        public async Task<int> insertData(string methodName, StringContent data)
        {
            string uriUrl = WebConfigurationManager.AppSettings["apiUrl"].ToString() + methodName;
            var client = new HttpClient();

            var response = await client.PostAsync(uriUrl, data);

            string result = response.Content.ReadAsStringAsync().Result;
            return Convert.ToInt32(result);
        }
    }
}