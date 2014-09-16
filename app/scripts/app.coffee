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
    'firebase',
    'spotify',
    'ngPostMessage'
  ])
  .config ($routeProvider, $httpProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
      .when '/:params',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .otherwise
        redirectTo: '/'
  .config (SpotifyProvider) ->
    SpotifyProvider.setClientId('4fe50f88a6314016a043c32a1d3bb422')
    SpotifyProvider.setRedirectUri('http://nasischijf.biersysteem.nl/callback.html')
    SpotifyProvider.setScope('user-read-private playlist-read-private playlist-modify-private playlist-modify-public')
  .run ($window, $http, $firebase, $firebaseSimpleLogin, $rootScope) ->
    console.log "app run"
    
    $rootScope.$root.$on '$messageIncoming', (event, data) ->
      console.log angular.fromJson(data)
    
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
      
    client_id = "4fe50f88a6314016a043c32a1d3bb422"
    redirect_uri = "http:%2F%2Fnasischijf.biersysteem.nl/2id26"
#    $http.get "https://accounts.spotify.com/authorize?client_id=" + client_id + "&response_type=token&redirect_uri=" + redirect_uri
        
    

