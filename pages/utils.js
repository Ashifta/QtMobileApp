.pragma library

var debug = false

function log(text) {
    if (debug)
        console.log(text)
}


function getCaptcha(captcha) {
    var url ="http://douban.fm/j/new_captcha"; // get captchaId
    var source ="http://douban.fm/misc/captcha" + "?size=m&id=";    // get captcha

    var doc = new XMLHttpRequest;
    doc.open("GET", url);
    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE && doc.status === 200) {
            var captchaId = doc.responseText;
            //log(doc.responseText);
            captchaId = captchaId.substring(1, captchaId.indexOf("\"", 1));
            //log("captcha ID:[" + captchaId + "]");
            captcha.captchaId = captchaId;
            captcha.source = source + captchaId;
            log(captcha.source);
        }

    }
    doc.send();
}

function login(username, password, captcha, captchaId, model) {
    var url ="http://douban.fm/j/login";
    var doc = new XMLHttpRequest;
    doc.open("POST", url);
    doc.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE) {
            //Utils.log(doc.status);
            //Utils.log(doc.responseText);
            if (doc.status === 200) {
                model.json = "";  // reset the json
                model.json = doc.responseText;
            }
        }
    }
    doc.send("source=radio" +
             "&alias=" + username +
             "&form_password=" + password +
             "&captcha_solution=" + captcha +
             "&captcha_id=" + captchaId +
             "&task=sync_channel_list"
             );
}

function logout(ck) {
    var url = "http://douban.fm/partner/logout?source=radio&no_login=y&ck=" + ck;
    var doc = new XMLHttpRequest;
    log(url);
    doc.open("GET", url);
    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE && doc.status === 200) {
            //log(doc.responseText);
        }
    }
    doc.send();
}
