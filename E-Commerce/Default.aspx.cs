using E_Commerce.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;

namespace E_Commerce
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindData();
        }
        protected void BindData()
        {
            List<Product> products = new List<Product>();

            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                products = _OnlineShop.Products.Where(a => !a.Isdeleted).ToList();
                       
                Products.DataSource = products.OrderByDescending(a => a.En_Name);
                Products.DataBind();
            }

            
        }
        [WebMethod]
        public static Category AddCategory(string catArName, string catEnName, string catImg)
        {
            var category = new Category()
            {
                CreatedAt = DateTime.Now,
                Ar_Name = catArName,
                En_Name = catEnName,
                Image = catImg
            };

            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                _OnlineShop.Categories.Add(category);
                _OnlineShop.SaveChanges();
            }


            return category;
        }

        [WebMethod]
        public static SubCategory AddSubCategory(string subArName, string subEnName, string subFileImg, int categoryId)
        {
            var category = new SubCategory()
            {
                CreatedAt = DateTime.Now,
                Ar_Name = subArName,
                En_Name = subEnName,
                Image = subFileImg,
                CategoryId = categoryId
            };

            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                _OnlineShop.SubCategories.Add(category);
                _OnlineShop.SaveChanges();
            }


            return category;
        }

        [WebMethod]
        public static Product AddProduct(string arName, string enName, string fileImg, int subCategoryId, string price, string discount, string description, int quantity)
        {
            var disValue = discount == null || discount == "" ? "0" : discount;
            var product = new Product()
            {
                CreatedAt = DateTime.Now,
                Ar_Name = arName,
                En_Name = enName,
                Image = fileImg,
                SubCategotyId = subCategoryId,
                Price =float.Parse(price),
                Discount = double.Parse(disValue),
                Description = description,
                Quantity = quantity
            };

            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                _OnlineShop.Products.Add(product);
                _OnlineShop.SaveChanges();
            }


            return product;
        }

        [WebMethod]
        public static Product EditProduct(int productId, string arName, string enName, string fileImg, int subCategoryId, string price, string discount, string description, int quantity)
        {
            var disValue = discount == null || discount == "" ? "0" : discount;

            var product = new Product();
            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                var oldProduct = _OnlineShop.Products.FirstOrDefault(a=>a.ProductId == productId);
                if (oldProduct != null)
                {
                    oldProduct.UpdatedAt = DateTime.Now;
                    oldProduct.Ar_Name = arName;
                    oldProduct.En_Name = enName;
                    oldProduct.Image = fileImg;
                    oldProduct.SubCategotyId = subCategoryId;
                    oldProduct.Price = float.Parse(price);
                    oldProduct.Discount = double.Parse(disValue);
                    oldProduct.Description = description;
                    oldProduct.Quantity = quantity;
                    _OnlineShop.SaveChanges();
                    product = oldProduct;
                }
            }


            return product;
        }
        [WebMethod]
        public static Product GetProductById(int productId)
        {

            var product = new Product();
            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                product = _OnlineShop.Products.FirstOrDefault(a => a.ProductId == productId);
            }


            return product;
        }

        [WebMethod]
        public static Product DeleteProduct(int productId)
        {

            var product = new Product();
            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                var oldProduct = _OnlineShop.Products.FirstOrDefault(a => a.ProductId == productId);
                if (oldProduct != null)
                {

                    oldProduct.Isdeleted = true;
                    _OnlineShop.SaveChanges();
                    product = oldProduct;
                }
            }


            return product;
        }

        [WebMethod]
        public static List<Category> GetCategories()
        {
            List<Category> categories = new List<Category>();

            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                categories = _OnlineShop.Categories.Where(a => !a.Isdeleted).ToList();
            }
            return categories;
        }
        
        [WebMethod]
        public static List<SubCategory> GetSubCategories()
        {
            List<SubCategory> suCategories = new List<SubCategory>();

            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                suCategories = _OnlineShop.SubCategories.Where(a => !a.Isdeleted).ToList();
            }
            return suCategories;
        }
        [WebMethod]
        public static List<Product> GetProducts()
        {
            List<Product> products = new List<Product>();

            using (OnlineShop _OnlineShop = new OnlineShop())
            {
                products = _OnlineShop.Categories.SelectMany(a => a.SubCategories)
                    .SelectMany(a => a.Products).Where(a => !a.Isdeleted).ToList();
            }
            return products;
        }
    }
}