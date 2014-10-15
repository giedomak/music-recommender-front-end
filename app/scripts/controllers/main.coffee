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
    $rootScope.curTab = "home"
    $rootScope.data = {}


    $scope.spotifylogin = () ->
      Spotify.login()

    $scope.recommend = () ->
      $http.get "http://localhost:8080/spotify?token="+$rootScope.user.spotifytoken
      .success (data) ->
        console.log data
        $rootScope.data = data.lyricIds