angular.module('oauthClient.controllers', [])

@PageCtrl = ["$scope", ($scope) ->
  $scope.tpl = "home.html"
]

@PostCtrl = ["$scope", "$http", ($scope, $http) ->
  $scope.posts = {}
  $http.get('/posts').success((data) ->
    console.log data
    $scope.posts = data
  )
]