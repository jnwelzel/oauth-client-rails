angular.module('oauthClient.resources', [])
  .factory "Post", ["$resource", ($resource) ->
    $resource("/posts/:id", {id: "@id"}, {update: {method: "PUT"}})
  ]