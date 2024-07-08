"use strict";

var wssurl = "wss://" + location.host + '/websocket/';
var wsurl = "ws://" + location.host + '/websocket/';
if (location.protocol == 'file:') {
    var wsurl = "ws://localhost:8080/websocket/";
}

const dpi = window.devicePixelRatio || 1;
const canvasWidth = 800;
const canvasHeight = 540;

var canvas = document.createElement('canvas');
canvas.setAttribute('width', canvasWidth * dpi);
canvas.setAttribute('height', canvasHeight * dpi);
canvas.style.width = canvasWidth + "px";
canvas.style.height = canvasHeight + "px";

var ctx = canvas.getContext("2d");
ctx.scale(dpi, dpi);

canvas.setAttribute('tabindex', 1);
canvas.setAttribute('id', 'game-canvas');
canvas.addEventListener('keydown', function(event) {
    if (event.key == 'F5') {
        location.reload();
    }
    if (event.key == 'r' || event.key == 'R') {
        location.reload();
    }
    ws.send(event.key);
    event.preventDefault();
});

var blocksize = 10;
var headcolor = 'red';
var bodycolor = 'lightred';
var bgcolor = 'white';
var offset = 20;

if (location.protocol == 'http:' || location.protocol == 'file:') {
    var ws = new WebSocket(wsurl);
} else {
    var ws = new WebSocket(wssurl);
};

ws.onmessage = function (event) {
    var data = JSON.parse(event.data);
    drawsquare(data.treats[0], 'blue');
    drawscore(data.scores);
    for (var i=0; i < data.clear.length; i++) {
        drawsquare(data.clear[i], bgcolor);
    }
    for (var i=0; i < data.worms.length; i++) {
        var worm = data.worms[i];
        drawsquare(worm.newhead, headcolor);
        drawsquare(worm.oldhead, bodycolor);
        drawsquare(worm.tail, bgcolor);
    }
};

var drawborders = function() {
    ctx.fillStyle = 'grey';
    ctx.fillRect(offset - blocksize, offset -blocksize, blocksize * 52, blocksize);
    ctx.fillRect(offset - blocksize, offset -blocksize, blocksize, blocksize*52);
    ctx.fillRect(offset + blocksize*50, offset -blocksize, blocksize, blocksize * 52);
    ctx.fillRect(offset - blocksize, offset + blocksize * 50, blocksize * 52, blocksize);
};
drawborders();

var drawsquare = function(coords, color) {
    var x = coords[0];
    var y = coords[1];
    ctx.fillStyle = color;
    ctx.fillRect(offset + x*blocksize, offset + y*blocksize,blocksize,blocksize);
};

var drawscore = function(scores) {
    ctx.fillStyle = bgcolor;
    ctx.fillRect(blocksize*54, blocksize*2, 500, 500);
    ctx.fillStyle = 'black';
    ctx.font = "20px Arial";
    for (var i=0; i < scores.length; i++) {
        ctx.fillText(scores[i], blocksize*54, blocksize*4+20*i);
    }
};

const resizeCanvas = () => {
    const displayWidth = Math.min(canvasWidth, document.documentElement.clientWidth * 0.95);
    canvas.style.width =  displayWidth + "px";
    canvas.style.height = displayWidth * (canvasHeight/canvasWidth) + 'px'
};

window.onresize = resizeCanvas;
resizeCanvas();

document.body.appendChild(canvas);
canvas.focus();
