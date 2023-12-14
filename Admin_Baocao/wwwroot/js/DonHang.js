var currentOrderPage = 1;
var totalOrderPage = 0;
var totalRevenue = 0;
var othersRevenue = 0;
const userIdRegex = /^[a-zA-Z0-9]{1,4}$/
var userIdToCreate = "";


function FormatCurrency(value) {
    var result = ""
    var str_Value = value.toString();
    var dotMark = str_Value.length
    if (str_Value.length > 3) {
        var dotTimesRounded = Math.floor(str_Value.length / 3)
        if (str_Value.length % 3 != 0) {
            for (let i = 1; i <= dotTimesRounded; ++i) {
                var step = 3 * i;
                var valueSubString = str_Value.substring(dotMark, str_Value.length - step)
                result = "." + valueSubString + result;
                dotMark = str_Value.length - step
            }
        }
        else {
            for (let i = 1; i <= dotTimesRounded - 1; ++i) {
                var step = 3 * i;
                var valueSubString = str_Value.substring(dotMark, str_Value.length - step)
                result = "." + valueSubString + result;
                dotMark = str_Value.length - step
            }
        }
        result = str_Value.substring(dotMark, 0) + result
        return result
    }
    return value.toString()
}

function FormatDateTime(input) {
    const fromDate = sessionStorage.getItem('fromDate')
    const toDate = sessionStorage.getItem('toDate')
    if (fromDate != null && toDate != null) {
        document.getElementById('datepicker').value = fromDate
        document.getElementById('datepicker1').value = toDate
    }
}

function FetchDate() {
    const fromDate = sessionStorage.getItem('fromDate')
    const toDate = sessionStorage.getItem('toDate')
    if (fromDate != null && toDate != null) {
        document.getElementById('datepicker').value = fromDate
        document.getElementById('datepicker1').value = toDate
    }
}

function WorkWithPages() {
    if (parseInt(sessionStorage.getItem('totalOrderPage')) > 1) {
        if (parseInt(sessionStorage.getItem('currentOrderPage')) <= 1) {
            $("#previousButton").hide()
            $("#nextButton").show()
        }
        else if (parseInt(sessionStorage.getItem('currentOrderPage')) === parseInt(sessionStorage.getItem('totalOrderPage'))) {
            $("#nextButton").hide()
            $("#previousButton").show()
        }
        else if (parseInt(sessionStorage.getItem('currentOrderPage')) > 1 && parseInt(sessionStorage.getItem('currentOrderPage')) < parseInt(sessionStorage.getItem('totalOrderPage'))) {
            $("#previousButton").show()
            $("#nextButton").show()
        }
    }
    else {
        $("#previousButton").hide()
        $("#nextButton").hide()
    }
}

