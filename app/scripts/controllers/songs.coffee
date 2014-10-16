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
    $rootScope.curTab = "songs"

#    $http.get "http://178.62.207.179:8080/songs"
    $http.get "http://localhost:8080/songs"
    .success (data) ->
      console.log data
      $scope.songs = data
