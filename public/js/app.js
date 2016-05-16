angular.module('pic', [
    'ngRoute',
    'ui.bootstrap',
    'ngAnimate',
    'ngSanitize'
  ])
  .config(function ($routeProvider, $compileProvider) {
    $compileProvider.debugInfoEnabled(false);
    
    $routeProvider
      .when('/', {
        templateUrl: '../index.html',
        controller: 'MainCtrl',
        controllerAs: 'main'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
