// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
function validateNumericInput(input) {
    // Xóa ký tự không phải số từ giá trị của ô văn bản
    input.value = input.value.replace(/[^0-9]/g, '');
}
function increaseQuantity() {
    var quantityInput = document.getElementById('quantityInput');
    var currentValue = parseInt(quantityInput.value, 10) || 0;
    quantityInput.value = currentValue + 1;
}

function decreaseQuantity() {
    var quantityInput = document.getElementById('quantityInput');
    var currentValue = parseInt(quantityInput.value, 10) || 0;
    if (currentValue > 0) {
        quantityInput.value = currentValue - 1;
    }
}

    function toggleCart() {
        var cartElement = document.getElementById("carthistory");
        var chat = document.getElementById("chat");
        if (cartElement.style.display === "none" || cartElement.style.display === "") {
            cartElement.style.display = "block";
            chat.style.display = "none"; 
        } else {
            cartElement.style.display = "none";
        
        }
}
function toggleChat() {
    var cartElement = document.getElementById("carthistory");
    var chat = document.getElementById("chat");
    if (chat.style.display === "none" || chat.style.display === "") {
        cartElement.style.display = "none";
        chat.style.display = "block";
    } else {
        chat.style.display = "none";

    }
}
function showregister() {
    var login = document.getElementById("login");
    var register = document.getElementById("register");
    if (login.style.display === "none" || login.style.display === "") {
        login.style.display = "block";
        register.style.display = "none";
    } else {
        login.style.display = "none";
        register.style.display = "block";

    }
}
function service()
{
    var allcartmenu = document.getElementById("allcartmenu");
    if (allcartmenu.style.display === "none" || allcartmenu.style.display==="")
    {
        allcartmenu.style.display = "block";

    }else
    {
        allcartmenu.style.display = "none";
    }
}
function togglefood() {
    var menufood = document.getElementById("menufood");
    var framedetailcart = document.getElementById("framedetailcart");
    if (menufood.style.display === "none" || menufood.style.display === "") {
        menufood.style.display = "block";
        framedetailcart.style.height = "61vh";
    } else
    {
        menufood.style.display = "none";
        framedetailcart.style.height = "70vh";
    }
}
