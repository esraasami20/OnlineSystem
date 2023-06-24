<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Contact.aspx.cs" Inherits="E_Commerce.Contact" %>



<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    
    <main aria-labelledby="title">
        <div id="add_Category">
            <div class="text-center">
               <h1 class="text-primary">Add Category</h1> 
            </div>
            
            <div class="row m-2">
               <div class="form-group col-6">
                   <label>Arabic Name</label>
                   <input id="catArName" type="text" class="form-control"/>
               </div>
               <div class="form-group col-6">
                    <label>English Name</label>
                   <input  id="catEnName" type="text" class="form-control"/>
               </div>
           </div>

            <div class="row m-2">
               <div class="form-group col-6">
                   <label>Image</label>
                   <input id="catImg" type="file" class="form-control" />
               </div>
              
           </div>
            
             <div class="row m-2">
                <input type="button" class="form-control w-25 offset-3 btn-info bg-info" value="Add Category" id="addCategory"/>
           </div>
        </div>
          <hr />
        <div id="add_Subcategory">
            <div class="text-center">
               <h1 class="text-primary"> Add Sub Category</h1>
            </div>
             <div class="row m-2">
               <div class="form-group col-6">
                   <label>Arabic Name</label>
                   <input id="subArName" type="text" class="form-control"/>
               </div>
               <div class="form-group col-6">
                    <label>English Name</label>
                   <input id="SubEnName" type="text" class="form-control"/>
               </div>
           </div>

            <div class="row m-2">
               <div class="form-group col-6">
                   <label>Image</label>
                   <input id="subFileImg" type="file" class="form-control"/>
               </div>
               <div class="form-group col-6">
                    <label>Category</label>
                   
                  <asp:DropDownList runat="server" ID="categoryList" CssClass="form-control" >
                  </asp:DropDownList>
               </div>
           </div>
        
         <div class="row m-2">
                <input type="button" class="form-control w-25 offset-3 btn-info bg-info" value="Add Sub Category" id="addSubCategoryItem"/>
           </div>
        </div>
        <hr />
        <div id="add_Product">
            <div class="text-center">
               <h1 class="text-primary"> Add Product</h1>
            </div>
             
            <div class="row m-2">
               <div class="form-group col-6">
                   <label>Arabic Name</label>
                   <input id="arName" type="text" class="form-control"/>
               </div>
               <div class="form-group col-6">
                    <label>English Name</label>
                   <input  id="enName" type="text" class="form-control"/>
               </div>
           </div>
           
           <div class="row m-2">
               <div class="form-group col-6">
                   <label>Price</label>
                   <input id="price" type="number" class="form-control"/>
               </div>
               <div class="form-group col-6">
                    <label>Discount</label>
                   <input id="discount" type="number" class="form-control"/>
               </div>
           </div>

           <div class="row m-2">
               <div class="form-group col-6">
                   <label>Description</label>
                   <input id="description" type="text" class="form-control"/>
               </div>
               <div class="form-group col-6">
                    <label>Quantity</label>
                   <input id="quantity" type="number" class="form-control"/>
               </div>
           </div>

           <div class="row m-2">
               <div class="form-group col-6">
                   <label>Image</label>
                   <input id="img" type="file" class="form-control"/>
               </div>
               <div class="form-group col-6">
                    <label>Sub Category</label>
                  <asp:DropDownList runat="server" ID="subCategoryList" CssClass="form-control">

                  </asp:DropDownList>
               </div>
           </div>
      
           <div class="row m-2">
                <input type="button" class="form-control w-25 offset-3 btn-info bg-info" value="Add" id="addProductItem"/>
           </div>
        </div>
          
    </main>


    <script language="javascript" type="text/javascript">

        //add category
        $("#addCategory").on("click", function () {
            if ($("#catArName").val() === "" || $("#catEnName").val() === "" || $("#catImg").val() === "") {
                alert("Plz Fill all Inputs")
                return;
            }
            var getImgName = $("#catImg").val().split("\\");
            var imgName = `/Images/${getImgName[getImgName.length - 1]}`

            data = {
                catArName: $("#catArName").val(),
                catEnName: $("#catEnName").val(),
                catImg: imgName
            }

            $.ajax({
                type: "POST",
                url: "Default.aspx/AddCategory",
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                success: function (result) {
                    $("#catArName").val("");
                    $("#catEnName").val("");
                    $("#catImg").val("");
                    alert("New Category Added Successfully ^_^");
                    location.reload();
                },
                error: function (e) {
                    console.log(e)
                }
            });
        });

        //add product
        $("#addProductItem").on("click", function () {
            debugger;
            if ($("#arName").val() === "" || $("#enName").val() === "" || $("#img").val() === "" || $("#price").val() === "" || $("#description").val() === "" || $("#quantity").val() === "") {
                alert("Plz Fill all Inputs")
                return;
            }
            var getImgName = $("#img").val().split("\\");
            var imgName = `/Images/${getImgName[getImgName.length - 1]}`

            data = {
                arName: $("#arName").val(),
                enName: $("#enName").val(),
                fileImg: imgName, 
                price : $("#price").val(),
                discount : $("#discount").val(),
                description : $("#description").val(),
                quantity : parseInt($("#quantity").val()),
                subCategoryId : parseInt(<%=subCategoryList.ClientID%>.value)
            }
        console.log(data);
            $.ajax({
                type: "POST",
                url: "Default.aspx/AddProduct",
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                success: function (result) {
                    $("#arName").val("");
                    $("#enName").val("");
                    $("#img").val("");
                    alert("New Product Successfully ^_^");
                    location.reload();
                },
                error: function (e) {
                    console.log(e)
                }
            });
        });

        //add sub category
        $("#addSubCategoryItem").on("click", function () {
            if ($("#subArName").val() === "" || $("#SubEnName").val() === "" || $("#subFileImg").val() === "") {
                alert("Plz Fill all Inputs")
                return;
            }
            var getImgName = $("#subFileImg").val().split("\\");
            var imgName = `/Images/${getImgName[getImgName.length - 1]}`

            data = {
                subArName: $("#subArName").val(),
                subEnName: $("#SubEnName").val(),
                subFileImg: imgName,
                categoryId: parseInt(<%=categoryList.ClientID%>.value)
            }

            $.ajax({
                type: "POST",
                url: "Default.aspx/AddSubCategory",
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                success: function (result) {
                    $("#subArName").val("");
                    $("#SubEnName").val("");
                    $("#subFileImg").val("");
                    alert("New SubCategory Added Successfully ^_^");
                    location.reload();
                },
                error: function (e) {
                    console.log(e)
                }
            });
        });

       
    </script>
</asp:Content>
