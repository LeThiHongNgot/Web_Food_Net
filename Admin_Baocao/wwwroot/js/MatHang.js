var currentReportPage = 1;
var totalReportPage = 0;
const fnbIdRegex = /^[a-zA-Z0-9]{1,5}$/
const fnbPriceRegex = /^[1-9]\d*$/
var catIdToCreate = "";
var fnbImageToCreate = ""
var catIdToUpdate = "";
var fnbImageToUpdate = ""
var selectedFnb = ""


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


function FetchDate() {
    const fromDate = sessionStorage.getItem('fromDate')
    const toDate = sessionStorage.getItem('toDate')
    if (fromDate != null && toDate != null) {
        document.getElementById('datepicker').value = fromDate
        document.getElementById('datepicker1').value = toDate
    }
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
                $(`#reportRow${index + 1}`).append(`<th scope='row' style='font-weight: normal; width: 9vw'>${index + 1}</th>`)
                $(`#reportRow${index + 1}`).append(`<td class='align-middle text-center' style='width: 10vw'><img class='rounded' style='width: 3vw; height: 4.5vh;' src='${currentValue.fnbImage}'></img></td>`)
                $(`#reportRow${index + 1}`).append(`<td class='align-middle' style='width: 19vw'>${currentValue.fnbId}</td>`)
                $(`#reportRow${index + 1}`).append(`<td class='align-middle' style='width: 19vw'>${currentValue.fnbName}</td>`)
                $(`#reportRow${index + 1}`).append(`<td class='align-middle' style='width: 19vw'>${currentValue.categoryName}</td>`)
                $(`#reportRow${index + 1}`).append(`<td class='align-middle text-end' style='color: red;width: 15vw; font-weight: bold'>${FormatCurrency(currentValue.price)} đ</td>`)
                $(`#reportRow${index + 1}`).append(`
                <td class='align-middle'>
                <div class='d-flex align-items-center justify-content-center' style='width: 14vw; height: 3.75vh'>
                <div class='d-flex flex-row justify-content-between' style='width: 4.5vw; height: 3.75vh'>
                <div class='d-flex align-items-center justify-content-center rounded border border-1 border-primary updateFnbButton' style='background-color: white; cursor: pointer; width: 2vw; border-color: red' id='update${currentValue.fnbId}' data-bs-toggle="modal" data-bs-target="#updateMHModal" data-fnb-id = "${currentValue.fnbId}">
                <i class="fa-regular fa-pen-to-square fa-sm" style="color: #0055ff;"></i>
                </div>
                <div class='d-flex align-items-center justify-content-center rounded border border-1 border-danger deleteFnbButton' style='background-color: white; cursor: pointer; width: 2vw' id='delete${currentValue.fnbId}' data-bs-toggle="modal" data-bs-target="#deleteMHModal" data-fnb-id = "${currentValue.fnbId}">
                <i class="fa-regular fa-trash-can fa-sm" style="color: #eb0000;"></i>
                </div>
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


function CreateFnbButtonPress() {
    var fnbId = document.getElementById('createFnbIdInput').value
    var fnbName = document.getElementById('createFnbNameInput').value
    var fnbPrice = document.getElementById('createFnbPriceInput').value
    if (fnbId === "" || fnbName === "" || fnbPrice === "" || catIdToCreate === "" || catIdToCreate === undefined) {
        if (fnbId === "") {
            document.getElementById("FnbIdError").textContent = "Vui lòng nhập mã mặt hàng muốn thêm !"
        }
        else {
            if (!fnbIdRegex.test(fnbId)) {
                document.getElementById("FnbIdError").textContent = "Mã mặt hàng có độ dài tối đa 5 kí tự chỉ bao gồm chữ cái và chữ số"
            }
            else {
                document.getElementById("FnbIdError").textContent = ""
            }
        }

        if (fnbName === "") {
            document.getElementById("FnbNameError").textContent = "Vui lòng nhập tên mặt hàng muốn thêm !"
        }
        else {
            document.getElementById("FnbNameError").textContent = ""
        }

        if (fnbPrice === "") {
            document.getElementById("FnbPriceError").textContent = "Vui lòng nhập đơn giá mặt hàng muốn thêm !"
        }
        else {
            if (!fnbPriceRegex.test(fnbPrice)) {
                document.getElementById("FnbPriceError").textContent = "Đơn giá chỉ bao gồm chữ số và kí tự đầu tiên phải lớn hơn 0"
            }
            else {
                document.getElementById("FnbPriceError").textContent = ""
            }
        }

        if (catIdToCreate === "" || catIdToCreate === undefined) {
            document.getElementById("FnbCatError").textContent = "Vui lòng chọn danh mục của mặt hàng muốn thêm !"
        }
        else {
            document.getElementById("FnbCatError").textContent = ""
        }
    }
    else {
        var allInfoValid = 0;
        document.getElementById("FnbIdError").textContent = ""
        document.getElementById("FnbNameError").textContent = ""
        document.getElementById("FnbPriceError").textContent = ""
        document.getElementById("FnbCatError").textContent = ""
        if (!fnbIdRegex.test(fnbId)) {
            document.getElementById("FnbIdError").textContent = "Mã mặt hàng có tối đa 5 kí tự chỉ bao gồm chữ cái và chữ số"
        }
        else {
            ++allInfoValid
        }

        if (!fnbPriceRegex.test(fnbPrice)) {
            document.getElementById("FnbPriceError").textContent = "Đơn giá chỉ bao gồm chữ số và kí tự đầu tiên phải lớn hơn 0"
        }
        else {
            ++allInfoValid
        }

        allInfoValid += 2
        if (allInfoValid === 4) {
            var inputFiles = document.getElementById('createFnbImageInput').files
            if (inputFiles.length > 0) {
                var fnb = {
                    FnbId: fnbId,
                    FnbName: fnbName,
                    Price: fnbPrice,
                    Image: fnbImageToCreate,
                    Categoryid: catIdToCreate
                }
                $.ajax({
                    url: '/Admin/CreateFnb',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(fnb)
                })
                    .done(function (result) {
                        alert("Thêm mặt hàng thành công !")
                        location.reload()
                    })
                    .fail(function (error) {
                        alert(error.responseText)
                    })
            }
            else {
                var defaultImage = 'data:image/png;base64,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'
                var fnb = {
                    FnbId: fnbId,
                    FnbName: fnbName,
                    Price: fnbPrice,
                    Image: defaultImage,
                    Categoryid: catIdToCreate
                }
                $.ajax({
                    url: '/Admin/CreateFnb',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(fnb)
                })
                    .done(function (result) {
                        alert("Thêm mặt hàng thành công !")
                        location.reload()
                    })
                    .fail(function (error) {
                        alert(error.responseText)
                    })
            }
        }
    }
}


function UpdateFnbButtonPress() {
    var fnbName = document.getElementById('updateFnbNameInput').value
    var fnbPrice = document.getElementById('updateFnbPriceInput').value
    if (fnbName === "" && fnbPrice === "" && (catIdToUpdate === "" || catIdToUpdate === undefined) && fnbImageToUpdate === "") {
        alert("Vui lòng nhập ít nhất 1 thông tin để sửa !")
        document.getElementById("updateFnbNameError").textContent = "Vui lòng nhập tên mặt hàng muốn sửa !"
        document.getElementById("updateFnbPriceError").textContent = "Vui lòng nhập giá mặt hàng muốn sửa !"
        document.getElementById("updateFnbCatError").textContent = "Vui lòng chọn danh mục của mặt hàng muốn sửa"
    }
    else {
        document.getElementById("updateFnbNameError").textContent = ""
        document.getElementById("updateFnbPriceError").textContent = ""
        document.getElementById("updateFnbCatError").textContent = ""
        var inputFiles = document.getElementById('updateFnbImageInput').files
        var allValid = true;
        var fnb = {
            FnbName: null,
            Price: null,
            Image: null,
            Categoryid: null
        }
        if (fnbName != "") {
            fnb.FnbName = fnbName
        }

        if (fnbPrice != "") {
            if (!fnbPriceRegex.test(fnbPrice)) {
                catIdValid = false
                document.getElementById("updateFnbPriceError").textContent = "Đơn giá chỉ bao gồm chữ số và kí tự đầu tiên phải lớn hơn 0"
            }
            else {
                catIdValid = true
                fnb.Price = fnbPrice
            }
        }

        if (inputFiles.length > 0) {
            fnb.Image = fnbImageToUpdate
        }

        if (catIdToUpdate != "") {
            fnb.Categoryid = catIdToUpdate
        }

        if (allValid === true) {
            $.ajax({
                url: `/Admin/UpdateFnb?targetFnbId=${selectedFnb}`,
                contentType: "application/json; charset=utf-8",
                type: "POST",
                data: JSON.stringify(fnb)
            })
                .done(function (result) {
                    alert("Sửa thông tin mặt hàng thành công !")
                    location.reload()
                })
                .fail(function (error) {
                    alert(error.responseText)
                })
        }
    }
}


function DeleteFnbButtonPress() {
    $.ajax({
        url: `/Admin/DeleteFnb?targetFnbId=${selectedFnb}`,
        type: 'DELETE'
    })
        .done(function (result) {
            alert("Xóa mặt hàng thành công !")
            location.reload()
        })
        .fail(function (error) {
            alert(error.responseText)
        })
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
            $("#danhmucMenu").append(`<li><a class='dropdown-item danhmucItem' id=${currentValue.categoryid} style='cursor: pointer'>${currentValue.categoryname}</a></li>`)
            $("#createDanhMucMenu").append(`<li><a class='dropdown-item createFnbCatItem' data-cat-to-create="${currentValue.categoryid}" id=createFnbItem${currentValue.categoryid} style='cursor: pointer'>${currentValue.categoryname}</a></li>`)
            $("#updateDanhMucMenu").append(`<li><a class='dropdown-item updateFnbCatItem' data-cat-to-update="${currentValue.categoryid}" id=updateFnbItem${currentValue.categoryid} style='cursor: pointer'>${currentValue.categoryname}</a></li>`)
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
            })
        })
            .fail(function (error) {
                alert("Đã xảy ra lỗi khi tải dữ liệu !")
            })
    }


    sessionStorage.getItem('danhmucContent') === null ? sessionStorage.setItem('danhmucContent', 'Danh Mục') : console.log("Danh muc content exists")
    document.querySelector("#danhmucContent").innerText = sessionStorage.getItem('danhmucContent')
    sessionStorage.getItem('mathangContent') === null ? sessionStorage.setItem('mathangContent', 'Mặt Hàng') : console.log("Mat hang content exists")
    document.querySelector("#mathangContent").innerText = sessionStorage.getItem('mathangContent')
    sessionStorage.getItem('currentReportPage') === null ? sessionStorage.setItem('currentReportPage', 1) : console.log('Current page exists')



    if ((sessionStorage.getItem('danhmucId') === null || sessionStorage.getItem('danhmucId') === 'undefined') && (sessionStorage.getItem('mathangId') === null || sessionStorage.getItem('mathangId') === 'undefined')) {
        $.ajax({
            url: `/Admin/GetReportFnb`,
            type: "GET"
        })
            .done(function (result) {
                console.log(result)
                FetchReportData(result)
                WorkWithPages()
            })
            .fail(function (error) {
                alert("Đã xảy ra lỗi khi tải dũ liệu !")
            })
    }
    else {
        if (sessionStorage.getItem('mathangId') != 'undefined' && sessionStorage.getItem('mathangId') != null) {
            var mathangId = sessionStorage.getItem('mathangId')
            $.ajax({
                url: `/Admin/GetReportFnb/ById/${mathangId}`,
                type: "GET"
            })
                .done(function (result) {
                    console.log(result)
                    FetchReportData(result)
                    WorkWithPages()
                })
                .fail(function (error) {
                    alert("Đã xảy ra lỗi khi tải dũ liệu !")
                })
        }
        else {
            if (sessionStorage.getItem('danhmucId') != 'undefined' && sessionStorage.getItem('danhmucId') != null) {
                var danhmucId = sessionStorage.getItem('danhmucId')
                $.ajax({
                    url: `/Admin/GetReportFnb/ByCatId/${danhmucId}`,
                    type: "GET"
                })
                    .done(function (result) {
                        console.log(result)
                        FetchReportData(result)
                        WorkWithPages()
                    })
                    .fail(function (error) {
                        alert("Đã xảy ra lỗi khi tải dũ liệu !")
                    })
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
                sessionStorage.setItem('currentReportPage', 1)
                location.reload()
            }
        }
        else {
            if (previousContent != itemValue) {
                sessionStorage.setItem('mathangContent', 'Mặt Hàng')
                sessionStorage.removeItem('mathangId')
                sessionStorage.setItem('currentReportPage', 1)
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
        sessionStorage.setItem('currentReportPage', 1)
        if (previousContent != itemValue) {
            location.reload()
        }
    });


    $(document).on('click', '.createFnbCatItem', function (event) {
        var itemValue = $(this).text();
        document.querySelector("#createFnbCatContent").innerText = itemValue
        catIdToCreate = $(this).data('cat-to-create').toString().trim()
    })


    $(document).on('click', '.updateFnbCatItem', function (event) {
        var itemValue = $(this).text();
        document.querySelector("#updateFnbCatContent").innerText = itemValue
        catIdToUpdate = $(this).data('cat-to-update').toString().trim()
    })


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


    $('#createFnbIdInput').on('input', function () {
        document.getElementById("FnbIdError").textContent = ""
        var fnbId = document.getElementById('createFnbIdInput').value
        if (fnbId === "") {
            document.getElementById("FnbIdError").textContent = ""
        }
        else {
            if (!fnbIdRegex.test(fnbId)) {
                document.getElementById("FnbIdError").textContent = "Mã mặt hàng có độ dài tối đa 5 kí tự chỉ bao gồm chữ cái và chữ số"
            }
            else {
                document.getElementById("FnbIdError").textContent = ""
            }
        }
    })


    $('#createFnbNameInput').on('input', function () {
        document.getElementById("FnbNameError").textContent = ""
    })


    $('#createFnbPriceInput').on('input', function () {
        document.getElementById("FnbPriceError").textContent = ""
        var fnbPrice = document.getElementById('createFnbPriceInput').value
        if (fnbPrice === "") {
            document.getElementById("FnbPriceError").textContent = ""
        }
        else {
            if (!fnbPriceRegex.test(fnbPrice)) {
                document.getElementById("FnbPriceError").textContent = "Đơn giá chỉ bao gồm chữ số và kí tự đầu tiên phải lớn hơn 0"
            }
            else {
                document.getElementById("FnbPriceError").textContent = ""
            }
        }
    })


    $('#updateFnbPriceInput').on('input', function () {
        document.getElementById("updateFnbPriceError").textContent = ""
        var fnbPrice = document.getElementById('updateFnbPriceInput').value
        if (fnbPrice === "") {
            document.getElementById("updateFnbPriceError").textContent = ""
        }
        else {
            if (!fnbPriceRegex.test(fnbPrice)) {
                document.getElementById("updateFnbPriceError").textContent = "Đơn giá chỉ bao gồm chữ số và kí tự đầu tiên phải lớn hơn 0"
            }
            else {
                document.getElementById("updateFnbPriceError").textContent = ""
            }
        }
    })


    $('#createFnbImageInput').on('change', function () {
        const file = this.files[0]
        const reader = new FileReader()
        reader.readAsDataURL(file)
        $("#createFnbButton").prop('disabled', true)
        reader.addEventListener('load', function () {
            console.log(reader.result)
            fnbImageToCreate = reader.result
            $("#createFnbButton").prop('disabled', false)
        })
    })


    $('#updateFnbImageInput').on('change', function () {
        const file = this.files[0]
        const reader = new FileReader()
        reader.readAsDataURL(file)
        $("#updateFnbButton").prop('disabled', true)
        reader.addEventListener('load', function () {
            console.log(reader.result)
            fnbImageToUpdate = reader.result
            $("#updateFnbButton").prop('disabled', false)
        })
    })


    $('#addMHModal').on('show.bs.modal', function () {
        document.getElementById('createFnbImageInput').value = ""
        document.getElementById("FnbIdError").textContent = ""
        document.getElementById("FnbNameError").textContent = ""
        document.getElementById("FnbPriceError").textContent = ""
        document.getElementById("FnbCatError").textContent = ""
        fnbImageToCreate = ""
    })



    $('#updateMHModal').on('show.bs.modal', function (event) {
        document.getElementById('updateFnbImageInput').value = ""
        document.getElementById("updateFnbNameError").textContent = ""
        document.getElementById("updateFnbPriceError").textContent = ""
        document.getElementById("updateFnbCatError").textContent = ""
        selectedFnb = $(event.relatedTarget).data('fnb-id').toString().trim()
        fnbImageToUpdate = ""
    })


    $('#deleteMHModal').on('show.bs.modal', function (event) {
        selectedFnb = $(event.relatedTarget).data('fnb-id').toString().trim()
    })




    $(this).scrollTop(0)


    sessionStorage.setItem('firstRender', false)
})