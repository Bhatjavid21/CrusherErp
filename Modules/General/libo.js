
function To_Display(Style_Display, NameObjsInArrayByComma) {
    var spltObjs;
    if (NameObjsInArrayByComma.indexOf(",") == -1) {
        document.getElementById(NameObjsInArrayByComma).style.display = Style_Display;
    }
    else {
        spltObjs = NameObjsInArrayByComma.split(",");
        for (var i = 0; i < spltObjs.length; i++) {
            document.getElementById(spltObjs[i]).style.display = Style_Display;
        }
    }
}

function toShow(NameObjsInArrayByCommaOrOne) {
    var spltObjs;
    if (NameObjsInArrayByCommaOrOne.indexOf(",") == -1) {
        document.getElementById(NameObjsInArrayByCommaOrOne).style.display = 'block';
    }
    else {
        spltObjs = NameObjsInArrayByCommaOrOne.split(",");
        for (var i = 0; i < spltObjs.length; i++) {
            document.getElementById(spltObjs[i]).style.display = 'block';
        }
    }
}

function toHide(NameObjsInArrayByCommaOrOne) {
    var spltObjs;
    if (NameObjsInArrayByCommaOrOne.indexOf(",") == -1) {
        document.getElementById(NameObjsInArrayByCommaOrOne).style.display = 'none';
    }
    else {
        spltObjs = NameObjsInArrayByCommaOrOne.split(",");
        for (var i = 0; i < spltObjs.length; i++) {
            document.getElementById(spltObjs[i]).style.display = 'none';
        }
    }
}



function setBorderColor_Initial(color, NameObjsInArrayByComma) {
    var spltObjs;
    if (NameObjsInArrayByComma.indexOf(",") == -1) {
        document.getElementById(NameObjsInArrayByComma).style = "border-color:" + color;

    }
    else {
        spltObjs = NameObjsInArrayByComma.split(",");
        for (var i = 0; i < spltObjs.length; i++) {
            document.getElementById(spltObjs[i]).style = "border-color:" + color;
        }
    }
}


function setBorderColor_Default(NameObjsInArrayByComma) {
    var spltObjs;
    if (NameObjsInArrayByComma.indexOf(",") == -1) {
        document.getElementById(NameObjsInArrayByComma).style = "border-color:#d2d6de";

    }
    else {
        spltObjs = NameObjsInArrayByComma.split(",");
        for (var i = 0; i < spltObjs.length; i++) {
            document.getElementById(spltObjs[i]).style = "border-color:#d2d6de";
        }
    }
}

function ValidateSpace0(obj) {
    var v = getObj(obj).value;
    if (v == "" || v == "0" || v.length == "0") {
        return "0";
    }
    else {
        return v;
    }
}




function Exists(val, point) {
    if (val.indexOf(point) > -1) {
        return true;
    }
    else {
        return false;
    }
}

function Not_Exists(obj, val) {
    if (obj.indexOf(val) > -1) {
        return false;
    }
    else {
        return true;
    }
}

function ValidateOne(obj) {
    if (obj.value == "" || obj.value == 0) {
        obj.style = "border-color:#ff9494";

        if ($("#select2-" + obj.id + "-container")) {
            $("#" + obj.id).siblings(".select2-container--default").css({ 'border': '1px solid #ff9494', 'border-radius': '5px' });
        }
        obj.focus();
        return false;
    }
    else {
        obj.style = "border-color:#36bea6";

        if ($("#select2-" + obj.id + "-container")) {
            $("#" + obj.id).siblings(".select2-container--default").css({ 'border': '1px solid #36bea6', 'border-radius': '5px' });
        }

        if (obj.id.indexOf("email") != -1) {
            if (Validate_Email(obj.id) == false) {
                obj.focus();
                return false;
            }
        }
    }


}


