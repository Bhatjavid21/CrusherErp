!function ($) {
    "use strict";

    var SUSDashboard = function () {
        this.$body = $("body")
        this.$calendar = $('#calendar'),
        this.$event = ('#external-events div.external-event'),
        this.$categoryForm = $('#add-new-events form'),
        this.$extEvents = $('#external-events'),
        this.$modal = $('#taskPopup'),
        this.$saveCategoryBtn = $('.save-category'),
        this.$calendarObj = null
    };

    /* on click on event */
    SUSDashboard.prototype.onEventClick = function (calEvent, jsEvent, view) {
        $("#hid_Task_Main_Id").val(calEvent.id);

        Bind_Task_Main_Details(calEvent.id);

        $("#lbl_Modal_Title").text("Edit Task");

        $('#taskPopup').modal("show");

        //var $this = this;
        //var form = $("<form></form>");
        //form.append("<label>Change event name</label>");
        //form.append("<div class='input-group'><input class='form-control' type=text value='" + calEvent.title + "' /><span class='input-group-btn'><button type='submit' class='btn btn-success waves-effect waves-light'><i class='fa fa-check'></i> Save</button></span></div>");
        //$this.$modal.modal({
        //    backdrop: 'static'
        //});
        //$this.$modal.find('.delete-event').show().end().find('.save-event').hide().end().find('.modal-body').empty().prepend(form).end().find('.delete-event').unbind('click').click(function () {

        //    $this.$calendarObj.fullCalendar('removeEvents', function (ev) {
        //        if (ev._id == calEvent._id) {
        //            $this.growltoast("Item Deleted Successfully...", "top", "right", "fa fa-bell-o", "success", "animated fadeIn", "animated fadeOut", "success");
        //            return true;
        //        }
        //    });
        //    $this.$modal.modal('hide');
        //});
        //$this.$modal.find('form').on('submit', function () {
        //    calEvent.title = form.find("input[type=text]").val();
        //    $this.growltoast("Item Updated Successfully...", "top", "right", "fa fa-bell-o", "success", "animated fadeIn", "animated fadeOut", "success");
        //    $this.$calendarObj.fullCalendar('updateEvent', calEvent);
        //    $this.$modal.modal('hide');

        //    return false;
        //});
    },

    //SUSDashboard.prototype.enableDrag = function () {
    //    $(this.$event).each(function () {
    //        var eventObject = {
    //            title: $.trim($(this).text())
    //        };

    //        $(this).data('eventObject', eventObject);
    //        $(this).draggable({
    //            zIndex: 999999,
    //            revert: true,
    //            revertDuration: 0
    //        });
    //    });
    //}

    /* on select */
    SUSDashboard.prototype.onSelect = function (start, end, allDay) {

        Reset_Task_Popup_Controls();
        Enable_Disable_Task_Controls("0");
        $("#divComments").addClass("hide");

        $("#hid_Task_Main_Id").val("0");

        var selectedDate = new Date(start);
        selectedDate = ("0" + selectedDate.getFullYear()).slice(-4) + "-" + ("0" + (selectedDate.getMonth() + 1)).slice(-2) + "-" + ("0" + selectedDate.getDate()).slice(-2);

        $("#txt_Task_Date").val(selectedDate);
        $("#txt_End_Date").val(selectedDate);

        var selectedTime = new Date(start);
        var hours = selectedTime.getUTCHours();
        var minutes = selectedTime.getUTCMinutes();

        selectedTime = selectedTime.getUTCHours() + ":" + selectedTime.getUTCMinutes();

        if (selectedTime == "0:0") {
            $("#txt_Task_Time").val("09:00");
            $("#txt_End_Time").val("09:30");
        }
        else {
            var actualMinutes = (hours * 60) + (minutes);
            var actualTime = pass_Minutes_Get_Time(actualMinutes);
            $("#txt_Task_Time").val(actualTime);

            actualMinutes += 30;
            actualTime = pass_Minutes_Get_Time(actualMinutes);
            $("#txt_End_Time").val(actualTime);
        }

        $("#lbl_Modal_Title").text("Add Task");

        $('#taskPopup').modal("show");

        //var $this = this;
        //$this.$modal.modal({
        //    backdrop: 'static'
        //});
        //var form = $("<form></form>");
        //form.append("<div class='row'></div>");
        //form.find(".row")
        //    .append("<div class='col-md-6'><div class='form-group'><label class='control-label'>Task Name</label><input class='form-control' placeholder='Insert Event Name' type='text' name='title'/></div></div>")
        //    .append("<div class='col-md-6'><div class='form-group'><label class='control-label'>Task Description</label><input class='form-control' placeholder='Insert Event Description' type='text' name='title'/></div></div>")

        //    .append("<div class='col-md-6'><div class='form-group'><label class='control-label'>Priority</label><select class='form-control enq-dropdown' name='priority'></select></div></div>")

        //      .append("<div class='col-md-6'><div class='form-group'><label class='control-label'>Task Date</label><input class='form-control' placeholder='Insert Task Date' type='date' name='title'/></div></div>")
        //      .append("<div class='col-md-6'><div class='form-group'><label class='control-label'>Task Time</label><input class='form-control' placeholder='Insert Task Time' type='time' name='title'/></div></div>")
        //     .append("<div class='col-md-6'><div class='form-group'><label class='control-label'>Assigned To</label><select class='form-control enq-dropdown' name='assignedto'></select></div></div>")
        //    .find("select[name='priority']")
        //    .append("<option value='low'>Low</option>")
        //    .append("<option value='medium'>Medium</option>")

        // .append("<option value='high'>High</option></div></div>")
        // .find("select[name='assignedto']")

        // .append("<option value='0'>Select</option></div></div>");
        //$this.$modal.find('.delete-event').hide().end().find('.save-event').show().end().find('.modal-body').empty().prepend(form).end().find('.save-event').unbind('click').click(function () {
        //    form.submit();
        //});
        //$this.$modal.find('form').on('submit', function () {
        //    var title = form.find("input[name='title']").val();
        //    var beginning = form.find("input[name='beginning']").val();
        //    var ending = form.find("input[name='ending']").val();
        //    var categoryClass = form.find("select[name='category'] option:checked").val();
        //    if (title !== null && title.length != 0) {
        //        $this.$calendarObj.fullCalendar('renderEvent', {
        //            title: title,
        //            start: start,
        //            end: end,
        //            allDay: false,
        //            className: categoryClass
        //        }, true);
        //        $this.growltoast("Event Saved Successfully...", "top", "right", "fa fa-bell-o", "success", "animated fadeIn", "animated fadeOut", "success");
        //        $this.$modal.modal('hide');
        //    }
        //    else {
        //        alert('You have to give a title to your event');
        //    }
        //    return false;

        //});
        //$this.$calendarObj.fullCalendar('unselect');
    },

    /* Initializing */
    SUSDashboard.prototype.init = function () {
        //this.enableDrag();
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var form = '';
        var today = new Date($.now());

        var $this = this;
        $this.$calendarObj = $this.$calendar.fullCalendar({
            slotDuration: '00:15:00',
            minTime: '01:00:00',
            maxTime: '24:00:00',
            defaultView: 'month',
            handleWindowResize: true,

            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },

            events: function (start, end, timezone, callback) {
                $.ajax({
                    type: "POST",
                    url: "dashboard.aspx/Get_Task_And_Bind_To_Calendar",
                    contentType: "application/json",
                    data: "{'Task_Type':'all','Priority':'0','Status':'all'}",
                    // dataType: "json",
                    success: function (data) {

                        var classStyle = "";
                        var events = [];
                        var obj = jQuery.parseJSON(data.d);

                        $(obj).each(function () {

                            if ($(this).attr('Status') == "Closed") {
                                classStyle = "bg-success";
                            }
                            else {
                                if ($(this).attr('Priority') == "Low") {
                                    classStyle = "bg-info";
                                }
                                else if ($(this).attr('Priority') == "Medium") {
                                    classStyle = "bg-warning";
                                }
                                else if ($(this).attr('Priority') == "High") {
                                    classStyle = "bg-red";
                                }
                            }

                            events.push({
                                start: $(this).attr('Task_Date'),
                                end: $(this).attr('End_Date'),
                                className: classStyle,
                                id: $(this).attr('Task_Id'),
                                title: $(this).attr('Task_Name'),
                                priority: $(this).attr('Priority'),
                                allDay: false
                            });
                        });
                        callback(events);
                    },
                    error: function (xhr, status, error) {
                        alert(xhr.responseText + "I am in error");
                    }
                });

            },
            //eventMouseover: function (event, domEvent) {

            //$('.customControls').remove();

            //if ($(this).find('.customControls').length == 0) {
            //        $(this).find('.fc-content').append('<div class="customControls" style="position:absolute;width:100%; top:0px; text-align:right;"><a href="javascript:void(0);" class="mr-5" title="Edit" data-toggle="modal" data-target="#taskPopup" onclick=Bind_Task_Main_Details("' + event.id + '","edit");><i class="fa fa-edit" style="color:#fff"></i></a><a href="javascript:void(0);" title="Comment" data-toggle="modal" data-target="#chat" onclick=Bind_Task_Comments_Popup("' + event.id + '");><i class="fa fa-comment" style="color:#fff"></i></a></div>');
            //    }
            //},
            //eventMouseout: function () {
            //$('.customControls').remove();
            //},
            weekends: true,
            editable: true,
            droppable: false,
            eventLimit: true,
            selectable: true,
            select: function (start, end, allDay) { $this.onSelect(start, end, allDay); },
            eventClick: function (calEvent, jsEvent, view) { $this.onEventClick(calEvent, jsEvent, view); },
            views: {
                week: {
                    // options apply to dayGridWeek and timeGridWeek views
                    columnFormat: 'ddd D/MM'
                }
            }
        });
    },

