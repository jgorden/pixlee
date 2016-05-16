angular.module('pic')
  .filter("media", ['$sce', function($sce) {
    return function(link){
      if (link.includes('.jpg')){ tag = "<img ng-src='" + link + "' class='center-block' " + "src='" + link +  "'>" }
      else if(link.includes('.mp4')){ 
        tag = "<video width='640' height='480' controls class='center-block'><source src=" + link + " type='video/mp4'></video>"
      }
      return $sce.trustAsHtml(tag);
    }
  }]);