function setBorderColor_Validation(NameObjsInArrayByComma) {

    var spltObjs, flg = false; isAnyFalse = 1;

    if (NameObjsInArrayByComma.indexOf(",") != -1) {

        spltObjs = NameObjsInArrayByComma.split(",");
       
        for (var i = 0; i < spltObjs.length; i++) {

            var obj = getObj(spltObjs[i]);
            if (obj) {
                if (obj.value == "" || obj.value == 0) {
                    obj.style = "border-color:#ff9494"; flg = false; isAnyFalse = 0;


                    if ($("#select2-" + obj.id + "-container")) {

                        $("#" + obj.id).siblings(".select2-container--default").css({ 'border': '1px solid #ff9494', 'border-radius': '5px' });
                    }

                }
                else {
                    obj.style = "border-color:#36bea6";

                    if ($("#select2-" + obj.id + "-container")) {
                        $("#" + obj.id).siblings(".select2-container--default").css({ 'border': '1px solid #36bea6', 'border-radius': '5px' });
                    }

                    if (isAnyFalse == 0) {
                        flg = false; isAnyFalse = 0;
                    }
                    else {
                        flg = true; isAnyFalse = 1;
                    }


                }
            }


            //if ($("#select2-" + obj + "-container")) {
            //    if (getVal(obj) == 0 || getVal(obj) == "") {
            //        $("#" + obj).siblings(".select2-container--default").css({ 'border': '1px solid red', 'border-radius': '5px' });
            //        flg = false; isAnyFalse = 0;
            //    }
            //    else {
            //        $("#ddl_item_Sub_Category").siblings(".select2-container--default").css({ 'border': '1px solid green', 'border-radius': '5px' });
            //    }
            //}

        }
        return flg;
    }
}


function Error_Msg(txt, obj) { alert(txt); getObj(obj).focus(); }

function getVal(obj) {
    obj = document.getElementById(obj).value.trim(); return obj;
}

function getInnerText(obj) { return (document.getElementById(obj).innerHTML); }

function getObj(obj) { return (document.getElementById(obj)); }

function SetVal(obj, val) { document.getElementById(obj).value = val; }

function setBordrColor(obj, color) { getObj(obj).style = "border-color:" + color; }

function CheckBoxTick(obj, bool) {
    document.getElementById(obj).checked == bool;
}


function RadioBtnSelect(obj, bool) {
    document.getElementById(obj).checked = bool;
}

function SplitAndSet(val, spltBy, objType, NameObjsInArrayByComma) {
    var pieces = val.split(spltBy);
    var spltObjs = NameObjsInArrayByComma.split(",");

    for (var i = 0; i < pieces.length; i++) {
        if (objType == "Inner") {
            SetInnerVal(spltObjs[i], pieces[i]);
        }
        else {
            SetVal(spltObjs[i], pieces[i]);
        }
    }
}

function SetInnerVal(obj, val) {
    document.getElementById(obj).innerHTML = "";
    document.getElementById(obj).innerHTML = val;
}

function Confirm(sender, msg) {
    return confirm(msg);
}


function Only_String(txtObj) { var strcharat; var strarg = txtObj.value; var ecpt = ""; var inti; for (inti = 0; inti < strarg.length; inti++) { strcharat = strarg.charAt(inti); if (!((strcharat >= "A" && strcharat <= "Z") || (strcharat >= "a" && strcharat <= "z") || (strcharat == " "))) { txtObj.style = "border-color:#ff9494;"; } else { ecpt += strcharat; txtObj.style = "border-color:#36bea6;"; } } txtObj.value = ecpt; }

function Only_OneWord(txtObj) { var strcharat; var strarg = txtObj.value; var ecpt = ""; var inti; for (inti = 0; inti < strarg.length; inti++) { strcharat = strarg.charAt(inti); if (!((strcharat >= "A" && strcharat <= "Z") || (strcharat >= "a" && strcharat <= "z"))) { txtObj.style = "border-color:#ff9494;"; } else { ecpt += strcharat; txtObj.style = "border-color:#36bea6;"; } } txtObj.value = ecpt; }


function Make_ReadOnly(NameObjsInArrayByComma) {
    var spltObjs;
    if (NameObjsInArrayByComma.indexOf(",") == -1) {
        $("#" + NameObjsInArrayByComma + "").attr("disabled", "disabled");
    }
    else {
        spltObjs = NameObjsInArrayByComma.split(",");
        for (var i = 0; i < spltObjs.length; i++) {
            //alert(spltObjs[i]);
            $("#" + spltObjs[i] + "").attr("disabled", "disabled");
        }
    }
}


