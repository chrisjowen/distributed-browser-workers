socket = io('http://localhost:9001')

app = angular.module "monitor", []
app.controller "main", ($scope) =>
  $scope.workers = []
  $scope.tasks = []
  $scope.completeTasks = 0;

  class MainController
    constructor: ->
      socket.on "monitor", (data) =>
        console.log data
        $scope.$apply () =>
          @[data.event](data) unless  @[data.event] == undefined
        $(".state_disconected").fadeOut('slow') #<--- I KOW BUT DONT CARE!!!!
        $(".state_").hide()
        $(".state_working,.state_idle").show()

    workerAnnounced: (data) =>
      $scope.workers.unshift({socket: data.socket, state: "idle"})

    workerDisconnect: (data) =>
        w = @findWorker(data.socket)
        if w
          w.state = "disconected"
          w.task = null
          w.log = null

    taskQueued : (data) =>
        $scope.tasks.push(data)

    taskPickedUp : (data) =>
        worker = @findWorker(data.socket)
        if !worker
          worker = {socket: data.socket}
          $scope.workers.unshift(worker)
        worker.state = "working"
        worker.task = data.task

    taskLog: (data) =>
        worker = @findWorker(data.socket)
        if worker
          worker.log = data.message

    taskDone: (data) =>
        $scope.completeTasks = $scope.completeTasks+1;
        worker = @findWorker(data.socket)
        if !worker
          worker = {socket: data.socket}
        worker.state = "idle"
        worker.task = null
        worker.log = null

    findWorker : (socket) =>
      worker = $scope.workers.filter((w) => w.socket == socket)[0]
      $scope.workers.unshift({socket: socket}) if not worker
      worker

  new MainController()