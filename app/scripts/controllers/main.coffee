'use strict'

###*
 # @ngdoc function
 # @name 2Id26App.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the 2Id26App
###
angular.module('2Id26App')
  .controller 'MainCtrl', ($http, Spotify, $routeParams, $rootScope, $scope) ->
    console.log "main init"
    $rootScope.curTab = "home"

    $scope.spotifylogin = () ->
      Spotify.login()

    $rootScope.recommend = () ->
      $rootScope.clicked = true
      Array::unique = ->
        output = {}
        output[@[key]] = @[key] for key in [0...@length]
        value for key, value of output

      $rootScope.loading3 = true
      $http.get $rootScope.api+"/spotify?token="+$rootScope.user.spotifytoken
      .success (data) ->
        data.songIds.unique()
        console.log data
        $rootScope.songs3 = []

        for songid in data.songIds
          id = songid.toString()
          console.log songid
          $http.get $rootScope.api+"/song?id="+id
          .success (data) ->
            console.log "Song received"
            console.log data
            tmp = $rootScope.songs3.filter (x) -> x.id is data.id
            if tmp.length is 0 and data.id >= 0
              $rootScope.songs3.push(data)

        $rootScope.loading3 = false

