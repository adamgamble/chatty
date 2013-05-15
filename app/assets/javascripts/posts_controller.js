var chatty = angular.module('chatty', []);

chatty.factory('Posts', function() {
  return [{username: "Adam Gamble", body: "now is the time for all good men to come to the aid of their country"}];
});

chatty.directive("newpost", function() {
  return function(scope, element, attrs) {
    element.bind("submit", function() {
      scope.posts.push({username: "Adam Gamble", body: $('.chat-box').val()})
      $('.chat-box').val("");
      $('body').animate({scrollTop: $(document).height()});
      scope.$apply();
      $('a.embed').oembed().removeClass("embed");
    });
  }
});

function PostsCtrl($scope, Posts) {
  $scope.posts = Posts;
}
