angular.module('pic')
  .controller('MainCtrl', ['$scope', '$http', function ($scope, $http) {

    $scope.test = 'test';

    $http.get('/collections').success(function(res){
      $scope.res = res;
      console.log(res);
    });

  }]);
