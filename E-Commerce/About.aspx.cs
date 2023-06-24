using E_Commerce.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Commerce
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            subCategoryList.DataSource = CreateSubCategories();
            subCategoryList.DataTextField = "En_Name";
            subCategoryList.DataValueField = "SubCategoryId";
            subCategoryList.DataBind();
            string productId = Context.Request.Url.ToString().Split('/').LastOrDefault();
        }
        private List<SubCategory> CreateSubCategories()
        {

            List<SubCategory> suCategories = new List<SubCategory>();

            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                suCategories = _OnlineShop.SubCategories.Where(a => !a.Isdeleted).ToList();
            }
            return suCategories;
        }
    }
}