app = angular.module('example', ['ngRoute'])


require ["TaskRunner", "SomeTask", "SomeOtherTask"], (TaskRunner, SomeTask, SomeOtherTask) =>
  socket = io('http://localhost:9001')
  tr = new TaskRunner(socket)
  tr.registerTask(SomeTask)
  tr.registerTask(SomeOtherTask)
  tr.start()
  window.tr = tr

#
#  app.controller "MainController", ($scope) ->
#    $scope.tasks = []
#    alert("here")
#
#  app.config ($routeProvider) ->
#    $routeProvider.when "/",
#      templateUrl: "/main.html",
#      controller: "MainController"