function Make_ReadWrite(NameObjsInArrayByComma) {
    var spltObjs;
    if (NameObjsInArrayByComma.indexOf(",") == -1) {
        $("#" + NameObjsInArrayByComma + "").removeAttr("disabled");
    }
    else {
        spltObjs = NameObjsInArrayByComma.split(",");
        for (var i = 0; i < spltObjs.length; i++) {
            $("#" + spltObjs[i] + "").removeAttr("disabled");
        }
    }
}


function SetLoading() {
    return '<tr><td colspan="6" style="height: 50px;"><center><img style="height: 20px;width: 400px;" src="../../assets/images/Loading.gif" alt="Loading..." /></center></td></tr>'
}


function API_Call(lnk, FunName) {
    if (lnk != false & lnk != '0') {
        var xhReq = new XMLHttpRequest(); xhReq.open('GET', lnk, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
            if (xhReq.readyState == 4) {
                Result = xhReq.responseText;
                if (Chk_Res(Result) == false) {
                    General_call(FunName, Result);
                }
            }
        }
    }
}



function Validate_Email(obj) {
    if (getVal(obj).trim().length > 0) {
        var str = getVal(obj);
        var re = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/;
        if (!str.match(re)) {
            getObj(obj).style = "border-color:#ff9494;";
            calltoast('Invalid Email Address', 'error'); return false;
            getObj(obj).focus()
        }
        else {
            getObj(obj).style = "border-color:#36bea6;"; return true;
        }
    }
    else { return true; }
}


function AlertSuccessMsg(msg) {
    calltoast(msg, 'success');
}
function AlertMsgError(msg) {
    calltoast(msg, 'error');
}

function SucMsgS() {
    calltoast("The Data has been Saved Successfully.", 'success');
}
function SucMsgU() {
    calltoast("The Data has been Updated Successfully.", 'success');
}
function FailMsg() {
    calltoast("An error occured.", 'error');
}

function Mendatry_Msg() {
    calltoast('Please Provide the Mandatory Information', 'error');
}


function ToDecimal(obj, Left_Part_leng) {
    input = obj.value;

    if (obj.value.trim() == "") {
        obj.style = "border-color:#ff9494;";
        calltoast('Field can not be empty.', 'error');
        obj.focus();
        return false;
    }
    else {
        if (input.indexOf('.') < 2) {
            input = input + ".00";
        }


        var LeftPart = input.split('.')[0];
        var DecimalPart = input.split('.')[1];

        if (!/^[0-9]+$/.test(LeftPart)) {
            obj.style = "border-color:#ff9494;";
            calltoast('Please enter numeric only.', 'error');
            obj.focus();
            return false;
        }
        else if (LeftPart.length > Left_Part_leng) {

            obj.style = "border-color:#d2d6de;";

            LeftPart = LeftPart.substring(0, Left_Part_leng);

            if (DecimalPart.length > 2) {
                DecimalPart = DecimalPart.substr(0, 2);
            }
            else if (DecimalPart.length == 0) {
                DecimalPart += "00";
            }
            else if (DecimalPart.length == 1) {
                DecimalPart += "0";
            }

            obj.value = LeftPart + "." + DecimalPart;
        }
        else { obj.style = "border-color:#d2d6de;"; }

    }
}


function isNumeric(keyCode, obj) {
    var str = getVal(obj.id);

    return (((keyCode >= 48 && keyCode <= 57) || keyCode == 9 || keyCode == 110 || keyCode == 190 || keyCode == 8 || keyCode == 46 || (keyCode >= 96 && keyCode <= 105))); //|| isAuxKey(keyCode));   
}

function p(obj) {
    //allows only space, +, (, ) and 0 too 9
    var val = getVal(obj.id).replace("~", "").replace("`", "").replace("!", "").replace("@", "").replace("#", "").replace("$", "").replace("%", "").replace("^", "").replace("&", "").replace("*", "").replace("_", "").replace("=", "").replace("[", "").replace("]", "").replace("{", "").replace("}", "").replace("\\", "").replace("|", "").replace(";", "").replace(":", "").replace("'", "").replace("\"", "").replace("<", "").replace(">", "").replace("?", "").replace("/", "").replace("?", "");


    if (val.length > 24) {
        obj.maxLength = 25;
    }
    else {
        SetVal(obj.id, val);
    }
}