SUSDashboard.prototype.growltoast = function (msg, from, align, icon, type, animIn, animOut, status) {
    $.growl({
        icon: icon,
        title: ' ',
        message: msg,
        url: ''
    }, {
        element: 'body',
        type: type,
        allow_dismiss: true,
        placement: {
            from: from,
            align: align
        },
        offset: {
            x: 30,
            y: 30
        },
        spacing: 10,
        z_index: 999999,
        delay: 5000,
        timer: 1000,
        url_target: '_blank',
        mouse_over: false,
        animate: {
            enter: animIn,
            exit: animOut
        },
        icon_type: 'class',
        template: '<div data-growl="container" class="alert" role="alert">' +
        ' <button type="button" class="close" data-growl="dismiss">' +
        ' <span aria-hidden="true">&times;</span>' +
        ' <span class="sr-only">Close</span>' +
        '</button>' +
        '<span data-growl="icon"></span>' +
        '<span data-growl="title"></span>' +
        '<span data-growl="message" style="margin-right:5px;"></span>' +
        '<a href="#" data-growl="url"></a>' +
        '</div>'
    });
},

$.SUSDashboard = new SUSDashboard, $.SUSDashboard.Constructor = SUSDashboard

}(window.jQuery),// End of use strict

function ($) {
    "use strict";
    $.SUSDashboard.init()

}(window.jQuery);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$(document).ready(function () {

    $('.select2').select2();

    $('.clockpicker').clockpicker({
        donetext: 'Done',
    }).find('input').change(function () {
        console.log(this.value);
    });

    $(function () {
        $("textarea").each(function () {
            this.style.height = (50 + this.scrollHeight) + 'px';
            this.style.overflow = "hidden";
        });
    });

    $(document).on('click', '#btn_Add_Task', function () {
        Enable_Disable_Task_Controls("0");
        Reset_Task_Popup_Controls();
        $("#divComments").addClass("hide");
    });

    $(document).on('click', '#btn_My_Task', function () {

        $("#div_all").addClass("checked");
        $("#div_High").removeClass("checked");
        $("#div_Medium").removeClass("checked");
        $("#div_Low").removeClass("checked");

        $("#div_Open").addClass("checked");
        $("#div_Closed").removeClass("checked");

        Bind_Tasks_To_List();
    });

    $(document).on('click', '#btn_Other_Task', function () {

        $("#div_all").addClass("checked");
        $("#div_High").removeClass("checked");
        $("#div_Medium").removeClass("checked");
        $("#div_Low").removeClass("checked");

        $("#div_Open").addClass("checked");
        $("#div_Closed").removeClass("checked");

        Bind_Tasks_To_List();
    });

    $(document).on('click', '#btn_Enable_Task_Controls', function () {
        Enable_Disable_Task_Controls("0");
    });

    $('#tasktable').on('click', 'td', function () {
        $('#taskPopup').modal("show");
    });

    $(document).on('click', '#lnk-calender', function () {
        $("#calendarFilter").removeClass("hide");
        Bind_Tasks_To_Calendar();
    });

    $(document).on('click', '#lnk-list', function () {
        $("#calendarFilter").addClass("hide");
    });

    $(document).on('click', '#btn_Status', function () {

        var status = "";

        if ($("#btn_Status").hasClass("active")) {
            status = "1";
        }
        else {
            status = "0";
        }

        Update_Task_Status($("#hid_Task_Main_Id").val(), status);
        Bind_Task_Comments($("#hid_Task_Main_Id").val());

        if ($("#lnk-calender").hasClass("active")) {
            Bind_Tasks_To_Calendar();
        }
        else if ($("#lnk-list").hasClass("active")) {
            Bind_Tasks_To_List();
        }
    });

    Bind_DDL_Assigned_To("");
});

