'use strict'

###*
 # @ngdoc function
 # @name 2Id26App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the 2Id26App
###
angular.module('2Id26App')
  .controller 'ClustersCtrl', ($http, $rootScope, $scope) ->
    $scope.loading = true
    $rootScope.curTab = "clusters"

  #    $http.get "http://178.62.207.179:8080/songs"
    $http.get "http://178.62.207.179:8080/clusters"
    .success (data) ->
      console.log data
      $scope.clusters = shuffle(data)
      $scope.loading = false

    shuffle = (a) ->
      i = a.length
      while --i > 0
        j = ~~(Math.random() * (i + 1)) # ~~ is a common optimization for Math.floor
        t = a[j]
        a[j] = a[i]
        a[i] = t
      a