function pnv(keyCode, obj) {
    return (
        (keyCode == 32 || keyCode == 18 || keyCode == 173 || keyCode == 16 || keyCode == 61 || keyCode == 37 ||
            (keyCode >= 48 && keyCode <= 57) || keyCode == 9 || keyCode == 190 || keyCode == 8 || keyCode == 46 || (keyCode >= 96 && keyCode <= 105)
        ))
}



function To_Activate(Actv) {

    //toActivate
    if (Actv.indexOf(",") > -1) {
        var Act = Actv.split(',')
        for (var i = 0; i < Act.length; i++) {
            $("#" + Act[i]).addClass("active show");
        }
    }
}


//toDe-Activate
function To_Deactivate(DeAct) {
    if (DeAct.indexOf(",") > -1) {
        var Det = DeAct.split(',')
        for (var i = 0; i < Det.length; i++) {
            $("#" + Det[i]).removeClass("active show");
        }
    }
}


function TabDisable() {
    $(".nav-tabs li a").addClass("disabled")
    calltoast("Tab is blocked, Fill General Detaill first.", "info");
}




function checkDate(fld) {
    var mo, day, yr;
    var entry = fld.value;
    var reLong = /\b\d{1,2}[\/-]\d{1,2}[\/-]\d{4}\b/;
    var reShort = /\b\d{1,2}[\/-]\d{1,2}[\/-]\d{2}\b/;
    var valid = (reLong.test(entry)) || (reShort.test(entry));
    if (valid) {
        var delimChar = (entry.indexOf("/") != -1) ? "/" : "-";
        var delim1 = entry.indexOf(delimChar);
        var delim2 = entry.lastIndexOf(delimChar);
        mo = parseInt(entry.substring(0, delim1), 10);
        day = parseInt(entry.substring(delim1 + 1, delim2), 10);
        yr = parseInt(entry.substring(delim2 + 1), 10);
        // handle two-digit year
        if (yr < 100) {
            var today = new Date();
            // get current century floor (e.g., 2000)
            var currCent = parseInt(today.getFullYear() / 100) * 100;
            // two digits up to this year + 15 expands to current century
            var threshold = (today.getFullYear() + 15) - currCent;
            if (yr > threshold) {
                yr += currCent - 100;
            } else {
                yr += currCent;
            }
        }
        var testDate = new Date(yr, mo - 1, day);
        if (testDate.getDate() == day) {
            if (testDate.getMonth() + 1 == mo) {
                if (testDate.getFullYear() == yr) {
                    // fill field with database-friendly format
                    fld.value = mo + "/" + day + "/" + yr;
                    return true;
                } else {
                    alert("There is a problem with the year entry.");
                    return false;
                }
            } else {
                alert("There is a problem with the month entry.");
                return false;
            }
        } else {
            alert("There is a problem with the day entry.");
            return false;
        }
    } else {
        alert("Incorrect date format. Enter as dd/mm/yyyy.");
        return false;
    }
    return false;
}


function CleanFields(elementsByComma) {
    var el = "", spl = elementsByComma.split(",");

    for (var i = 0; i < spl.length; i++) {
        el = spl[i]; el = el.replace(" ", "")
        if (el.indexOf("ddl_") > -1) {
            SetVal(el, 0);
        }
        else if (el.indexOf("txt_") > -1 || el.indexOf("file_")) {
            SetVal(el, "");
        }
        else if (el.indexOf("rb_") > -1 || el.indexOf("chk_") > -1) {
            SetVal(el, el.checked = false);
        }
    }

    setBorderColor_Default(elementsByComma);
}


//=============================================Session End Error Handling================================================================

