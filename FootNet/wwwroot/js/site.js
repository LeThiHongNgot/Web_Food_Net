

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
    var menudrink = document.getElementById("menudrink");
    if (menufood.style.display === "none" || menufood.style.display === "") {
        menufood.style.display = "block";
        menudrink.style.display = "none";
        framedetailcart.style.height = "61vh";
    } else {
        menufood.style.display = "none";
        framedetailcart.style.height = "70vh";
    }
}
function toggledrink() {
    var menudrink = document.getElementById("menudrink");
    var menufood = document.getElementById("menufood");
    var framedetailcart = document.getElementById("framedetailcart");
    if (menudrink.style.display === "none" || menudrink.style.display === "") {
        menudrink.style.display = "block";
        menufood.style.display = "none";
        framedetailcart.style.height = "61vh";
    } else {
        menudrink.style.display = "none";
        framedetailcart.style.height = "70vh";
    }
}
function toggleall() {
    var menudrink = document.getElementById("menudrink");
    var menufood = document.getElementById("menufood");
    var framedetailcart = document.getElementById("framedetailcart");
    menufood.style.display === "none"
    menufood.style.display = "none";
    framedetailcart.style.height = "70vh";
    var products = document.querySelectorAll('.cart-detail');

    products.forEach(function (product) {
        product.style.display = 'block';
    });
}
function history() {

    var cartorder = document.getElementById("cart-order");
    var history = document.getElementById("history");
    if (history.style.display === "none" || history.style.display === "") {
        cartorder.style.display = "none";
        history.style.display = "block";
    } else {
        history.style.display = "none";
        cartorder.style.display = "block";

    }
}
function openPopupTopping(fnbId, fnbName, fnbPrice, Image) {
    window.selectedFnbId = fnbId;
    window.selectedFnbName = fnbName;
    window.selectedFnbPrice = fnbPrice;
    window.selectedFnbImage = Image;
    
    console.log('FnB ID in openPopupTopping:', fnbId);
    console.log('FnB Name in openPopupTopping:', fnbName);
    console.log('FnB Price in openPopupTopping:', fnbPrice);
    console.log('FnB Image in openPopupTopping:', Image);
    
    $.ajax({
        url: '/Home/GetToppings',
        data: { fnbId: fnbId },
        type: 'GET',
        success: function (data) {
            $('#exampleModalToggle2').modal('show');
            var popupContent = $('#popupContent');
            popupContent.empty();

            data.forEach(function (topping) {
                var toppingInfo = (topping.toppingName ? topping.toppingName.toString() : '') + ' - ' + (topping.price ? formatPrice(topping.price) : '');
                popupContent.append('<div><input type="checkbox" class="topping-checkbox" value="' + (topping.toppingId ? topping.toppingId : '') + '" /> ' + toppingInfo + '</div>');
            });
        },
        error: function () {
            alert('Có lỗi xảy ra khi lấy thông tin topping.');
        }
    });
    
}
function formatPrice(price) {
    return price.toLocaleString('en-US') + '₫';
}

window.quantity = 1;

function increaseQuantity() {
    window.quantity++;
    updateQuantityUI();
}

function decreaseQuantity() {
    window.quantity = Math.max(1, window.quantity - 1);
    updateQuantityUI();
}

function updateQuantityUI() {
    $('#quantityInput').val(window.quantity);
    confirmOrder();
}


