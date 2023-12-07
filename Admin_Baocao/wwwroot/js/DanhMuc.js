var currentReportPage = 1;
var totalReportPage = 0;
var Revenue = 0


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
                $(`#reportRow${index + 1}`).append(`<td style='width: 19vw'>${currentValue.categoryId}</td>`)
                $(`#reportRow${index + 1}`).append(`<td>${currentValue.categoryName}</td>`)
                $(`#reportRow${index + 1}`).append(`<td style='color: red;width: 15vw; font-weight: bold; text-align: right'>${currentValue.totalAmount}</td>`)
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


    $(this).scrollTop(0)


    sessionStorage.setItem('firstRender', false)

})