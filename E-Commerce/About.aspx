<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="E_Commerce.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
         <div id="add_Product">
            <div class="text-center">
               <h1 class="text-primary"> Modify Product</h1>
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
                <input type="button" class="form-control w-25 offset-3 btn-info bg-info" value="Modify" id="addProductItem"/>
           </div>
        </div>
    </main>

    <script>

        $(document).ready(function () {
            var id = location.href.substring(location.href.lastIndexOf('/') + 1);
           
            data = {
                productId: parseInt(id),
            }
            console.log(data)
            $.ajax({
                type: "GET",
                url: "Default.aspx/GetProductById",
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                success: function (result) {
                    console.log(result)
                    alert(result)
                },
                error: function (e) {
                    console.log(e)
                }

            });
        });
        //add product
        $("#addProductItem").on("click", function () {
            
            if ($("#arName").val() === "" || $("#enName").val() === "" || $("#img").val() === "" || $("#price").val() === "" || $("#description").val() === "" || $("#quantity").val() === "") {
                alert("Plz Fill all Inputs")
                return;
            }
            var getImgName = $("#img").val().split("\\");
            var imgName = `/Images/${getImgName[getImgName.length - 1]}`
            var productId = location.href.substring(location.href.lastIndexOf('/') + 1);
            console.log(productId)
            data = {
                productId: productId,
                arName: $("#arName").val(),
                enName: $("#enName").val(),
                fileImg: imgName,
                price: $("#price").val(),
                discount: $("#discount").val(),
                description: $("#description").val(),
                quantity: parseInt($("#quantity").val()),
                subCategoryId: parseInt(<%=subCategoryList.ClientID%>.value)
            }

        $.ajax({
            type: "POST",
            url: "Default.aspx/EditProduct",
            data: JSON.stringify(data),
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                $("#arName").val("");
                $("#enName").val("");
                $("#img").val("");
                alert("New Product Successfully ^_^");
                location.reload();
            }
        });
        });
    </script>
</asp:Content>
