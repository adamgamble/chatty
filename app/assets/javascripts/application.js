// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require oembed
//= require md5
//= require gravatar
//= require_tree .

var ws = $.websocket("ws://" + window.location.hostname + ":1234/", {
          events: {
                    chat: function(e) {
                            angular.element($('.messages')).scope().posts.push({username: e.data.username, body: e.data.body, gravatar: $.gravatar(e.data.username).attr("src")});
                            angular.element($('.messages')).scope().$apply();
                            $('body').animate({scrollTop: $(document).height()});
                            $('a:not(.embed)').oembed().addClass("embed");
                          },
                    total_users: function(e) {
                          angular.element($('.messages')).scope().users = $.map(e.data, function(a) { $.gravatar(a).attr('src');});
                          angular.element($('.messages')).scope().$apply();
                    }
                  }
          });
