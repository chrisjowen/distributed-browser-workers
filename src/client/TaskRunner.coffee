define "TaskRunner", (require, exports, module) =>
  class TaskRunner
    constructor: (@socket) ->
      @tasks = {}
      @latest_task = null

    start: () =>
      @socket.emit "announce"
      @socket.on "run", (data) =>  @run(data.func, data.args)

    run: (task, args) =>
      try
        @latest_task = task
        @working()
        don = () => @done()
        new @tasks[task](@).execute(@, don,  args);
        @socket.emit "monitor", {event: "taskStarted", socket:@socket.id, task}
      catch err
        console.warn(err)
        @done(err)

    registerTask: (task) =>
      @tasks[task.name] = task

    done: (er) =>
      @socket.emit "done", {task: @latest_task, er: er}
      @latest_task = null

    working: () =>
      @socket.emit "pickedUp", {task: @latest_task}

    queue: (task, args...) =>
      @socket.emit "queue", {task,args}

    log: (message) =>
      @socket.emit "log", { task: @latest_task, message: message}

  module.exports = TaskRunner

