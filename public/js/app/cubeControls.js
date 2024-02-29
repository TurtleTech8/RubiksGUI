colorCSSSelector = {
    1: "whiteBox",
    2: "blueBox",
    3: "yellowBox",
    4: "greenBox",
    5: "orangeBox",
    6: "redBox"
}

$(document).ready(function () {

    resetCube()

})


function turnCube(e) {
    $.ajax({
        url : 'cube/turnCube',
        type : 'POST',
        data : {direction: e.innerHTML},
        success : function(data) {
            console.log(data)
            cube = data.response
            fillSide('white', data.response.white)
            fillSide('blue', data.response.blue)
            fillSide('yellow', data.response.yellow)
            fillSide('green', data.response.green)
            fillSide('orange', data.response.orange)
            fillSide('red', data.response.red)
        },
        error : function(request,error)
        {
            console.log(error)
            alert("Request: "+JSON.stringify(request));
        }
    });
}

function resetCube() {
    $.ajax({
        url : 'cube/resetCube',
        type : 'POST',
        success : function(data) {
            console.log(data)
            cube=data.response
            fillSide('white', data.response.white)
            fillSide('blue', data.response.blue)
            fillSide('yellow', data.response.yellow)
            fillSide('green', data.response.green)
            fillSide('orange', data.response.orange)
            fillSide('red', data.response.red)
        },
        error : function(request,error)
        {
            console.log(error)
            alert("Request: "+JSON.stringify(request));
        }
    });
}

function mixCube() {
    $.ajax({
        url : 'cube/mixCube',
        type : 'POST',
        success : function(data) {
            console.log(data)
            cube=data.response
            fillSide('white', data.response.white)
            fillSide('blue', data.response.blue)
            fillSide('yellow', data.response.yellow)
            fillSide('green', data.response.green)
            fillSide('orange', data.response.orange)
            fillSide('red', data.response.red)
        },
        error : function(request,error)
        {
            console.log(error)
            alert("Request: "+JSON.stringify(request));
        }
    });
}

function fillSide(side, faces) {
    // faceElements = $(`[id^=${side}][data-face]`)
    // console.log(faceElements)
    for(x=0; x < faces.length; x++) {
        // console.log(faces[x])
        idSelector = x + 1
        colorSelector = Math.floor(faces[x] / 10)
        faceElement = $(`[id=${side}${idSelector}][data-face]`)
        oldColorSelector = Math.floor(faceElement.attr("data-face") / 10)
        faceElement.attr("data-face", faces[x])
        faceElement.text(faces[x])
        faceElement.removeClass(colorCSSSelector[oldColorSelector]).addClass(colorCSSSelector[colorSelector])
        // console.log(faceElement)
    }
}