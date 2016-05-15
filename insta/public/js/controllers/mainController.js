angular.module('pic')
  .controller('MainCtrl', ['$scope', '$http', function ($scope, $http) {

    $scope.test = 'test';

    $http.get('/collections').success(function(res){
      $scope.collections = res;
      console.log(res);

    });

    $scope.fetchPosts = function(id){
      $http.get('/collections/' + id).success(function(res){
        $scope.posts = res;
      })
    }
    $scope.selection = null;

    $scope.create = function(collection){
      $http.post('/collections', collection).success(function(res){
        $scope.posts = res;
        console.log(res);
      });
    };


  }]);
