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

  #    $http.get $rootScope.api+"/songs"
    $http.get $rootScope.api+"/clusters"
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