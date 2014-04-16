angular.module("oauthClient", ["ngResource", "oauthClient.controllers", "oauthClient.services", "oauthClient.resources"])
  .run ["$templateCache", "$http", ($templateCache, $http) ->
    console.log "adding template"
    $http.get("posts.html", {cache:$templateCache})
    $http.get("home.html", {cache:$templateCache})
  ]