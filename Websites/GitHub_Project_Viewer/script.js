var responseObj;
var cont = document.getElementById("contents");
var url = 'https://api.github.com/repos/JHstrutton2000/Projects/contents/';
var urls = ['https://api.github.com/repos/JHstrutton2000/Projects/contents'];


function printRepoCount() {
    responseObj = JSON.parse(this.responseText);
    console.log(responseObj);
}

function load(name) {
    urls[urls.length] = name
    //url += name+"/";

    var text = "";

    for (var i = 0; i < urls.length; i++) {
        text += urls[i]+'/';
    }

    //console.log(text, urls);
    


    var request = new XMLHttpRequest();
    request.onload = rebuild;
    request.open('get', text, true)
    request.send()
}

function back() {
    url.pop();
    load();
}

function rebuild() {
    responseObj = JSON.parse(this.responseText);

    
    if (urls.length < 0)
        cont.innerHTML = "<div class='button' onclick=back()>Back</div>";
    else
        cont.innerHTML = "";
    for (var i = 0; i < responseObj.length; i++) {
        cont.innerHTML += "<div onclick='load(this.innerHTML)'>" + responseObj[i].name + "</div>";
    }
}

load("");