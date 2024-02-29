colorCSSSelector = {
    1: "whiteBox",
    2: "blueBox",
    3: "yellowBox",
    4: "greenBox",
    5: "orangeBox",
    6: "redBox"
}

$(document).ready(function () {
    // Make sure the cube is ready for use
    resetCube()

    // Add click events for each directional button
    $("#directions").children().click(turnCube)

    // Add hover events for each direction button
    $("#directions").children().each(function(i) {
        $(this).hover(showDirectionIndicator, hideDirectionIndicator)
    })

    // Add Reset and Scramble click events
    $("#resetCube").click(resetCube)
    $("#scrambleCube").click(mixCube)
})

function showDirectionIndicator() {
    x = $(`#${this.getAttribute('data-face')}`).children(".directionIndicator")
    x.removeClass("hide")
    if(this.id.includes("Prime")) {
        x.addClass("mirror")
    }
}

function hideDirectionIndicator() {
    x = $(`#${this.getAttribute('data-face')}`).children(".directionIndicator")
    x.addClass("hide")
    x.removeClass("mirror")
}


function turnCube() {
    $.ajax({
        url : 'cube/turnCube',
        type : 'POST',
        data : {direction: this.innerHTML},
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
        // faceElement.text(faces[x])
        faceElement.removeClass(colorCSSSelector[oldColorSelector]).addClass(colorCSSSelector[colorSelector])
        // console.log(faceElement)
    }
}