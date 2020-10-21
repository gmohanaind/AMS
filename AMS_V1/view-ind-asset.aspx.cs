using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMS_V1
{
    public partial class ViewAsset : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        void Page_PreInit(Object sender, EventArgs e)
        {            
            this.MasterPageFile = Session["MasterPage"].ToString();
        }
    }
}