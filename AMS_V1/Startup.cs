using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(AMS_V1.Startup))]
namespace AMS_V1
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            //ConfigureAuth(app);
        }
    }
}
