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
    $rootScope.curTab = "songs"
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


  #    $http.get $rootScope.api+"/songs"
    $http.get $rootScope.api+"/song?id="+$scope.id
    .success (data) ->
      console.log "Song received"
      console.log data
      $scope.song = data

      #    $http.get $rootScope.api+"/songs"
      if $scope.song.lyric_id
        $http.get $rootScope.api+"/lyric?id="+$scope.song.lyric_id
        .success (data) ->
          console.log "Lyric received"
          console.log data
          $scope.lyric = data
          $scope.loading = false
      else
        $scope.loading = false

      $scope.clusters = []
      for clusterid in $scope.song.cluster_ids
        $http.get $rootScope.api+"/cluster?id="+clusterid
        .success (data) ->
          console.log "Cluster received"
          console.log data
          $scope.clusters.push(data)



