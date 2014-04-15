angular.module('oauthClient.controllers', [])
  .controller 'PostsCtrl', ["$scope", "Post", ($scope, Post) ->
    $scope.posts = Post.query()
  ]