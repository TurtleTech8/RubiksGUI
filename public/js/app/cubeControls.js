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

function remapCube(data) {
    fillSide('top', data.top)
    fillSide('back', data.back)
    fillSide('bottom', data.bottom)
    fillSide('front', data.front)
    fillSide('left', data.left)
    fillSide('right', data.right)
}

function turnCube() {
    $.ajax({
        url : 'cube/turnCube',
        type : 'POST',
        data : {direction: this.innerHTML},
        success : function(data) {
            remapCube(data.response)
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
            remapCube(data.response)
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
            remapCube(data.response)
        },
        error : function(request,error)
        {
            console.log(error)
            alert("Request: "+JSON.stringify(request));
        }
    });
}

function fillSide(side, faces) {

    for(x=0; x < faces.length; x++) {
        idSelector = x + 1
        colorSelector = Math.floor(faces[x] / 10)
        faceElement = $(`[id=${side}${idSelector}][data-face]`)
        oldColorSelector = Math.floor(faceElement.attr("data-face") / 10)
        faceElement.attr("data-face", faces[x])
        // faceElement.text(faces[x])
        faceElement.removeClass(colorCSSSelector[oldColorSelector]).addClass(colorCSSSelector[colorSelector])
    }
}