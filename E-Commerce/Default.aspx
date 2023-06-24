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
                         </div>
                         
                         <div class="card-body">
                             <asp:HyperLink  runat="server" NavigateUrl="https://www.linkedin.com/in/esraasami20/">
                                 <%# Eval("En_Name") %>
                             </asp:HyperLink>
                            <%--<%# Eval("ProductId","~/About.aspx?id={0}") %>--%>
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
        $(document).ready(function () {
            //$.ajax({
            //    type:"GET",
            //    url: "Default.aspx/GetCategories",
            //    contentType: 'application/json; charset=utf-8',
            //    success: function (result) {
            //        console.log(result)
            //        alert(result)
            //    },
            //    error: function (e) {
            //        console.log(e)
            //    }

            //});
        });
        
    </script>
</asp:Content>