function inputDynamicHeight(obj) {
    obj.style.height = "1px";
    obj.style.height = (1 + obj.scrollHeight) + "px";
    obj.style.overflow = "hidden";
}

function Reset_Task_Popup_Controls() {

    $("#hid_Task_Main_Id").val("0");
    $("#txt_Task_Name").val("");
    $("#txt_Task_Description").val("");
    $("#ddl_Task_Priority").val("0");

    var todaysDate = new Date();

    todaysDate = ("0" + todaysDate.getFullYear()).slice(-4) + "-" + ("0" + (todaysDate.getMonth() + 1)).slice(-2) + "-" + ("0" + todaysDate.getDate()).slice(-2);

    $("#txt_Task_Date").val(todaysDate);
    $("#txt_End_Date").val(todaysDate);

    $("#txt_Task_Time").val("09:00");
    $("#txt_End_Time").val("09:30");

    $("#div_Status").addClass("hide");

    Bind_DDL_Assigned_To("");

    $("#lbl_Modal_Title").text("Add Task");
}

function pass_Minutes_Get_Time(totalMinutes) {

    var hours = (totalMinutes / 60).toString().split(".")[0]

    if (hours.toString().length == "1") {
        hours = "0" + hours;
    }

    if (hours >= 24) {
        hours = "00";
    }

    var mins = (totalMinutes % 60);

    if (mins.toString().length == "1") {
        mins = mins + "0";
    }

    return hours + ":" + mins;
}

