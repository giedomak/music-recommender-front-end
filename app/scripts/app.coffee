'use strict'

###*
 # @ngdoc overview
 # @name 2Id26App
 # @description
 # # 2Id26App
 #
 # Main module of the application.
###
angular
  .module('2Id26App', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'firebase'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
      .otherwise
        redirectTo: '/'
  .run ($http, $firebase, $firebaseSimpleLogin, $rootScope) ->
    console.log "app run"
    
    $rootScope.profilePic = null
    
    dataRef = new Firebase("https://2id26.firebaseio.com")
    $rootScope.loginObj = $firebaseSimpleLogin(dataRef)
    
    ref = new Firebase("https://2id26.firebaseio.com/users")
    users = new $firebase(ref)
    
    $rootScope.$on "$firebaseSimpleLogin:login",  (e, user) ->
      console.log "User " + user.id + ", " + user.displayName + " successfully logged in!"
      console.log user
    
      users.$update user.id, user
      
      $http.get "https://graph.facebook.com/"+user.id+"/picture?redirect=false"
      .success (data) ->
        $rootScope.profilePic = data.data.url