function Chk_Res(res) {

    if (res != undefined) {
        if (res.length > 0) {
            if (res.indexOf("SessionIsDead") > -1) {
                alert("Session Ended: Please Login Again.");

                var Root = 'http://' + location.href.split("/")[2].toString();

                location.href = Root + '/EMMET/Default.aspx';

                return true;
            }
            else if (res.indexOf("!error!") > -1) {
                res = res.replace("!error!", "");
                alert("There is an error: " + res);
                return true;
            }
            else {
                return false;
            }
        }
    }
    else {
        return false;
    }
}



//=======================================================================================API=============================================

function apiCon(lnk, f)// when function is called the IP(Input) is always 0
{
    var xhReq = new XMLHttpRequest(); xhReq.open('GET', lnk, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
        if (xhReq.readyState == 4) {
            var r = xhReq.responseText;
            if (Chk_Res(r) == false) {
                if (r == "") { alert("No revert from the handler."); }
                else if (Exists(r, 'Error:')) { alert("Operation failed for " + f); }
                else if (f == 'test') { test(0, r); } //the OP(output) will always be there either done, or some id 
                else if (f == 'save') { test(0, r); }
            }
        }
    }
}





//===========================================not in use
function ClearAll(DDL, txt, rb, chk) {

    if (DDL > 0) {
        for (var i = 1; i <= DDL; i++) {
            getObj("DDL" + i).value = 0;     //DDL
        }
    }

    if (txt > 0) {
        for (var i = 1; i <= txt; i++) {
            getObj("txt" + i).value = "";     //txtbox
        }
    }

    if (rb > 0) {
        for (var i = 1; i <= rb; i++) {
            getObj("RB" + i).checked = false;     //CheckBox
        }
    }

    if (chk > 0) {
        for (var i = 1; i <= chk; i++) {
            getObj("chk" + i).checked = false;     //CheckBox
        }
    }
}

function View_Edit_File(spanTag, path, file_name) {
    if (getObj(spanTag)) {
        //toHide(Input_File_Id);
        toShow(spanTag);
    }

    var httpPath = window.location.href;
    if (httpPath.indexOf("TradersERP/Modules") == -1) {
        SetInnerVal(spanTag, "<a href='/Modules/" + path + "/" + file_name + "' target='_blank'><i class='fa fa-download'></i></a>");
    }
    else {
        SetInnerVal(spanTag, "<a href='/TradersERP/Modules/" + path + "/" + file_name + "' target='_blank'><i class='fa fa-download'></i></a>");
    }

}



//========================================================file Upload====================================================
//========================================================file Upload====================================================

function upload_File(path, formNo, Input_File_Id, Loading_Id) {

    if (Loading_Id == undefined) { Loading_Id = "spn_loading"; }
    SetVal("hid_fileName", "");

    if (getObj(Loading_Id)) {
        toHide(Input_File_Id);
        toShow(Loading_Id);
    }

    var fsize = document.getElementById(Input_File_Id).files[0].size

    if (fsize > 3655835) //3.5 MB
    {
        alert("File size can not be greater than 3.5 MB");
        toShow(Input_File_Id); toHide(Loading_Id);
    }
    else {

        $.ajax({
            url: '../General/File_Upload.ashx?path=' + path,
            type: 'POST',
            data: new FormData($('form')[formNo]),
            cache: false,
            contentType: false,
            processData: false,
            success: function (file) {

                SetVal("hid_fileName", file.name);
                toShow(Input_File_Id);



                var httpPath = window.location.href;
                if (httpPath.indexOf("TradersERP/Modules") == -1) {
                    SetInnerVal(Loading_Id, "<a href='/Modules/" + path + "/" + file.name + "' target='_blank'><i class='fa fa-download'></i></a>");
                }
                else {
                    SetInnerVal(Loading_Id, "<a href='/TradersERP/Modules/" + path + "/" + file.name + "' target='_blank'><i class='fa fa-download'></i></a>");
                }

                return file.name;
            }
        });
    }
}

//===============================================