function Bind_DDL_Assigned_To(selectedEmployees) {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "dashboard.aspx/Get_Assigned_To_Employees",
        data: "{'SelectedEmployees':'" + selectedEmployees + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    $("#ddl_Assigned_To").html(data.d);
                }
            }
        }
    });
}

function Save_Task_Main() {

    if (setBorderColor_Validation("txt_Task_Name,txt_Task_Description,ddl_Task_Priority,txt_Task_Date,txt_End_Date,txt_Task_Time,txt_End_Time,ddl_Assigned_To") == 0) {
        Mendatry_Msg();
    }
    else {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "dashboard.aspx/Insert_Update_Tasks",
            data: "{'Task_Main_Id':'" + $("#hid_Task_Main_Id").val() + "','Task_Name':'" + $("#txt_Task_Name").val() + "','Task_Description':'" + $("#txt_Task_Description").val() + "','Task_Priority':'" + $("#ddl_Task_Priority").val() + "','Task_Date':'" + $("#txt_Task_Date").val() + "','End_Date':'" + $("#txt_End_Date").val() + "','Task_Time':'" + $("#txt_Task_Time").val() + "','End_Time':'" + $("#txt_End_Time").val() + "','Assigned_To':'" + $("#ddl_Assigned_To").val() + "'}",
            dataType: "json",
            success: function (data) {
                if (Chk_Res(data.d) == false) {
                    if (data.d.indexOf("!error!") > -1) {
                        alert("There is an Error:----> " + data.d);
                    }
                    else {
                        if (data.d == "selectedDate") {
                            calltoast("Start date should be less than end date", "error");
                        }
                        else if (data.d == "currentDate") {
                            calltoast("Start/end date can't be in past", "error");
                        }
                        else if (data.d == "selectedTime") {
                            calltoast("Start time should be less than end time", "error");
                        }
                        else {
                            $("#divComments").removeClass("hide");

                            Enable_Disable_Task_Controls("1");

                            if (data.d == "updated") {
                                calltoast("Task updated successfully", "success");
                            }
                            else {
                                $("#hid_Task_Main_Id").val(data.d);
                                calltoast("Task saved successfully", "success");
                            }
                            Bind_Task_Comments($("#hid_Task_Main_Id").val());
                            //$("#btn_Close_Task_Main").click();

                            if ($("#lnk-calender").hasClass("active")) {
                                Bind_Tasks_To_Calendar();
                            }
                            else if ($("#lnk-list").hasClass("active")) {
                                Bind_Tasks_To_List();
                            }
                        }
                    }
                }
            }
        });
    }
}

