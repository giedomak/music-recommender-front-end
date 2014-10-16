'use strict'

###*
 # @ngdoc function
 # @name 2Id26App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the 2Id26App
###
angular.module('2Id26App')
  .controller 'SongCtrl', ($routeParams, $http, $rootScope, $scope) ->
    $rootScope.curTab = ""
    $scope.loading = true
    $scope.id = parseInt($routeParams.id)

    $scope.plutchik = (val) ->
      switch val
        when 0 then return "Not available"
        when 1 then return "Joy"
        when 2 then return "Sadness"
        when 3 then return "Trust"
        when 4 then return "Disgust"
        when 5 then return "Fear"
        when 6 then return "Anger"
        when 7 then return "Surprise"
        when 8 then return "Anticipation"

    $scope.polarity = (val) ->
      switch val
        when -1 then return "Negative"
        when 0 then return "Neutral"
        when 1 then return "Positive"


  #    $http.get "http://178.62.207.179:8080/songs"
    $http.get "http://localhost:8080/song?id="+$scope.id
    .success (data) ->
      console.log data
      $scope.song = data

      #    $http.get "http://178.62.207.179:8080/songs"
      $http.get "http://localhost:8080/lyric?id="+$scope.song.lyric_id
      .success (data) ->
        console.log data
        $scope.lyric = data
        $scope.loading = false

