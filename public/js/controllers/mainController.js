angular.module('pic')
  .controller('MainCtrl', ['$scope', '$http', function ($scope, $http) {

    var getCollections = function(){
      $http.get('/collections').success(function(res){
        $scope.collections = res;
      });
    }
    getCollections();

    var resetPostVars = function(){
      $scope.count = 0;
      $scope.start = 0;
      $scope.done = false;
      $scope.posts = [];
    }

    $scope.fetchPosts = function(id){
      $http.get('/collections/' + id).success(function(res){
        $scope.allPosts = res;
        resetPostVars();
        $scope.morePosts();
      });
    }

    $scope.morePosts = function(){
      for ($scope.count; $scope.count < $scope.allPosts.length; $scope.count++){
        if($scope.count != $scope.start && $scope.count % 18 == 0){
          $scope.start = $scope.count;
          break
        } else {
          $scope.posts.push($scope.allPosts[$scope.count]);
        }
      }
      if ($scope.count == $scope.allPosts.length){ $scope.done = true; }
    }
    $scope.selection = null;

    $scope.create = function(collection){
      $http.post('/collections', collection).success(function(res){
        $scope.allPosts = res;
        resetPostVars();
        $scope.morePosts();
      });
      getCollections();
    }

    $scope.expand = function(id){
      if($('#' + id).hasClass('col-xs-12')){ 
        $scope.posts[id].open = false;
        $('#' + id).removeClass('col-xs-12');
        $('#' + id).addClass('col-xs-2');
       } else{
        $('.cell').removeClass('col-xs-12');
        $('.cell').addClass('col-xs-2');
        $('#' + id).removeClass('col-xs-2');
        $('#' + id).addClass('col-xs-12');
        $scope.posts[id].open = true;
      }
    }

  }]);
