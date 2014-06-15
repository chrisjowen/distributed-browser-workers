require ["TaskRunner", "AddTask", "FarmOutTask"], (TaskRunner, AddTask, FarmOutTask) =>
  socket = io('http://localhost:9001')
  tr = new TaskRunner(socket)
  tr.registerTask(AddTask)
  tr.registerTask(FarmOutTask)
  tr.start()
  window.tr = tr
