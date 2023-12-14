var currentReportPage = 1;
var totalReportPage = 0;
var selectedCategory = '';
const regex = /^CT[0-9]{3}$/


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



function WorkWithPages() {
    if (parseInt(sessionStorage.getItem('totalReportPage')) > 1) {
        if (parseInt(sessionStorage.getItem('currentReportPage')) <= 1) {
            $("#previousButton").hide()
            $("#nextButton").show()
        }
        else if (parseInt(sessionStorage.getItem('currentReportPage')) === parseInt(sessionStorage.getItem('totalReportPage'))) {
            $("#nextButton").hide()
            $("#previousButton").show()
        }
        else if (parseInt(sessionStorage.getItem('currentReportPage')) > 1 && parseInt(sessionStorage.getItem('currentReportPage')) < parseInt(sessionStorage.getItem('totalReportPage'))) {
            $("#previousButton").show()
            $("#nextButton").show()
        }
    }
    else {
        $("#previousButton").hide()
        $("#nextButton").hide()
    }
}


function CreateCategory(category) {
    console.log(category)
    console.log(JSON.stringify(category))
    $.ajax({
        url: `/Admin/CheckCategoryExists/${category.Categoryid}`,
        type: "GET"
    })
        .done(function (result) {
            console.log(result)
            if (result > 0) {
                alert("Danh mục đã tồn tại trong hệ thống !")
            }
            else {
               $.ajax({
                   url: '/Admin/CreateCategory',
                   contentType: "application/json; charset=utf-8",
                   type: "POST",
                   data: JSON.stringify(category)
               })
               .done(function (result) {
                    alert("Thêm danh mục thành công !")
                    location.reload()
               })
               .fail(function (error) {
                    alert("Đã xảy ra lỗi khi thêm danh mục !")
               })
            }
        })
        .fail(function (error) {
            alert("Đã xảy ra lỗi khi thêm danh mục !")
        })
}


function CreateCatButtonPress() {
    var CategoryId = document.getElementById("createCatIdInput").value
    var CategoryName = document.getElementById("createCatNameInput").value
    if (CategoryId === "" || CategoryName === "") {
        if (CategoryId === "") {
            document.getElementById("catIdError").textContent = "Vui lòng nhập mã danh mục !"
        }
        else {
            if (!regex.test(CategoryId)) {
                document.getElementById("catIdError").textContent = "Mã danh mục có độ dài 5 kí tự, bao gồm 2 chữ cái đầu là CT, còn lại là các số từ 0 đến 9!"
            }
            else {
                document.getElementById("catIdError").textContent = ""
            }
        }
        if (CategoryName === "") {
            document.getElementById("catNameError").textContent = "Vui lòng nhập tên danh mục !"
        }
        else {
            document.getElementById("catNameError").textContent = ""
        }
    }
    else {
        document.getElementById("catIdError").textContent = ""
        document.getElementById("catNameError").textContent = ""
        if (!regex.test(CategoryId)) {
            document.getElementById("catIdError").textContent = "Mã danh mục có độ dài 5 kí tự, bao gồm 2 chữ cái đầu là CT, còn lại là các số từ 0 đến 9!"
        }
        else {
            var category = {
                Categoryid: CategoryId,
                Categoryname: CategoryName
            }
            document.getElementById("catIdError").textContent = ""
            CreateCategory(category);
        }
    }
}


function UpdateCatButtonPress() {
    var CategoryName = document.getElementById("updateCatNameInput").value
    if (CategoryName === "") {
        document.getElementById("updateCatNameError").textContent = "Vui lòng nhập thông tin bạn muốn sửa !"
    }
    else {
        document.getElementById("updateCatNameError").textContent = ""
        var catIdValid = true;
        var category = {
            Categoryid: null,
            Categoryname: null
        }

        if (CategoryName != "") {
            category.Categoryname = CategoryName
        }

        if (catIdValid === true) {
            updateCategory(selectedCategory.toString().trim(), category)
        }
    }
}


function updateCategory(targetCatId, category) {
    $.ajax({
        url: `/Admin/UpdateCategory?targetCatId=${targetCatId}`,
        contentType: "application/json; charset=utf-8",
        type: "POST",
        data: JSON.stringify(category)
    })
        .done(function (result) {
            alert("Cập nhật thông tin danh mục thành công !")
            location.reload()
        })
        .fail(function (error) {
            alert("Đã xảy ra lỗi khi cập nhật thông tin !")
        })
}


function DeleteCatButtonPress() {
    $.ajax({
        url: `/Admin/DeleteCategory?targetCatId=${selectedCategory}`,
        type: "DELETE"
    })
        .done(function (result) {
            alert("Xóa danh mục thành công !")
            location.reload()
        })
        .fail(function (error, textStatus, errorThrown) {
            alert(error.responseText)
        })
}


