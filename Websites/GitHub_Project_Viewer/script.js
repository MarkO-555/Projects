var responseObj;
var cont = document.getElementById("contents");

var urls = ['https://api.github.com/repos/JHstrutton2000/Projects/contents'];
var prevUrls;

var obj = function (url, json) {
    this.url = url;
    this.json = json;
};

var memory = [];

function load(name) {
    prevUrls = urls;
    urls[urls.length] = name

    var text = "";

    for (var i = 0; i < urls.length; i++) {
        text += urls[i]+'/';
    }


    var request = new XMLHttpRequest();
    request.onload = rebuild;
    request.open('get', text, true)
    request.send()
}

function back() {
    urls.pop();
    var str = urls[urls.length - 1]
    urls.pop();

    load(str);
}

function rebuild() {
    var pass = true;
    var index = -1;

    for (var i = 0; i < memory.length; i++) {
        if (memory[i].url == urls) {
            index = i;
            pass = false;
            break;
        }
    }

    if (pass) {
        responseObj = JSON.parse(this.responseText);
        memory.push(new obj(urls, responseObj));
    }
    else {
        responseObj = memory[index].obj;
    }


    if (urls.length > 2)
        cont.innerHTML = "<div class='button' onclick=back()>Back</div>";
    else
        cont.innerHTML = "";

    for (var i = 0; i < responseObj.length; i++) {
        cont.innerHTML += "<div onclick='load(this.innerHTML)'>" + responseObj[i].name + "</div>";
    }
}

load("");