function CreateOrderButtonPress() {
    var userId = document.getElementById('createuserIdInput').value
    
    if (userId === "" || fnbName === "" || fnbPrice === "" || orderIdToCreate === "" || orderIdToCreate === undefined) {
        if (userId === "") {
            document.getElementById("userIdError").textContent = "Vui lòng nhập mã khách hàng muốn mua hàng !"
        }
        else {
            if (!userIdRegex.test(userId)) {
                document.getElementById("userIdError").textContent = "Mã khách hàng có độ dài tối đa 4 kí tự chỉ bao gồm chữ cái và chữ số"
            }
            else {
                document.getElementById("userIdError").textContent = ""
            }
        }

        if (orderIdToCreate === "" || orderIdToCreate === undefined) {
            document.getElementById("FnbError").textContent = "Vui lòng chọn mặt hàng muốn thêm !"
        }
        else {
            document.getElementById("FnbError").textContent = ""
        }
    }
    else {
        var allInfoValid = 0;
        document.getElementById("userIdError").textContent = ""
        
        document.getElementById("FnbError").textContent = ""
        if (!userIdRegex.test(userId)) {
            document.getElementById("userIdError").textContent = "Mã khách hàng có tối đa 4 kí tự chỉ bao gồm chữ cái và chữ số"
        }
        else {
            ++allInfoValid
        }

        allInfoValid += 1
        if (allInfoValid === 2) {
            
            if (inputFiles.length > 0) {
                var fnb = {
                    userId: userId,
                    FnbName: fnbName,
                    Price: fnbPrice,
                    Image: fnbImageToCreate,
                    Categoryid: orderIdToCreate
                }
                $.ajax({
                    url: '/Admin/CreateOrder',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(fnb)
                })
                    .done(function (result) {
                        alert("Tạo đơn hàng thành công !")
                        location.reload()
                    })
                    .fail(function (error) {
                        alert(error.responseText)
                    })
            }
            else {
                var fnb = {
                    userId: userId,
                    FnbName: fnbName,
                    Price: fnbPrice,
                    Image: defaultImage,
                    Categoryid: orderIdToCreate
                }
                $.ajax({
                    url: '/Admin/CreateOrder',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(fnb)
                })
                    .done(function (result) {
                        alert("Tạo đơn hàng thành công !")
                        location.reload()
                    })
                    .fail(function (error) {
                        alert(error.responseText)
                    })
            }
        }
    }
}

function FetchOrderData(result) {
    if (result != null && result.length > 0) {
        totalOrderPage = Math.ceil(result.length / 10)
        sessionStorage.setItem('orderData', JSON.stringify(result))
        sessionStorage.setItem('totalOrderPage', totalOrderPage)
        currentOrderPage = parseInt(sessionStorage.getItem('currentOrderPage'))
        var orderData = JSON.parse(sessionStorage.getItem('orderData'))
        orderData.forEach(function (currentValue, index, arr) {
            if (index + 1 > currentOrderPage * 10 - 10 && index + 1 <= currentOrderPage * 10) {
                var totalPrice = currentValue.price * currentValue.total
                $("#orderTableBody").append(`<tr id='orderRow${index + 1}'></tr>`)
                $(`#orderRow${index + 1}`).append(`<th scope='row'>${index + 1}</th>`)
                $(`#orderRow${index + 1}`).append(`<td class="fw-light">${currentValue.daytime}</td>`)
                $(`#orderRow${index + 1}`).append(`<td >${currentValue.userId}</td>`)
                $(`#orderRow${index + 1}`).append(`<td class='nowrap'>
                                            <p class='blue-text mb-0'>${currentValue.fnbName}</p>
                                            <div>
                                              <i class='bi bi-receipt-cutoff me-2'><span class='red-text ms-2'></span></i>                                            
                                            </div>
                                            </td>`)
                $(`#orderRow${index + 1}`).append(`<td class='red-text'>${currentValue.amount}</td>`)
                $(`#orderRow${index + 1}`).append(`<td class='red-text'>${FormatCurrency(currentValue.total)} đ</td>`)
                $(`#orderRow${index + 1}`).append(`<td>
                <button type="button" class="btn btn-success me-2" id="chapNhanBtn${index}">CHẤP NHẬN</button>
                <button type = "button" class="btn btn-danger  me-2" id="huyBtn${index}">HỦY</button>
															<span class="text-danger" id="infoIcon${index}"><i class="bi bi-info-circle"></i></span>
															<span class="qua-text"><i class="bi bi-person-check"></i></span>
															</td>`)
                $(`#chapNhanBtn${index}`).click(function () {
                    $(this).text("HOÀN THÀNH");
                    $(`#huyBtn${index}`).hide();
                    totalPrice = currentValue.total;
                    totalRevenue += totalPrice;
                    sessionStorage.setItem('totalRevenue', totalRevenue);
                    document.querySelector("#totalRevenue").innerText = FormatCurrency(parseInt(sessionStorage.getItem('totalRevenue'))) + ' đ';
                    $(`#totalPrice${index}`).text(FormatCurrency(totalPrice) + ' đ');
                    $(`#infoIcon${index}`).hide();
                });

                $(`#huyBtn${index}`).click(function () {
                    $(`#chapNhanBtn${index}`).hide();
                    $(this).css('height', $('#chapNhanBtn' + index).css('height'));
                    $(this).css('width', $('#chapNhanBtn' + index).css('width'));
                    totalPrice = 0;
                    $(`#totalPrice${index}`).text(FormatCurrency(totalPrice) + ' đ');
                });
                /*$(`#orderRow${index + 1}`).append(`<td class='red-text' id='totalPrice${index}'>${FormatCurrency(totalPrice)} đ</td>`)*/
                var totalPrice = currentValue.price * currentValue.total;
                var displayPrice = !isNaN(totalPrice) ? FormatCurrency(totalPrice) + ' đ' : '';
                $(`#orderRow${index + 1}`).append(`<td class='red-text' id='totalPrice${index}'>${displayPrice}</td>`);
            }
        })
        return totalRevenue
    }
    else {
        sessionStorage.setItem('totalOrderPage', 1)
        alert('Không tìm thấy thông tin !')
        return 0
    }
}

