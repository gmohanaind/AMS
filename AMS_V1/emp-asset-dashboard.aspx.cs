﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMS_V1
{
    public partial class emp_asset_dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {           
            Session["MasterPage"] = this.Master.AppRelativeVirtualPath;

        }
    }
}