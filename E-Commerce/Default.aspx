<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="E_Commerce._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
         <div class="row">
             
             <asp:Repeater runat="server" ID="Products">
                 <ItemTemplate>
                     <div class="text-center card col-3 m-5">
                         <div class="card-header">
                             <asp:HyperLink runat="server">
                                 <img class="w-50" src="<%# ResolveUrl(Convert.ToString(Eval("Image"))) %>"/>
                             </asp:HyperLink>
                             <img src="Images/delete.png" style="width:20px" onclick="deleteItem('<%# Eval("ProductId") %>')"/>
                             
                         </div>
                         
                         <div class="card-body">
                            
                             <div class="card-body">
                            <asp:HyperLink runat="server" NavigateUrl='<%# Eval("ProductId", "~/About.aspx?id={0}") %>' Text='<%# Eval("En_Name") %>' />
                        </div>
                         </div>
                         <div class="card-footer">
                                 <%# Eval("Price", "{0:#,###}") %> LE
                         </div>
                     </div>
                 </ItemTemplate>
             </asp:Repeater>
        </div>
    </main>
    <script>
     
        function deleteItem(id) {
            data = {
                productId: id
            }

            $.ajax({
                type: "POST",
                url: "Default.aspx/DeleteProduct",
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                success: function (result) {

                    alert("Item Deleted Successfully ^_^");
                    location.reload();
                },
                error: function (e) {
                    console.log(e)
                }
            });
        }
    </script>
</asp:Content>
