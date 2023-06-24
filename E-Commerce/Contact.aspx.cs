using E_Commerce.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Commerce
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            categoryList.DataSource = CreateDataSource();
            categoryList.DataTextField = "En_Name";
            categoryList.DataValueField = "CategoryId";
            categoryList.DataBind();
            subCategoryList.DataSource = CreateSubCategories();
            subCategoryList.DataTextField = "En_Name";
            subCategoryList.DataValueField = "SubCategoryId";
            subCategoryList.DataBind();
        }

        private List<Category> CreateDataSource()
        {
            List<Category> categories = new List<Category>();

            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                categories = _OnlineShop.Categories.Where(a=> !a.Isdeleted).ToList();
            }
            return categories;
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