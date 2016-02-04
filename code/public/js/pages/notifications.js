$(function() {
  $.rand = function(arg) {
    if ($.isArray(arg)) {
      return arg[$.rand(arg.length)];
    } else if (typeof arg === "number") {
      return Math.floor(Math.random() * arg);
    } else {
      return 4; // chosen by fair dice roll
    }
  };
});

var notificationsHandler = {

  showNotification: function(notifyIcon, notifyTitle, notifyMessage, notifyUrl, notifyType) {

    $.notify({
      // options
      icon: notifyIcon,
      title: notifyTitle,
      message: notifyMessage,
      url: notifyUrl,
      target: '_self'
    }, {
      // settings
      element: 'body',
      position: null,
      type: notifyType,
      allow_dismiss: true,
      newest_on_top: true,
      showProgressbar: false,
      placement: {
        from: "top",
        align: "right"
      },
      offset: {
        x: 5,
        y: 60
      },
      spacing: 10,
      z_index: 1031,
      delay: 5000,
      timer: 1000,
      url_target: '_blank',
      mouse_over: null,
      animate: {
        enter: 'animated fadeInDown',
        exit: 'animated fadeOutUp'
      },
      onShow: null,
      onShown: null,
      onClose: null,
      onClosed: null,
      icon_type: 'class',
      template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert">' +
        '<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
        '<h4><span data-notify="icon"></span></i> <span data-notify="title">{1}</span></h4>' +
        '<span data-notify="message">{2}</span>' +
        '<a href="{3}" target="{4}" data-notify="url"></a>' +
        '</div>'
    });
  },

  generateDemoMessage: function() {

    var listIcons = ["icon fa fa-balance-scale",
      "icon fa fa-battery-half",
      "icon fa fa-bell",
      "icon fa fa-calendar"
    ];
    var listTitles = ["Sheep on the Loose",
      "Dolly has left the field",
      "Sensor 123 battery",
      "Alert!",
      "Something Happened!",
      "Pay Attention",
      "New Data"
    ];
    var listMessages = ["Something has happened. Do something.",
      "A sensor has been activated.",
      "Insert alert message here."
    ];
    var listUrl = ["/ops",
      "/deSheep",
      "deSoil"
    ];
    var listTypes = ["danger",
      "success",
      "warning",
      "info"
    ];

    var randomIcon = $.rand(listIcons);
    var randomTitle = $.rand(listTitles);
    var randomMessage = $.rand(listMessages);
    var randomUrl = $.rand(listUrl);
    var randomType = $.rand(listTypes);

    $.notify({
      // options
      icon: randomIcon,
      title: randomTitle,
      message: randomMessage,
      url: randomUrl,
      target: '_self'
    }, {
      // settings
      element: 'body',
      position: null,
      type: randomType,
      allow_dismiss: true,
      newest_on_top: true,
      showProgressbar: false,
      placement: {
        from: "top",
        align: "right"
      },
      offset: {
        x: 5,
        y: 60
      },
      spacing: 10,
      z_index: 1031,
      delay: 5000,
      timer: 1000,
      url_target: '_blank',
      mouse_over: null,
      animate: {
        enter: 'animated fadeInDown',
        exit: 'animated fadeOutUp'
      },
      onShow: null,
      onShown: null,
      onClose: null,
      onClosed: null,
      icon_type: 'class',
      template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert">' +
        '<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
        '<h4><span data-notify="icon"></span></i> <span data-notify="title">{1}</span></h4>' +
        '<span data-notify="message">{2}</span>' +
        '<a href="{3}" target="{4}" data-notify="url"></a>' +
        '</div>'
    });
  }

};