function Enable_Disable_Task_Controls(isDisable) {

    if (isDisable == "0") {
        $("#txt_Task_Name").removeAttr("disabled");
        $("#txt_Task_Description").removeAttr("disabled");
        $("#ddl_Task_Priority").removeAttr("disabled");
        $("#txt_Task_Date").removeAttr("disabled");
        $("#txt_End_Date").removeAttr("disabled");
        $("#txt_Task_Time").removeAttr("disabled");
        $("#txt_End_Time").removeAttr("disabled");
        $("#ddl_Assigned_To").removeAttr("disabled");

        $("#btn_Enable_Task_Controls").addClass("hide");
        $("#btn_Save_Task_Main").removeClass("hide");
    }
    else if (isDisable == "1") {
        $("#txt_Task_Name").attr("disabled", "disabled");
        $("#txt_Task_Description").attr("disabled", "disabled");
        $("#ddl_Task_Priority").attr("disabled", "disabled");
        $("#txt_Task_Date").attr("disabled", "disabled");
        $("#txt_End_Date").attr("disabled", "disabled");
        $("#txt_Task_Time").attr("disabled", "disabled");
        $("#txt_End_Time").attr("disabled", "disabled");
        $("#ddl_Assigned_To").attr("disabled", "disabled");

        $("#btn_Enable_Task_Controls").removeClass("hide");
        $("#btn_Save_Task_Main").addClass("hide");
    }
}

function Bind_Tasks_To_Calendar() {

    var taskType = "", priority = "", status = "";

    if ($("#div_All_Task_Calendar").hasClass("checked")) {
        taskType = "all";
    }
    else if ($("#div_My_Task_Calendar").hasClass("checked")) {
        taskType = "self";
    }
    else if ($("#div_Other_Tasks_Calendar").hasClass("checked")) {
        taskType = "other";
    }

    if ($("#div_All_Priority_Calendar").hasClass("checked")) {
        priority = "0";
    }
    else if ($("#div_High_Priority_Calendar").hasClass("checked")) {
        priority = "3";
    }
    else if ($("#div_Medium_Priority_Calendar").hasClass("checked")) {
        priority = "2";
    }
    else if ($("#div_Low_Priority_Calendar").hasClass("checked")) {
        priority = "1";
    }

    if ($("#div_All_Status_Calendar").hasClass("checked")) {
        status = "all";
    }
    else if ($("#div_Open_Status_Calendar").hasClass("checked")) {
        status = "1";
    }
    else if ($("#div_Closed_Status_Calendar").hasClass("checked")) {
        status = "0";
    }

    $('#calender').html("");
    $('#calender').fullCalendar("destroy");

    $('#calender').fullCalendar({

        slotDuration: '00:15:00',
        minTime: '01:00:00',
        maxTime: '24:00:00',
        defaultView: 'month',
        handleWindowResize: true,

        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },

        events: function (start, end, timezone, callback) {

            $.ajax({
                type: "POST",
                url: "dashboard.aspx/Get_Task_And_Bind_To_Calendar",
                contentType: "application/json",
                data: "{'Task_Type':'" + taskType + "','Priority':'" + priority + "','Status':'" + status + "'}",
                success: function (data) {

                    var classStyle = "";
                    var events = [];

                    if (data.d != "") {
                        var obj = jQuery.parseJSON(data.d);

                        $(obj).each(function () {

                            if ($(this).attr('Status') == "Closed") {
                                classStyle = "bg-success";
                            }
                            else {
                                if ($(this).attr('Priority') == "Low") {
                                    classStyle = "bg-info";
                                }
                                else if ($(this).attr('Priority') == "Medium") {
                                    classStyle = "bg-warning";
                                }
                                else if ($(this).attr('Priority') == "High") {
                                    classStyle = "bg-red";
                                }
                            }

                            events.push({
                                start: $(this).attr('Task_Date'),
                                end: $(this).attr('End_Date'),
                                className: classStyle,
                                id: $(this).attr('Task_Id'),
                                title: $(this).attr('Task_Name'),
                                priority: $(this).attr('Priority'),
                                allDay: false
                            });
                        });
                        callback(events);
                    }
                },
                error: function (xhr, status, error) {
                    alert(xhr.responseText + "I am in error");
                }
            });
        },
        //eventMouseover: function (event, domEvent) {

        //    $('.customControls').remove();

        //    if ($(this).find('.customControls').length == 0) {
        //        $(this).find('.fc-content').append('<div class="customControls" style="position:absolute;width:100%; top:0px; text-align:right;"><a href="javascript:void(0);" class="mr-5" title="Edit" data-toggle="modal" data-target="#taskPopup" onclick=Bind_Task_Main_Details("' + event.id + '","edit");><i class="fa fa-edit" style="color:#fff"></i></a><a href="javascript:void(0);" title="Comment" data-toggle="modal" data-target="#chat" onclick=Bind_Task_Comments_Popup("' + event.id + '");><i class="fa fa-comment" style="color:#fff"></i></a></div>');
        //    }
        //},
        //eventMouseout: function () {
        //    $('.customControls').remove();
        //},
        weekends: true,
        editable: true,
        droppable: false,
        eventLimit: true,
        selectable: true,
        select: function (start, end, allDay) {

            Enable_Disable_Task_Controls("0");
            Reset_Task_Popup_Controls();
            $("#divComments").addClass("hide");

            $("#hid_Task_Main_Id").val("0");

            var selectedDate = new Date(start);
            selectedDate = ("0" + selectedDate.getFullYear()).slice(-4) + "-" + ("0" + (selectedDate.getMonth() + 1)).slice(-2) + "-" + ("0" + selectedDate.getDate()).slice(-2);

            $("#txt_Task_Date").val(selectedDate);
            $("#txt_End_Date").val(selectedDate);

            var selectedTime = new Date(start);
            var hours = selectedTime.getUTCHours();
            var minutes = selectedTime.getUTCMinutes();

            selectedTime = selectedTime.getUTCHours() + ":" + selectedTime.getUTCMinutes();

            if (selectedTime == "0:0") {
                $("#txt_Task_Time").val("09:00");
                $("#txt_End_Time").val("09:30");
            }
            else {
                var actualMinutes = (hours * 60) + (minutes);
                var actualTime = pass_Minutes_Get_Time(actualMinutes);
                $("#txt_Task_Time").val(actualTime);

                actualMinutes += 30;
                actualTime = pass_Minutes_Get_Time(actualMinutes);
                $("#txt_End_Time").val(actualTime);
            }

            $("#lbl_Modal_Title").text("Add Task");

            $('#taskPopup').modal("show");
        },
        eventClick: function (calEvent, jsEvent, view) {
            $("#hid_Task_Main_Id").val(calEvent.id);

            Bind_Task_Main_Details(calEvent.id);

            $("#lbl_Modal_Title").text("Edit Task");

            $('#taskPopup').modal("show");
        },
        views: {
            week: {
                // options apply to dayGridWeek and timeGridWeek views
                columnFormat: 'ddd D/MM'
            }
        },
        dayClick: function (start, end, allDay) {
            Reset_Task_Popup_Controls();

            var selectedDate = new Date(start);

            selectedDate = ("0" + selectedDate.getFullYear()).slice(-4) + "-" + ("0" + (selectedDate.getMonth() + 1)).slice(-2) + "-" + ("0" + selectedDate.getDate()).slice(-2);

            $("#hid_Task_Main_Id").val("0");

            $("#txt_Task_Date").val(selectedDate);
            $("#txt_End_Date").val(selectedDate);

            $("#lbl_Modal_Title").text("Add Task");

            $('#taskPopup').modal("show");
        },
    });
}

