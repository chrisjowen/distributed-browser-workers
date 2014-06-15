WorkerPool = require './lib/WorkerPool'

handler = (req, res) ->
app = require("http").createServer(handler)
io = require("socket.io")(app)
fs = require("fs")
app.listen 9001

new WorkerPool(io)