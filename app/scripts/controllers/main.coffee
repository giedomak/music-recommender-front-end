'use strict'

###*
 # @ngdoc function
 # @name 2Id26App.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the 2Id26App
###
angular.module('2Id26App')
  .controller 'MainCtrl', (Spotify, $routeParams, $rootScope, $scope) ->
    $rootScope.curTab = "home"
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
      
    $scope.login = () ->
      Spotify.login()
