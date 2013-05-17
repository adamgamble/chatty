var chatty = angular.module('chatty', []);

chatty.factory('Posts', function() {
  return [];
});

chatty.factory('Users', function() {
  return [{gravatar: $.gravatar('adamgamble@gmail.com').attr('src')}];
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

function PostsCtrl($scope, Posts, Users) {
  $scope.posts = Posts;
  $scope.users = Users;
}

