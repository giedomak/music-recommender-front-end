'use strict'

###*
 # @ngdoc function
 # @name 2Id26App.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the 2Id26App
###
angular.module('2Id26App')
  .controller 'MainCtrl', (deezer, $sce, $http, Spotify, $routeParams, $rootScope, $scope) ->
    console.log "main init"
    $rootScope.curTab = "home"

    $scope.spotifylogin = () ->
      Spotify.login()

    $scope.deezerlogin = () ->
      #Check if I'm already logged
      unless $rootScope.user_data
        deezer.login (response) ->
          console.log response
          $rootScope.user_data =
            access_token: response.authResponse.accessToken
            user_id: response.userID

          return


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
        $rootScope.spotify_urls = "https://embed.spotify.com/?uri=spotify:trackset:Music%20Recommendations:"

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
              if data.spotifyId
                $rootScope.spotify_urls += ","+data.spotifyId
                $rootScope.spotify_url = $sce.trustAsResourceUrl($rootScope.spotify_urls+"&theme=white")

        $rootScope.loading3 = false