function General_ValExtract(opr, DDL, tx, rb, chk) {
    var para = "";
    if (opr == 'Insert_Customer') {
        for (var i = 1; i <= DDL; i++) {
            para += "&DDL" + i + " = document.getElementById(DDL" + i + ")".value;     //DDL
        }


        for (var i = 1; i <= tx; i++) {
            para += "&tx" + i + "=" + document.getElementById("tx" + i).value;      //TextBox
        }


        for (var i = 1; i <= rb; i++) {
            para += "&rb" + i + " = document.getElementById(rb" + i + ")".value;     //Radio Button
        }


        for (var i = 1; i <= chk; i++) {
            para += "&chk" + i + " = document.getElementById(chk" + i + ")".value;   //CheckBoxes
        }
    }
    else if (opr == 'Insert_Additional_Customer') {
        for (var i = 1; i <= DDL; i++) {
            para += "&DDL" + i + " = document.getElementById(DDL" + i + ")".value;     //DDL
        }


        for (var i = 1; i <= tx; i++) {
            para += "&tx" + i + "=" + document.getElementById("tx" + i).value;      //TextBox
        }


        for (var i = 1; i <= rb; i++) {
            para += "&rb" + i + " = document.getElementById(rb" + i + ")".value;     //Radio Button
        }


        for (var i = 1; i <= chk; i++) {
            para += "&chk" + i + " = document.getElementById(chk" + i + ")".value;   //CheckBoxes
        }
    }

    return para;
}




function phoneno(e) {
    var charCode;
    if (e.keyCode > 0) {
        charCode = e.which || e.keyCode;
    }
    else if (typeof (e.charCode) != "undefined") {
        charCode = e.which || e.keyCode;
    }
    if (charCode == 43 || charCode == 45 || charCode == 32 || charCode == 40 || charCode == 41 || charCode == 35)
        return true
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

//=====================================Auto height of  textarea where keyup calls 2nd function
// need not to call
//$(function () {
//    $("textarea").each(function () {
//        this.style.height = (0 + this.scrollHeight) + 'px';
//        this.style.overflow = "hidden";
//    });
//});

// remove enq-txtbx-pd   class if any textarea has it.

// need to call like $(item).find(".item_desc").attr("onkeyup", "Get_Item_Suggestions(" + count + ");inputDynamicHeight(this);

function inputDynamicHeight(obj) {

    obj.style.height = "1px";
    obj.style.height = (1 + obj.scrollHeight) + "px";
    obj.style.overflow = "hidden";
}
//====================================================================

function Only_String1(txtObj) { var strcharat; var strarg = txtObj.value; var ecpt = ""; var inti; for (inti = 0; inti < strarg.length; inti++) { strcharat = strarg.charAt(inti); if (!((strcharat >= "A" && strcharat <= "Z") || (strcharat >= "a" && strcharat <= "z") || (strcharat == ",") || (strcharat == "(") || (strcharat == ")") || (strcharat == "-") || (strcharat == " "))) { txtObj.style = "border-color:#ff9494;"; } else { ecpt += strcharat; txtObj.style = "border-color:#36bea6;"; } } txtObj.value = ecpt; }




var browser = (function (agent) {
    switch (true) {
        case agent.indexOf("edge") > -1: return "MS Edge (EdgeHtml)";
        case agent.indexOf("edg") > -1: return "MS Edge Chromium";
        case agent.indexOf("opr") > -1 && !!window.opr: return "opera";
        case agent.indexOf("chrome") > -1 && !!window.chrome: return "chrome";
        case agent.indexOf("trident") > -1: return "Internet Explorer";
        case agent.indexOf("firefox") > -1: return "firefox";
        case agent.indexOf("safari") > -1: return "safari";
        default: return "other";
    }
})(window.navigator.userAgent.toLowerCase());

if (browser != 'chrome' & browser != 'MS Edge Chromium') {
    alert('Use Chrome Browser To Avail All Functionalities Smoothly');
    var Root = 'http://' + location.href.split("/")[2].toString();
    location.href = Root + '/EMMET/Default.aspx';
  //  return true;
}




function phoneno(e) {
    var charCode;
    if (e.keyCode > 0) {
        charCode = e.which || e.keyCode;
    }
    else if (typeof (e.charCode) != "undefined") {
        charCode = e.which || e.keyCode;
    }
    if (charCode == 43 || charCode == 45 || charCode == 32 || charCode == 40 || charCode == 41 || charCode == 35)
        return true
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}



