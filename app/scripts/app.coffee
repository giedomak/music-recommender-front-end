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
    'gianarb.deezer'
  ])
  .config ($routeProvider, $httpProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/songs',
        templateUrl: 'views/songs.html'
        controller: 'SongsCtrl'
      .when '/song/:id',
        templateUrl: 'views/song.html'
        controller: 'SongCtrl'
      .when '/clusters',
        templateUrl: 'views/clusters.html'
        controller: 'ClustersCtrl'
      .when '/clusters/:id',
        templateUrl: 'views/cluster.html'
        controller: 'ClusterCtrl'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
      .otherwise
        redirectTo: '/'
  .config (SpotifyProvider, $deezerProvider) ->
    SpotifyProvider.setClientId('4fe50f88a6314016a043c32a1d3bb422')
    SpotifyProvider.setRedirectUri('http://nasischijf.biersysteem.nl/callback.html')
    SpotifyProvider.setScope('user-library-read user-read-private playlist-read-private')
    # Init provider configuration
    $deezerProvider.setChannelUrl("http://bestmusicfor.me/data/channel.html")
    $deezerProvider.setAppId("145691")
  .run (Spotify, $window, $http, $firebase, $firebaseSimpleLogin, $rootScope) ->
    $rootScope.profilePic = null
    $rootScope.api = "http://178.62.207.179:8080"
#    $rootScope.api = "http://localhost:8080"
    $rootScope.user = null
    
    dataRef = new Firebase("https://2id26.firebaseio.com")
    $rootScope.loginObj = $firebaseSimpleLogin(dataRef)
    
    ref = new Firebase("https://2id26.firebaseio.com/users")
    users = new $firebase(ref).$asArray()
    
    $window.onmessage = (e) ->
      # Token from spotify
      console.log "Spotify event binnen"
      $rootScope.user.spotifytoken = e.data
      getSpotify e.data
          
    getSpotify = (token) ->
      console.log "getSpotify " + token
      Spotify.setAuthToken token
      $http.get "https://api.spotify.com/v1/me", headers: {'Authorization': 'Bearer ' + token}
        .success (e) ->
          console.log "Token correct"
          $rootScope.user.spotify = e
        .error (e) ->
          console.log "Token invalid"
          $rootScope.user.spotifytoken = null
      Spotify.getSavedUserTracks({limit: 50})
        .then (data) ->
          console.log "UserLibrary"
          console.log data
          $rootScope.user.spotifyUserLibrary = data
      Spotify.getUserPlaylists $rootScope.user.spotify.id, {limit: 50}
        .then (data) ->
          console.log "Playlists"
          console.log data
          $rootScope.user.spotifyPlaylists = data
          
    
    $rootScope.$on "$firebaseSimpleLogin:login",  (e, user) ->
      console.log "User " + user.id + ", " + user.displayName + " successfully logged in!"
      console.log user
      
      ref = new Firebase("https://2id26.firebaseio.com/users/" + user.id)
      obj = $firebase(ref).$asObject()

      obj.$bindTo($rootScope, "user").then () ->
        console.log $rootScope.user
        getSpotify $rootScope.user.spotifytoken
    
      users.$inst().$update user.id, user
      
      $http.get "https://graph.facebook.com/"+user.id+"/picture?redirect=false"
      .success (data) ->
        $rootScope.profilePic = data.data.url
      
    client_id = "4fe50f88a6314016a043c32a1d3bb422"
    redirect_uri = "http:%2F%2Fnasischijf.biersysteem.nl/2id26"
#    $http.get "https://accounts.spotify.com/authorize?client_id=" + client_id + "&response_type=token&redirect_uri=" + redirect_uri

        
    

