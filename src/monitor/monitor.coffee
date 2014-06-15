socket = io('http://localhost:9001')

app = angular.module "monitor", []
app.controller "main", ($scope) =>
  $scope.workers = []
  $scope.tasks = []
  $scope.completeTasks = 0;

  socket.on "monitor", (data) =>
    console.log data
    findWorker = (socket) =>
      $scope.workers.filter((w) => w.socket == socket)[0]

    $scope.$apply () =>
      if data.event=="workerAnnounced"
        $scope.workers.unshift({socket: data.socket, state: "idle"})
      else if data.event=="workerDisconnect"
        w = findWorker(data.socket)
        if w
          w.state = "disconected"
          w.task = null
          w.log = null
      else if data.event=="taskQueued"
        $scope.tasks.push(data)
      else if data.event=="taskPickedUp"
        worker = findWorker(data.socket)
        if !worker
          worker = {socket: data.socket}
          $scope.workers.unshift(worker)
        worker.state = "working"
        worker.task = data.task
      else if data.event=="taskLog"
        worker = findWorker(data.socket)
        if worker
          worker.log = data.message
      else if data.event=="taskDone"
        $scope.completeTasks = $scope.completeTasks+1;
        worker = findWorker(data.socket)
        if !worker
          worker = {socket: data.socket}
          $scope.workers.unshift(worker)
          worker.state = "idle"
          worker.task = data.task






#socket.on "monitor", (data) =>  console.log(data)
window.socket = socket