function Bind_Tasks_To_List() {

    var taskType = "", priority = "", status = "";

    if ($("#btn_My_Task").hasClass("active")) {
        taskType = "self";
    }
    else if ($("#btn_Other_Task").hasClass("active")) {
        taskType = "other";
    }

    if ($("#div_all").hasClass("checked")) {
        priority = "0";
    }
    else if ($("#div_High").hasClass("checked")) {
        priority = "3";
    }
    else if ($("#div_Medium").hasClass("checked")) {
        priority = "2";
    }
    else if ($("#div_Low").hasClass("checked")) {
        priority = "1";
    }

    if ($("#div_Open").hasClass("checked")) {
        status = "1";
    }
    else if ($("#div_Closed").hasClass("checked")) {
        status = "0";
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "dashboard.aspx/Get_Tasks_And_Bind_To_List",
        data: "{'Task_Type':'" + taskType + "','Priority':'" + priority + "','Status':'" + status + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    var taskTableHTML = "";

                    if (data.d == "record") {
                        taskTableHTML = "<tr><td colspan='6'>No record found</td></tr>";
                    }
                    else {
                        var taskRows = data.d.split("^");
                        var taskRowValues = "";

                        for (var i = 0; i < taskRows.length - 1; i++) {
                            taskRowValues = taskRows[i].split("|");

                            taskTableHTML += "<tr>"
                                            + "<td title='" + taskRowValues[2] + "'>" + taskRowValues[1] + "</td>"
                                            + "<td>" + taskRowValues[3] + "</td>"
                                            + "<td>" + taskRowValues[4] + " / " + taskRowValues[5] + "</td>"
                                            + "<td>" + taskRowValues[7] + "</td>"
                                            + "<td>"
                                            + "<div class='btn-group'>"
                                            + "<button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>"
                                            + "<span><i class='ti-settings'></i></span>"
                                            + "</button>"
                                            + "<ul class='dropdown-menu dropdown-menu-right'>"
                                            //+ "<li id='btn_Task_Main_View' onclick=Bind_Task_Main_Details('" + taskRowValues[0] + "','view');><a href='javascript:void(0);' data-toggle='modal' data-target='#taskPopup' class='dropdown-item'><i class='fa fa-eye'></i>View</a></li>"
                                            //+ "<li class='dropdown-divider'></li>"
                                            //+ "<li id='btn_Task_Main_Edit' onclick=Bind_Task_Main_Details('" + taskRowValues[0] + "','edit');><a href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#taskPopup'><i class='fa fa-pencil'></i>Edit</a></li>"
                                            //+ "<li class='dropdown-divider'></li>"
                                            + "<li id='btn_Task_Update_Comments' onclick=Bind_Task_Main_Details('" + taskRowValues[0] + "');><a href='javascript:void(0);' data-toggle='modal' data-target='#taskPopup' class='dropdown-item'><i class='fa fa-pencil'></i>Update</a></li>"
                                            + "<li class='dropdown-divider'></li>";

                            if (taskRowValues[7] == "Open") {
                                taskTableHTML += "<li onclick=Update_Task_Status('" + taskRowValues[0] + "','0');><a href='javascript:void(0);' class='dropdown-item'><i class='fa fa-clipboard'></i>Mark Closed</a></li>";
                            }
                            else if (taskRowValues[7] == "Closed") {
                                taskTableHTML += "<li onclick=Update_Task_Status('" + taskRowValues[0] + "','1');><a href='javascript:void(0);' class='dropdown-item'><i class='fa fa-clipboard'></i>Mark Open</a></li>";
                            }
                            + "</ul>"
                            + "</div>"
                            + "</td>"
                            + "</tr>";
                        }
                    }
                    $("#tbody_Task_Main").html(taskTableHTML);
                }
            }
        }
    });
}