function FetchReportData(result) {
    if (result != null && result.length > 0) {
        totalReportPage = Math.ceil(result.length / 10)
        sessionStorage.setItem('reportData', JSON.stringify(result))
        sessionStorage.setItem('totalReportPage', totalReportPage)
        currentReportPage = parseInt(sessionStorage.getItem('currentReportPage'))
        var reportData = JSON.parse(sessionStorage.getItem('reportData'))
        reportData.forEach(function (currentValue, index, arr) {
            if (index + 1 > currentReportPage * 10 - 10 && index + 1 <= currentReportPage * 10) {
                $("#reportTableBody").append(`<tr id='reportRow${index + 1}'></tr>`)
                $(`#reportRow${index + 1}`).append(`<th class='align-middle' scope='row' style='font-weight: normal'>${index + 1}</th>`)
                $(`#reportRow${index + 1}`).append(`<td class='align-middle' style='width: 19vw'>${currentValue.categoryId}</td>`)
                $(`#reportRow${index + 1}`).append(`<td class='align-middle'>${currentValue.categoryName}</td>`)
                $(`#reportRow${index + 1}`).append(`
                <td class='d-flex align-items-center justify-content-center'>
                <div class='d-flex flex-row justify-content-between' style='width: 4.5vw; height: 3.75vh'>
                <div class='d-flex align-items-center justify-content-center rounded border border-2 updateCatButton' style='background-color: #d5d6e4; cursor: pointer; width: 2vw; border-color: red' id='update${currentValue.categoryId}' data-bs-toggle="modal" data-bs-target="#updateDMModal" data-cat-id = "${currentValue.categoryId}">
                <i class="fa-solid fa-pen-to-square fa-sm" style="color: #808080;"></i>
                </div>
                <div class='d-flex align-items-center justify-content-center rounded deleteCatButton' style='background-color: #e60b0b; cursor: pointer; width: 2vw' id='delete${currentValue.categoryId}' data-bs-toggle="modal" data-bs-target="#deleteDMModal" data-cat-id = "${currentValue.categoryId}">
                <i class="fa-regular fa-trash-can fa-sm" style="color: #ffffff;"></i>
                </div>
                </div>
                </td>
                `)
            }
        })
    }
    else {
        sessionStorage.setItem('totalReportPage', 1)
        alert('Không tìm thấy thông tin !')
    }
}


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


    sessionStorage.getItem('danhmucContent') === null ? sessionStorage.setItem('danhmucContent', 'Danh Mục') : console.log("Danh muc content exists")
    document.querySelector("#danhmucContent").innerText = sessionStorage.getItem('danhmucContent')
    sessionStorage.getItem('currentReportPage') === null ? sessionStorage.setItem('currentReportPage', 1) : console.log('Current page exists')



    if (sessionStorage.getItem('danhmucId') === null || sessionStorage.getItem('danhmucId') === 'undefined') {
        $.ajax({
            url: `/Admin/GetReportCat`,
            type: "GET"
        })
            .done(function (result) {
                console.log(result)
                FetchReportData(result)
                WorkWithPages()
            })
            .fail(function (error) {
                alert("Đã xảy ra lỗi khi tải dữ liệu !")
            })
    }
    else {
        var danhmucId = sessionStorage.getItem('danhmucId')
        $.ajax({
            url: `/Admin/GetReportCat/ById/${danhmucId}`,
            type: "GET",
        })
            .done(function (result) {
                FetchReportData(result)
                WorkWithPages()
            })
            .fail(function (error) {
                console.log(error)
                alert("Đã xảy ra lỗi khi tải dữ liệu !")
            })
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
                sessionStorage.setItem('currentReportPage', 1)
                location.reload()
            }
        }
        else {
            if (previousContent != itemValue) {
                sessionStorage.setItem('currentReportPage', 1)
                location.reload()
            }
        }
    });


    $("#previousButton").click(function () {
        currentReportPage = parseInt(sessionStorage.getItem('currentReportPage'))
        --currentReportPage
        sessionStorage.setItem('currentReportPage', currentReportPage)
        console.log("Go Back");
        location.reload()
    });


    $("#nextButton").click(function () {
        currentReportPage = parseInt(sessionStorage.getItem('currentReportPage'))
        ++currentReportPage
        sessionStorage.setItem('currentReportPage', currentReportPage)
        console.log("Go Next");
        location.reload()
    });


    $("#addDMModal").on('show.bs.modal', function () {
        document.getElementById("catIdError").textContent = ""
        document.getElementById("catNameError").textContent = ""
    });


    $("#updateDMModal").on('show.bs.modal', function (event) {
        document.getElementById("updateCatNameError").textContent = ""
        selectedCategory = $(event.relatedTarget).data('cat-id')
    });


    $("#deleteDMModal").on('show.bs.modal', function (event) {
        selectedCategory = $(event.relatedTarget).data('cat-id')
    });


    $('#createCatIdInput').on('input', function (e) {
        var CategoryId = document.getElementById("createCatIdInput").value
        document.getElementById("catIdError").textContent = ""
        if (CategoryId === "") {
            document.getElementById("catIdError").textContent = ""
        }
        else {
            if (!regex.test(CategoryId)) {
                document.getElementById("catIdError").textContent = "Mã danh mục có độ dài 5 kí tự, bao gồm 2 chữ cái đầu là CT, còn lại là các số từ 0 đến 9!"
            }
            else {
                document.getElementById("catIdError").textContent = ""
            }
        }
    });


    $(this).scrollTop(0)


    sessionStorage.setItem('firstRender', false)

})