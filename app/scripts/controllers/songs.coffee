'use strict'

###*
 # @ngdoc function
 # @name 2Id26App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the 2Id26App
###
angular.module('2Id26App')
  .controller 'SongsCtrl', ($http, $rootScope, $scope) ->
    $scope.loading = true
    $rootScope.curTab = "songs"
    $scope.songs = ["henk"]

    $scope.currentPage = 1
    $scope.itemsPerPage = 20

  #    $http.get $rootScope.api+"/songs"
    $http.get $rootScope.api+"/songs"
    .success (data) ->
      console.log data
      $scope.songs = shuffle(data)
      $scope.loading = false

    shuffle = (a) ->
      i = a.length
      while --i > 0
        j = ~~(Math.random() * (i + 1)) # ~~ is a common optimization for Math.floor
        t = a[j]
        a[j] = a[i]
        a[i] = t
      a

  .filter 'pagination', ->
    (items, scope) ->
      start = (scope.currentPage-1) * scope.itemsPerPage
      end = (scope.currentPage-1) * scope.itemsPerPage + scope.itemsPerPage
      items[start...end]