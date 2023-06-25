using E_Commerce.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace E_Commerce
{
    public partial class About : Page
    {
        string productId=string.Empty;  
        protected void Page_Load(object sender, EventArgs e)
        {

            subCategoryList.DataSource = CreateSubCategories();
            subCategoryList.DataTextField = "En_Name";
            subCategoryList.DataValueField = "SubCategoryId";
            subCategoryList.DataBind();
            productId = Request.QueryString["id"];
            var prodData = _Default.GetProductById(int.Parse(productId));
            arName.Value = prodData.Ar_Name;
            enName.Value = prodData.En_Name;
            price.Value = prodData.Price.ToString();
            discount.Value = prodData.Discount.ToString();
            description.Value = prodData.Description;
            quantity.Value = prodData.Quantity.ToString();
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

        protected void Modify_Click(object sender, EventArgs e)
        {
            var disValue = discount.Value == null || discount.Value == "" ? "0" : discount.Value;
            if (string.IsNullOrEmpty(quantity.Value) || string.IsNullOrEmpty(description.Value) || string.IsNullOrEmpty(price.Value) || string.IsNullOrEmpty(arName.Value) || string.IsNullOrEmpty(enName.Value) || string.IsNullOrEmpty(subCategoryList.SelectedValue) || string.IsNullOrEmpty(fileImg.FileName))
            {
                return;
            }
            var product = new Product();
            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                var oldProduct = _Default.GetProductById(int.Parse(productId));

                if (oldProduct != null)
                {
                    oldProduct.UpdatedAt = DateTime.Now;
                    oldProduct.Ar_Name = arName.Value;
                    oldProduct.En_Name = enName.Value;
                    oldProduct.Image = fileImg.FileName;
                    oldProduct.SubCategotyId =int.Parse( subCategoryList.SelectedValue);
                    oldProduct.Price = float.Parse(price.Value);
                    oldProduct.Discount = double.Parse(disValue);
                    oldProduct.Description = description.Value;
                    oldProduct.Quantity = int.Parse(quantity.Value);
                    _OnlineShop.SaveChanges();
                    fileImg.SaveAs(Server.MapPath("~/Images/") + System.IO.Path.GetFileName(fileImg.FileName));
                    product = oldProduct;
                }
            }

        }
    }
}