function Bind_Task_Comments(Task_Id) {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "dashboard.aspx/Get_Task_Comments",
        data: "{'Task_Id':'" + Task_Id + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    $("#hid_Task_Main_Id").val(Task_Id);
                    $("#div_Task_Comments").html(data.d);
                    $("#divComments").removeClass("hide");
                }
            }
        }
    });
}

function Insert_Task_Comment(btnValue) {

    if ($("#txt_Task_Comment").val() == "") {
        calltoast("Please write your comment", "error");
    }
    else {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "dashboard.aspx/Save_Task_Comments",
            data: "{'Task_Id':'" + $("#hid_Task_Main_Id").val() + "','Comment':'" + $("#txt_Task_Comment").val() + "'}",
            dataType: "json",
            success: function (data) {
                if (Chk_Res(data.d) == false) {
                    if (data.d.indexOf("!error!") > -1) {
                        alert("There is an Error:----> " + data.d);
                    }
                    else {
                        if (data.d == "saved") {
                            calltoast("Comment saved successfully", "success");
                            Bind_Task_Comments($("#hid_Task_Main_Id").val());
                        }

                        if (btnValue == "exit") {
                            $("#btn_Task_Comment_Popup_Close").click();
                        }
                    }
                }
            }
        });
    }
}

function Bind_Task_Main_Details(Task_Id) {

    $("#hid_Task_Main_Id").val(Task_Id);

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "dashboard.aspx/Get_Task_Main_Details",
        data: "{'Task_Id':'" + $("#hid_Task_Main_Id").val() + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    $("#txt_Task_Name").val(data.d.split("|")[0]);
                    $("#txt_Task_Description").val(data.d.split("|")[1]);
                    $("#ddl_Task_Priority").val(data.d.split("|")[2]);
                    $("#txt_Task_Date").val(data.d.split("|")[3]);
                    $("#txt_End_Date").val(data.d.split("|")[4]);
                    $("#txt_Task_Time").val(data.d.split("|")[5]);
                    $("#txt_End_Time").val(data.d.split("|")[6]);

                    $("#div_Status").removeClass("hide");

                    if (data.d.split("|")[7] == "0") {
                        $("#btn_Status").removeClass("active");
                    }
                    else if (data.d.split("|")[7] == "1") {
                        $("#btn_Status").addClass("active");
                    }

                    Bind_DDL_Assigned_To(data.d.split("|")[8]);

                    Enable_Disable_Task_Controls("1");

                    $("#lbl_Modal_Title").text("Update Task");

                    Bind_Task_Comments(Task_Id);
                }
            }
        }
    });
}

