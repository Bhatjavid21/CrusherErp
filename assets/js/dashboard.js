

!function ($) {
    "use strict";

    var SUSDashboard = function () {
        this.$body = $("body")
        this.$calendar = $('#calendar'),
        this.$event = ('#external-events div.external-event'),
        this.$categoryForm = $('#add-new-events form'),
        this.$extEvents = $('#external-events'),
        this.$modal = $('#my-event'),
        this.$saveCategoryBtn = $('.save-category'),
        this.$calendarObj = null
    };


    /* on click on event */
    SUSDashboard.prototype.onEventClick = function (calEvent, jsEvent, view) {
        var $this = this;
        var form = $("<form></form>");
        form.append("<label>Change event name</label>");
        form.append("<div class='input-group'><input class='form-control' type=text value='" + calEvent.title + "' /><span class='input-group-btn'><button type='submit' class='btn btn-success waves-effect waves-light'><i class='fa fa-check'></i> Save</button></span></div>");
        $this.$modal.modal({
            backdrop: 'static'
        });
        $this.$modal.find('.delete-event').show().end().find('.save-event').hide().end().find('.modal-body').empty().prepend(form).end().find('.delete-event').unbind('click').click(function () {
            
            $this.$calendarObj.fullCalendar('removeEvents', function (ev) {
                if (ev._id == calEvent._id) {
                    $this.growltoast("Item Deleted Successfully...", "top", "right", "fa fa-bell-o", "success", "animated fadeIn", "animated fadeOut", "success");
                    return true;
                }
            });
            $this.$modal.modal('hide');
        });
        $this.$modal.find('form').on('submit', function () {
            calEvent.title = form.find("input[type=text]").val();
            $this.growltoast("Item Updated Successfully...", "top", "right", "fa fa-bell-o", "success", "animated fadeIn", "animated fadeOut", "success");
            $this.$calendarObj.fullCalendar('updateEvent', calEvent);
            $this.$modal.modal('hide');
            
            return false;
        });
    },

    /* on select */
    SUSDashboard.prototype.onSelect = function (start, end, allDay) {
        var $this = this;
        $this.$modal.modal({
            backdrop: 'static'
        });
        var form = $("<form></form>");
        form.append("<div class='row'></div>");
        form.find(".row")
            .append("<div class='col-md-6'><div class='form-group'><label class='control-label'>Event Name</label><input class='form-control' placeholder='Insert Event Name' type='text' name='title'/></div></div>")
            .append("<div class='col-md-6'><div class='form-group'><label class='control-label'>Category</label><select class='form-control' name='category'></select></div></div>")
            .find("select[name='category']")
            .append("<option value='bg-danger'>Danger</option>")
            .append("<option value='bg-success'>Success</option>")
            .append("<option value='bg-purple'>Purple</option>")
            .append("<option value='bg-primary'>Primary</option>")
            .append("<option value='bg-pink'>Pink</option>")
            .append("<option value='bg-info'>Info</option>")
            .append("<option value='bg-warning'>Warning</option></div></div>");
        $this.$modal.find('.delete-event').hide().end().find('.save-event').show().end().find('.modal-body').empty().prepend(form).end().find('.save-event').unbind('click').click(function () {
            form.submit();
        });
        $this.$modal.find('form').on('submit', function () {
            var title = form.find("input[name='title']").val();
            var beginning = form.find("input[name='beginning']").val();
            var ending = form.find("input[name='ending']").val();
            var categoryClass = form.find("select[name='category'] option:checked").val();
            if (title !== null && title.length != 0) {
                $this.$calendarObj.fullCalendar('renderEvent', {
                    title: title,
                    start: start,
                    end: end,
                    allDay: false,
                    className: categoryClass
                }, true);
                $this.growltoast("Event Saved Successfully...", "top", "right", "fa fa-bell-o", "success", "animated fadeIn", "animated fadeOut", "success");
                $this.$modal.modal('hide');
            }
            else {
                alert('You have to give a title to your event');
            }
            return false;

        });
        $this.$calendarObj.fullCalendar('unselect');
    },
    SUSDashboard.prototype.enableDrag = function () {
        $(this.$event).each(function () {
            var eventObject = {
                title: $.trim($(this).text()) 
            };

            $(this).data('eventObject', eventObject);
            $(this).draggable({
                zIndex: 999999,
                revert: true,      
                revertDuration: 0  
            });
        });
    }

    /* Initializing */
    SUSDashboard.prototype.init = function () {
        this.enableDrag();
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var form = '';
        var today = new Date($.now());





        var defaultEvents = [{
            title: 'Released Ample Admin!',
            start: '2019-08-08',
            end: '2019-08-08',
            className: 'bg-info'
        }, {
            title: 'This is today check date',
            start: today,
            end: today,
            className: 'bg-danger'
        }, {
            title: 'Event 2 goes here',
            start: '2019-11-20 11:00',
            end: '2019-11-20 12:07',
            className: 'bg-success'
        }, {
            title: 'This is your birthday',
            start: '2019-09-08',
            end: '2019-09-08',
            className: 'bg-info'
        }, {
            title: 'Hanns birthday',
            start: '2019-10-08',
            end: '2019-10-08',
            className: 'bg-danger'
        },
        {
            title: 'Like it?',
            start: new Date($.now() + 784800000),
            className: 'bg-success'
        }];




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
            events: defaultEvents,
            editable: true,
            droppable: false, 
            eventLimit: true, 
            selectable: true,
            select: function (start, end, allDay) { $this.onSelect(start, end, allDay); },
            eventClick: function (calEvent, jsEvent, view) { $this.onEventClick(calEvent, jsEvent, view); }

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