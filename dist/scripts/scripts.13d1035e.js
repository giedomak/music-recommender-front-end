(function(){"use strict";angular.module("2Id26App",["ngAnimate","ngCookies","ngResource","ngRoute","ngSanitize","ngTouch","firebase","spotify"]).config(["$routeProvider","$httpProvider",function(a){return a.when("/",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/songs",{templateUrl:"views/songs.html",controller:"SongsCtrl"}).when("/song/:id",{templateUrl:"views/song.html",controller:"SongCtrl"}).when("/clusters",{templateUrl:"views/clusters.html",controller:"ClustersCtrl"}).when("/clusters/:id",{templateUrl:"views/cluster.html",controller:"ClusterCtrl"}).when("/about",{templateUrl:"views/about.html",controller:"AboutCtrl"}).otherwise({redirectTo:"/"})}]).config(["SpotifyProvider",function(a){return a.setClientId("4fe50f88a6314016a043c32a1d3bb422"),a.setRedirectUri("http://nasischijf.biersysteem.nl/callback.html"),a.setScope("user-library-read user-read-private playlist-read-private playlist-modify-private playlist-modify-public")}]).run(["Spotify","$window","$http","$firebase","$firebaseSimpleLogin","$rootScope",function(a,b,c,d,e,f){var g,h,i,j,k,l;return f.profilePic=null,f.api="http://localhost:8080",f.user=null,h=new Firebase("https://2id26.firebaseio.com"),f.loginObj=e(h),k=new Firebase("https://2id26.firebaseio.com/users"),l=new d(k).$asArray(),b.onmessage=function(a){return console.log("Spotify event binnen"),f.user.spotifytoken=a.data,i(a.data)},i=function(b){return console.log("getSpotify "+b),a.setAuthToken(b),c.get("https://api.spotify.com/v1/me",{headers:{Authorization:"Bearer "+b}}).success(function(a){return console.log("Token correct"),f.user.spotify=a}).error(function(){return console.log("Token invalid"),f.user.spotifytoken=null}),a.getSavedUserTracks({limit:50}).then(function(a){return console.log("UserLibrary"),console.log(a),f.user.spotifyUserLibrary=a}),a.getUserPlaylists(f.user.spotify.id,{limit:50}).then(function(a){return console.log("Playlists"),console.log(a),f.user.spotifyPlaylists=a})},f.$on("$firebaseSimpleLogin:login",function(a,b){var e;return console.log("User "+b.id+", "+b.displayName+" successfully logged in!"),console.log(b),k=new Firebase("https://2id26.firebaseio.com/users/"+b.id),e=d(k).$asObject(),e.$bindTo(f,"user").then(function(){return console.log(f.user),i(f.user.spotifytoken)}),l.$inst().$update(b.id,b),c.get("https://graph.facebook.com/"+b.id+"/picture?redirect=false").success(function(a){return f.profilePic=a.data.url})}),g="4fe50f88a6314016a043c32a1d3bb422",j="http:%2F%2Fnasischijf.biersysteem.nl/2id26"}])}).call(this),function(){"use strict";angular.module("2Id26App").controller("MainCtrl",["$http","Spotify","$routeParams","$rootScope","$scope",function(a,b,c,d,e){return console.log("main init"),d.curTab="home",e.spotifylogin=function(){return b.login()},d.recommend=function(){return d.clicked=!0,Array.prototype.unique=function(){var a,b,c,d,e,f;for(b={},a=d=0,e=this.length;e>=0?e>d:d>e;a=e>=0?++d:--d)b[this[a]]=this[a];f=[];for(a in b)c=b[a],f.push(c);return f},d.loading3=!0,a.get(d.api+"/spotify?token="+d.user.spotifytoken).success(function(b){var c,e,f,g,h;for(b.songIds.unique(),console.log(b),d.songs3=[],h=b.songIds,f=0,g=h.length;g>f;f++)e=h[f],c=e.toString(),console.log(e),a.get(d.api+"/song?id="+c).success(function(a){var b;return console.log("Song received"),console.log(a),b=d.songs3.filter(function(b){return b.id===a.id}),0===b.length&&a.id>=0?d.songs3.push(a):void 0});return d.loading3=!1})}}])}.call(this),function(){"use strict";angular.module("2Id26App").controller("AboutCtrl",["$rootScope","$scope",function(a,b){return a.curTab="about",b.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}])}.call(this),function(){"use strict";angular.module("2Id26App").controller("SongsCtrl",["$http","$rootScope","$scope",function(a,b,c){var d;return c.loading=!0,b.curTab="songs",a.get(b.api+"/songs").success(function(a){return console.log(a),c.songs=d(a),c.loading=!1}),d=function(a){var b,c,d;for(b=a.length;--b>0;)c=~~(Math.random()*(b+1)),d=a[c],a[c]=a[b],a[b]=d;return a}}])}.call(this),function(){"use strict";angular.module("2Id26App").controller("SongCtrl",["$routeParams","$http","$rootScope","$scope",function(a,b,c,d){return c.curTab="songs",d.loading=!0,d.id=parseInt(a.id),d.plutchik=function(a){switch(a){case 0:return"Not available";case 1:return"Joy";case 2:return"Sadness";case 3:return"Trust";case 4:return"Disgust";case 5:return"Fear";case 6:return"Anger";case 7:return"Surprise";case 8:return"Anticipation"}},d.polarity=function(a){switch(a){case-1:return"Negative";case 0:return"Neutral";case 1:return"Positive"}},b.get(c.api+"/song?id="+d.id).success(function(a){var e,f,g,h,i;for(console.log("Song received"),console.log(a),d.song=a,d.song.lyric_id?b.get(c.api+"/lyric?id="+d.song.lyric_id).success(function(a){return console.log("Lyric received"),console.log(a),d.lyric=a,d.loading=!1}):d.loading=!1,d.clusters=[],h=d.song.cluster_ids,i=[],f=0,g=h.length;g>f;f++)e=h[f],i.push(b.get(c.api+"/cluster?id="+e).success(function(a){return console.log("Cluster received"),console.log(a),d.clusters.push(a)}));return i})}])}.call(this),function(){"use strict";angular.module("2Id26App").controller("ClustersCtrl",["$http","$rootScope","$scope",function(a,b,c){var d;return c.loading=!0,b.curTab="clusters",a.get(b.api+"/clusters").success(function(a){return console.log(a),c.clusters=d(a),c.loading=!1}),d=function(a){var b,c,d;for(b=a.length;--b>0;)c=~~(Math.random()*(b+1)),d=a[c],a[c]=a[b],a[b]=d;return a}}])}.call(this),function(){"use strict";var a=[].indexOf||function(a){for(var b=0,c=this.length;c>b;b++)if(b in this&&this[b]===a)return b;return-1};angular.module("2Id26App").controller("ClusterCtrl",["$routeParams","$http","$rootScope","$scope",function(b,c,d,e){return d.curTab="clusters",e.loading=!0,e.id=parseInt(b.id),c.get(d.api+"/cluster?id="+e.id).success(function(b){return console.log(b),e.cluster=b,c.get(d.api+"/songs").success(function(b){var c;return console.log(b),c=b.filter(function(b){var c;return c=e.id,a.call(b.cluster_ids,c)>=0}),e.songs=c,e.loading=!1})})}])}.call(this);