function Update_Task_Status(Task_Id, status) {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "dashboard.aspx/Update_Task_Main_Status",
        data: "{'Task_Id':'" + Task_Id + "','Status':'" + status + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    if (data.d == "updated") {
                        if (status == "0") {
                            calltoast("Task closed successfully", "success");
                        }
                        else if (status == "1") {
                            calltoast("Task opened successfully", "success");
                        }
                        Bind_Tasks_To_List();
                    }
                }
            }
        }
    });
}

function FilterList(obj, filterPortion) {
    //filterPortion is used to identify whether it is right or left filter

    if (filterPortion == "1") {
        $("#div_all").removeClass("checked");
        $("#div_High").removeClass("checked");
        $("#div_Medium").removeClass("checked");
        $("#div_Low").removeClass("checked");

        if ($(obj).hasClass("checked")) {
            $(obj).removeClass("checked");
        }
        else {
            $(obj).addClass("checked");
        }

        if ($("#div_all").hasClass("checked") == false && $("#div_High").hasClass("checked") == false && $("#div_Medium").hasClass("checked") == false && $("#div_Low").hasClass("checked") == false && $("#div_Open").hasClass("checked") == false && $("#div_Closed").hasClass("checked") == false) {
            $("#div_all").addClass("checked");
        }
    }
    else if (filterPortion == "2") {
        $("#div_Open").removeClass("checked");
        $("#div_Closed").removeClass("checked");

        if ($(obj).hasClass("checked")) {
            $(obj).removeClass("checked");
        }
        else {
            $(obj).addClass("checked");
        }

        if ($("#div_Open").hasClass("checked") == false && $("#div_Closed").hasClass("checked") == false) {
            $("#div_Open").addClass("checked");
        }
    }

    Bind_Tasks_To_List();
}

function FilterCalendar(obj, filterPortion) {
    //filterPortion is used to identify whether it is right or left filter

    if (filterPortion == "1") {
        $("#div_All_Task_Calendar").removeClass("checked");
        $("#div_My_Task_Calendar").removeClass("checked");
        $("#div_Other_Tasks_Calendar").removeClass("checked");

        if ($(obj).hasClass("checked")) {
            $(obj).removeClass("checked");
        }
        else {
            $(obj).addClass("checked");
        }

        if ($("#div_All_Task_Calendar").hasClass("checked") == false && $("#div_My_Task_Calendar").hasClass("checked") == false && $("#div_Other_Tasks_Calendar").hasClass("checked") == false) {
            $("#div_All_Task_Calendar").addClass("checked");
        }
    }
    else if (filterPortion == "2") {
        $("#div_All_Priority_Calendar").removeClass("checked");
        $("#div_High_Priority_Calendar").removeClass("checked");
        $("#div_Medium_Priority_Calendar").removeClass("checked");
        $("#div_Low_Priority_Calendar").removeClass("checked");

        if ($(obj).hasClass("checked")) {
            $(obj).removeClass("checked");
        }
        else {
            $(obj).addClass("checked");
        }

        if ($("#div_All_Priority_Calendar").hasClass("checked") == false && $("#div_High_Priority_Calendar").hasClass("checked") == false && $("#div_Medium_Priority_Calendar").hasClass("checked") == false && $("#div_Low_Priority_Calendar").hasClass("checked") == false) {
            $("#div_All_Priority_Calendar").addClass("checked");
        }
    }
    else if (filterPortion == "3") {
        $("#div_All_Status_Calendar").removeClass("checked");
        $("#div_Open_Status_Calendar").removeClass("checked");
        $("#div_Closed_Status_Calendar").removeClass("checked");

        if ($(obj).hasClass("checked")) {
            $(obj).removeClass("checked");
        }
        else {
            $(obj).addClass("checked");
        }

        if ($("#div_All_Status_Calendar").hasClass("checked") == false && $("#div_Open_Status_Calendar").hasClass("checked") == false && $("#div_Closed_Status_Calendar").hasClass("checked") == false) {
            $("#div_All_Status_Calendar").addClass("checked");
        }
    }

    Bind_Tasks_To_Calendar();
}

function calltoast(msg, msgtype) {
    $.toast({
        heading: '',
        text: msg,
        position: 'top-right',
        loaderBg: '#ff6849',
        icon: msgtype,
        hideAfter: 3000,
        stack: 6
    });
}