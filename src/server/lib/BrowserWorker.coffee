class BrowserWorker
  constructor: (id, socket, rootSocket) ->
    @socket = socket
    @id = id
    @state = "idle"
    socket.on "picked_up", @pickedUp
    socket.on "done", @done
  run: (func, args) =>
    @socket.emit "run", { func: func, args: args}
  working: () =>
    @state = "working"
  done: () =>
    @state = "idle"
  pickedUp: () =>
    @state = "picked_up"
  isIdle: () =>
    @state == "idle"

module.exports = BrowserWorker