function AddItemToOrder(item) {
    var orderData = JSON.parse(sessionStorage.getItem('orderData')) || [];
    orderData.push(item);
    sessionStorage.setItem('orderData', JSON.stringify(orderData));

    var index = orderData.length - 1;
    $("#addFnbToOrderTableBody").append(`<tr id='orderRow${index + 1}'></tr>`);
    $(`#orderRow${index + 1}`).append(`<th scope='row'>${item.fnbName}</th>`);
    $(`#orderRow${index + 1}`).append(`<td>${item.amount}</td>`);
    $(`#orderRow${index + 1}`).append(`<td>
        <button type="button" class="btn btn-danger" id="removeBtn${index}"><i class="bi bi-trash"></i></button>
    </td>`);

    $(`#removeBtn${index}`).click(function () {
        $(`#orderRow${index + 1}`).remove();
        orderData.splice(index, 1);
        sessionStorage.setItem('orderData', JSON.stringify(orderData));
    });
}

$("#createOrderButton").click(function () {
    var orderData = JSON.parse(sessionStorage.getItem('orderData'));
    // Code to send `orderData` to the server and add it to `tbDonHang`
});



$(document).ready(function () {
    if (sessionStorage.getItem('firstRender') !== 'false') {
        sessionStorage.setItem('firstRender', true)
    }

    if (sessionStorage.getItem('firstRender') === 'true') {
        sessionStorage.clear()
    }

    $.ajax({
        url: "/Admin/GetCategories",
        type: "GET",
    }).done(function (result) {
        $("#danhmucMenu").append("<li><a class='dropdown-item danhmucItem' style='cursor: pointer'>" + "Danh Mục" + "</a></li>")
        result.forEach(function (currentValue, index, arr) {
            console.log(currentValue.categoryname)
            $("#danhmucMenu").append("<li><a class='dropdown-item danhmucItem' " + `id=${currentValue.categoryid}` + "style='cursor: pointer'>" + currentValue.categoryname + "</a></li>")
        });
    })

    if (sessionStorage.getItem('danhmucId') != 'undefined' && sessionStorage.getItem('danhmucId') != null) {
        var itemId = sessionStorage.getItem('danhmucId')
        $.ajax({
            url: `/Admin/GetProducts/ById/${itemId}`,
            type: "GET"
        }).done(function (result) {
            $("#mathangMenu").append("<li><a class='dropdown-item mathangItem' style='cursor: pointer'>" + "Mặt Hàng" + "</a></li>")
            result.forEach(function (currentValue, index, arr) {
                $("#mathangMenu").append("<li><a class='dropdown-item mathangItem' " + `id=${currentValue.fnbId}` + "style='cursor: pointer'>" + currentValue.fnbName + "</a></li>")
            });
        })
    }
    else {
        $.ajax({
            url: "/Admin/GetProducts",
            type: "GET",
        }).done(function (result) {
            $("#mathangMenu").append("<li><a class='dropdown-item mathangItem' style='cursor: pointer'>" + "Mặt Hàng" + "</a></li>")
            result.forEach(function (currentValue, index, arr) {
                $("#mathangMenu").append("<li><a class='dropdown-item mathangItem' " + `id=${currentValue.fnbId}` + "style='cursor: pointer'>" + currentValue.fnbName + "</a></li>")
                $("#createMatHangMenu").append(`<li><a class='dropdown-item createOrderCatItem' data-order-to-create="${currentValue.fnbId}" id=createOrderItem${currentValue.fnbId} style='cursor: pointer'>${currentValue.fnbName}</a></li>`)
            })
        })
            .fail(function (error) {
                alert("Đã xảy ra lỗi khi tải dữ liệu !")
            })
    }


    FetchDate()

    sessionStorage.getItem('danhmucContent') === null ? sessionStorage.setItem('danhmucContent', 'Danh Mục') : console.log("Danh muc content exists")
    document.querySelector("#danhmucContent").innerText = sessionStorage.getItem('danhmucContent')
    sessionStorage.getItem('mathangContent') === null ? sessionStorage.setItem('mathangContent', 'Mặt Hàng') : console.log("Mat hang content exists")
    document.querySelector("#mathangContent").innerText = sessionStorage.getItem('mathangContent')
    sessionStorage.getItem('currentOrderPage') === null ? sessionStorage.setItem('currentOrderPage', 1) : console.log('Current page exists')


    if ((sessionStorage.getItem('danhmucId') === null || sessionStorage.getItem('danhmucId') === 'undefined') && (sessionStorage.getItem('mathangId') === null || sessionStorage.getItem('mathangId') === 'undefined')) {
        if (document.getElementById('datepicker').value === '' || document.getElementById('datepicker1').value === '') {
            $.ajax({
                url: "/Admin/GetOrder",
                type: "GET",
            })
                .done(function (result) {
                    sessionStorage.setItem('totalRevenue', FetchOrderData(result))
                    document.querySelector("#totalRevenue").innerText = FormatCurrency(parseInt(sessionStorage.getItem('totalRevenue'))) + ' đ'
                    WorkWithPages()
                })
                .fail(function (error) {
                    alert("Đã xảy ra lỗi khi tải dữ liệu !")
                })
        }
        else {
            var fromDate = FormatDateTime(document.getElementById('datepicker').value)
            var toDate = FormatDateTime(document.getElementById('datepicker1').value)
            $.ajax({
                url: `/Admin/GetOrder/ByDate/${fromDate}&${toDate}`,
                type: "GET"
            })
                .done(function (result) {
                    FetchOrderData(result)
                    document.querySelector("#totalRevenue").innerText = FormatCurrency(parseInt(sessionStorage.getItem('totalRevenue'))) + ' đ'
                    WorkWithPages()
                })
                .fail(function (error) {
                    alert("Đã xảy ra lỗi khi tải dữ liệu !")
                })
        }
    }
    else {
        if (sessionStorage.getItem('mathangId') != 'undefined' && sessionStorage.getItem('mathangId') != null) {
            if (document.getElementById('datepicker').value === '' || document.getElementById('datepicker1').value === '') {
                var mathangId = sessionStorage.getItem('mathangId')
                $.ajax({
                    url: `/Admin/GetOrder/ByFnbId/${mathangId}`,
                    type: "GET",
                })
                    .done(function (result) {
                        FetchOrderData(result)
                        document.querySelector("#totalRevenue").innerText = FormatCurrency(parseInt(sessionStorage.getItem('totalRevenue'))) + ' đ'
                        WorkWithPages()
                        
                    })
                    .fail(function (error) {
                        alert("Đã xảy ra lỗi khi tải dữ liệu !")
                    })
            }
            else {
                var mathangId = sessionStorage.getItem('mathangId')
                var fromDate = FormatDateTime(document.getElementById('datepicker').value)
                var toDate = FormatDateTime(document.getElementById('datepicker1').value)
                $.ajax({
                    url: `/Admin/GetOrdersByFnbIdAndDateRange/${mathangId}&${fromDate}&${toDate}`,
                    type: "GET",
                })
                    .done(function (result) {
                        FetchOrderData(result)
                        document.querySelector("#totalRevenue").innerText = FormatCurrency(parseInt(sessionStorage.getItem('totalRevenue'))) + ' đ'
                        WorkWithPages()
                    })
                    .fail(function (error) {
                        alert("Đã xảy ra lỗi khi tải dữ liệu !")
                    })
            }
        }
        else {
            if (sessionStorage.getItem('danhmucId') != 'undefined' && sessionStorage.getItem('danhmucId') != null) {
                if (document.getElementById('datepicker').value === '' || document.getElementById('datepicker1').value === '') {
                    var danhmucId = sessionStorage.getItem('danhmucId')
                    $.ajax({
                        url: `/Admin/GetOrdersByCategoryId/${danhmucId}`,
                        type: "GET"
                    })
                        .done(function (result) {
                            FetchOrderData(result)
                            document.querySelector("#totalRevenue").innerText = FormatCurrency(parseInt(sessionStorage.getItem('totalRevenue'))) + ' đ'
                            WorkWithPages()
                        })
                        .fail(function (error) {
                            alert("Đã xảy ra lỗi khi tải dữ liệu !")
                        })
                }
                else {
                    var danhmucId = sessionStorage.getItem('danhmucId')
                    var fromDate = FormatDateTime(document.getElementById('datepicker').value)
                    var toDate = FormatDateTime(document.getElementById('datepicker1').value)
                    $.ajax({
                        url: `/Admin/GetOrdersByCategoryIdAndDateRange/${danhmucId}&${fromDate}&${toDate}`,
                        type: "GET",
                    })
                        .done(function (result) {
                            FetchOrderData(result)
                            document.querySelector("#totalRevenue").innerText = FormatCurrency(parseInt(sessionStorage.getItem('totalRevenue'))) + ' đ'
                            WorkWithPages()
                        })
                        .fail(function (error) {
                            console.log(error)
                            alert("Đã xảy ra lỗi khi tải dữ liệu !")
                        })
                }
            }
        }
    }


    $(document).on('click', '.danhmucItem', function () {
        var itemValue = $(this).text();
        var itemId = $(this).attr('id');
        var previousContent = sessionStorage.getItem('danhmucContent').toString()
        document.querySelector("#danhmucContent").innerText = itemValue
        sessionStorage.setItem('danhmucContent', itemValue)
        sessionStorage.setItem('danhmucId', itemId)
        if (itemValue != "Danh Mục") {
            if (previousContent != itemValue) {
                sessionStorage.setItem('mathangContent', 'Mặt Hàng')
                sessionStorage.removeItem('mathangId')
                sessionStorage.setItem('currentOrderPage', 1)
                location.reload()
            }
        }
        else {
            $.ajax({
                url: `/Admin/GetProducts`,
                type: "GET"
            }).done(function (result) {
                document.querySelector("#mathangContent").innerText = "Mặt Hàng"
                $("#mathangMenu").append("<li><a class='dropdown-item mathangItem' style='cursor: pointer'>" + "Mặt hàng" + "</a></li>")
                result.forEach(function (currentValue, index, arr) {
                    $("#mathangMenu").append("<li><a class='dropdown-item mathangItem' " + `id=${currentValue.fnbId}` + "style='cursor: pointer'>" + currentValue.fnbName + "</a></li>")
                });
            })
                .fail(function (error) {
                    alert("Đã xảy ra lỗi khi tải dữ liệu !")
                })

            if (previousContent != itemValue) {
                sessionStorage.setItem('mathangContent', 'Mặt Hàng')
                sessionStorage.removeItem('mathangId')
                sessionStorage.setItem('currentOrderPage', 1)
                location.reload()
            }
        }
    });

    $(document).on('click', '.mathangItem', function () {
        var itemValue = $(this).text();
        var itemId = $(this).attr('id');
        document.querySelector("#mathangContent").innerText = itemValue
        var previousContent = sessionStorage.getItem('mathangContent').toString()
        sessionStorage.setItem('mathangContent', itemValue)
        sessionStorage.setItem('mathangId', itemId)
        sessionStorage.setItem('currentOrderPage', 1)
        if (previousContent != itemValue) {
            location.reload()
        }
    });

    $(document).on('click', '.createOrderCatItem', function (event) {
        var itemValue = $(this).text();
        document.querySelector("#createOrderCatContent").innerText = itemValue
        orderIdToCreate = $(this).data('order-to-create').toString().trim()
    })

    $(document).on('click', '#applyButton', function () {
        if (document.getElementById('datepicker').value === '' || document.getElementById('datepicker1').value === '') {
            alert("Bạn chưa điền đầy đủ ngày muốn truy vấn !")
        }
        else {
            var fromDateParts = document.getElementById('datepicker').value.split("/")
            var toDateParts = document.getElementById('datepicker1').value.split("/")
            const fromDate = new Date(`${fromDateParts[1]}/${fromDateParts[0]}/${fromDateParts[2]}`)
            const toDate = new Date(`${toDateParts[1]}/${toDateParts[0]}/${toDateParts[2]}`)
            if (fromDate.getTime() > toDate.getTime()) {
                alert("Thời gian bắt đầu phải diễn ra trước thời gian kết thúc !")
            }
            else {
                sessionStorage.setItem('fromDate', document.getElementById('datepicker').value)
                sessionStorage.setItem('toDate', document.getElementById('datepicker1').value)
                sessionStorage.setItem('currentOrderPage', 1)
                location.reload()
            }
        }
    })


    $(document).on('click', '#refreshDateButton', function () {
        sessionStorage.removeItem('fromDate')
        sessionStorage.removeItem('toDate')
        sessionStorage.setItem('currentOrderPage', 1)
        location.reload()
    })


    $("#previousButton").click(function () {
        currentOrderPage = parseInt(sessionStorage.getItem('currentOrderPage'))
        --currentOrderPage
        sessionStorage.setItem('currentOrderPage', currentOrderPage)
        console.log("Go Back");
        location.reload()
    });


    $("#nextButton").click(function () {
        currentOrderPage = parseInt(sessionStorage.getItem('currentOrderPage'))
        ++currentOrderPage
        sessionStorage.setItem('currentOrderPage', currentOrderPage)
        console.log("Go Next");
        location.reload()
    });

    $('#createUserIdInput').on('input', function () {
        document.getElementById("userIdError").textContent = ""
        var userId = document.getElementById('createUserIdInput').value
        if (userId === "") {
            document.getElementById("userIdError").textContent = ""
        }
        else {
            if (!userIdRegex.test(userId)) {
                document.getElementById("userIdError").textContent = "Mã Khách hàng có độ dài tối đa 4 kí tự chỉ bao gồm chữ cái và chữ số"
            }
            else {
                document.getElementById("userIdError").textContent = ""
            }
        }
    })

    /*Reset lại modal tạo đơn hàng*/
    $('#addDHModal').on('show.bs.modal', function () {
        document.getElementById("userIdError").textContent = ""
        document.getElementById("FnbError").textContent = ""
    })

    $(this).scrollTop(0)

    sessionStorage.setItem('firstRender', false)


    $('#datepicker').datepicker({
        orientation: "bottom",
        format: "dd/mm/yyyy",
        todayHighlight: true
    });


    $('#datepicker1').datepicker({
        orientation: "bottom",
        format: "dd/mm/yyyy",
        todayHighlight: true
    });
})


