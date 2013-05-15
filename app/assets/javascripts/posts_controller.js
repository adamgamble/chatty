var chatty = angular.module('chatty', []);

chatty.factory('Posts', function() {
  return [];
});

chatty.directive("newpost", function() {
  return function(scope, element, attrs) {
    element.bind("submit", function() {
      message = {username: $('body').data('email'), body: $('.chat-box').val(), gravatar: $.gravatar($('body').data('email')).attr('src')};
      $('.chat-box').val("");
      ws.send("chat", message);
    });
  }
});

function PostsCtrl($scope, Posts) {
  $scope.posts = Posts;
}