function confirmOrder() {
    var fnbId = window.selectedFnbId;
    var fnbName = window.selectedFnbName;
    var fnbPrice = window.selectedFnbPrice;
    
    var selectedToppings = [];
    var toppingsPrice = 0;

    $('.topping-checkbox:checked').each(function () {
        var toppingInfo = $(this).closest('div').text().trim();
        var toppingName = toppingInfo.split('-')[0].trim();
        var toppingPrice = parseFloat(toppingInfo.split('-')[1].trim().replace(/\D/g, ''));

        selectedToppings.push(toppingName);
        toppingsPrice += toppingPrice;
    });

    var totalPrice = calculateTotalPrice(fnbPrice, toppingsPrice, window.quantity);
    
    console.log('FnB ID in confirmOrder:', fnbId);
    console.log('FnB Name in confirmOrder:', fnbName);
    console.log('FnB Price in confirmOrder:', fnbPrice);
    console.log('Selected Toppings in confirmOrder:', selectedToppings);
    console.log('Toppings Price in confirmOrder:', toppingsPrice);
    console.log('Total Price in confirmOrder:', totalPrice);
    $.ajax({
        url: '/Home/GetProductImage',
        data: { fnbId: fnbId },
        type: 'GET',
        success: function (productImage) {
            $('#img-product').attr('src', productImage);
        },
        error: function () {
            alert('Có lỗi xảy ra khi lấy hình ảnh sản phẩm.');
        }
    });
    $('.title').text(fnbName);
    $('.topping').html(selectedToppings.map(function (topping) {
        return ' - ' + topping;
    }).join('<br>'));
    $('.totalPrice').text(totalPrice.toLocaleString('en-US') + '₫');
    $('.cart-bought-embrace .cartorderhistory:first-child').css('display', 'block');
    $('.money').text(totalPrice.toLocaleString('en-US') + '₫');
}
function calculateTotalPrice(fnbPrice, toppingsPrice, quantity) {
    var totalPrice = (fnbPrice + toppingsPrice) * quantity;
    return totalPrice;
}

document.addEventListener('DOMContentLoaded', function () {
    const registerForm = document.getElementById('registerForm');

    if (registerForm) {
        registerForm.addEventListener('submit', function (event) {
            event.preventDefault(); // Prevent the default form submission

            const password = registerForm.querySelector('[name="Password"]').value;
            const confirmPassword = registerForm.querySelector('[name="ConfirmPassword"]').value;
            const emailInputValue = registerForm.querySelector('[name="Email"]').value;
            if (!isValidEmail(emailInputValue)) {
                alert("Email không đúng định dạng");
                return;
            } 
            // Check if the password and confirm password match
            if (password !== confirmPassword) {
                alert('Xác nhận mật khẩu không trùng khớp');
                return;
            }


            const formData = new FormData();
            formData.append('Userid', generateUniqueId());
            formData.append('Username', registerForm.querySelector('[name="Username"]').value);
            formData.append('Password', password);
            formData.append('Email', registerForm.querySelector('[name="Email"]').value);
            // Set default values
           
            formData.append('Phoneno', '');
            formData.append('Pointbefore', '0');
            formData.append('Pointtrans', '0');
            formData.append('Pointafter', '0');
            formData.append('Isadmin', 'false');
            console.log('Form Data:', formData);
            fetch('/Create', {
                method: 'POST',
                body: formData
            })
                .then(response => {
                    console.log('Response status:', response.status);

                    if (response.status === 200) {
                        alert('Đăng ký thành công');
                        window.location.reload();
                    } else if (response.status === 400) {
                        // If the response status is 400, parse the JSON response
                        alert('Email đã được đăng ký trước đó. Vui lòng sử dụng địa chỉ email khác.');
                    } else if (!response.ok) {
                        throw new Error(`HTTP error! Status: ${response.status}`);
                    }
                })
                .catch(error => {
                    console.error('Error:', error.message);
                    // Handle any unexpected errors here
                });


                
        });
    }
});

function isValidEmail(email) {
    // Biểu thức chính quy kiểm tra định dạng email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    return emailRegex.test(email);
}
function generateUniqueId() {
    return new Date().getTime().toString(); // Replace this with your unique ID generation logic
}
/*function loginUser() {
    var email = $('#emailInput').val();
    var password = $('#passwordInput').val();

    $.ajax({
        type: 'POST',
        url: '/Login',
        data: { email: email, password: password },
        success: function (data) {
            // Login successful, display a welcome message
            alert('Login successful. Welcome, ' + data.UserName + '!');
        },
        error: function (error) {
            // Login failed, show error message
            alert('Login failed. ' + error.responseJSON.Errors.join('\n'));
        }
    });
}
*/


