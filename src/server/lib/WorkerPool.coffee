BrowserWorker = require "./BrowserWorker"

class WorkerPool
  constructor: (io) ->
    @workers = []
    io.on "connection", (socket) =>
      @socket = socket
      @socket.on "monitor", (data) =>
        io.emit "monitor", data
      @socket.on "announce",  () =>
        io.emit "monitor", {event: "workerAnnounced", socket: socket.id}
        @workers.push(new BrowserWorker(socket.id, socket, io))
      @socket.on "disconnect", () =>
        io.emit "monitor", {event: "workerDisconnect", socket: socket.id}
        @removeWorker(socket)
      @socket.on "pickedUp", (data) =>
        worker = @getWorker(socket)
        worker.pickedUp() if worker
        io.emit "monitor", {event: "taskPickedUp", task: data.task, socket: socket.id}
      @socket.on "done", (data) =>
        worker = @getWorker(socket)
        worker.done() if worker
        io.emit "monitor", {event: "taskDone", task: data.task, socket: socket.id}
      @socket.on "log", (data) =>
        io.emit "monitor", {event: "taskLog", task: data.task, message: data.message, socket: socket.id}
      @socket.on "queue", (data) =>
        @queueTask(data.task, data.args)
        io.emit "monitor", {event : "taskQueued", task: data.task, args: data.args}

  queueTask: (task, args) =>
    @getNextIdleWorker (worker) =>
      worker.run(task, args)

  getWorker: (socket) =>
    workers = @workers.filter((w) => w.socket.id == socket.id)
    if workers.length ==1
      workers[0]

  getNextIdleWorker: (workerFound) =>
      workers = @workers.filter((w) => w.isIdle())
      if workers.length > 0
        worker = workers[0]
        worker.working()
        workerFound(workers[0])
      else
        setTimeout((() => @getNextIdleWorker(workerFound)), 10000)

  removeWorker: (socket) =>
    worker = @getWorker(socket)
    index = @workers.indexOf(worker)
    @workers.splice(index,1) if index > -1


module.exports = WorkerPool