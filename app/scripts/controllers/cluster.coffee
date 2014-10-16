'use strict'

###*
 # @ngdoc function
 # @name 2Id26App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the 2Id26App
###
angular.module('2Id26App')
  .controller 'ClusterCtrl', ($routeParams, $http, $rootScope, $scope) ->
    $rootScope.curTab = "clusters"
    $scope.loading = true
    $scope.id = parseInt($routeParams.id)


  #    $http.get "http://178.62.207.179:8080/songs"
    $http.get "http://178.62.207.179:8080/cluster?id="+$scope.id
    .success (data) ->
      console.log data
      $scope.cluster = data
      $http.get "http://178.62.207.179:8080/songs"
      .success (data) ->
        console.log data
        tmp = data.filter (x) -> $scope.id in x.cluster_ids
        $scope.songs = tmp
        $scope.loading = false

