define "FarmOutTask", (require, exports, module) =>
  class FarmOutTask
    @name= "FarmOutTask"
    @description= "yeah"
    execute : (@taskRunner, done) =>
      spawnTask = (num) =>
        @taskRunner.log("Spawning add task for args #{num} and #{num+1}")
        @taskRunner.queue("AddTask", num, num+1)
        if num!=100
          setTimeout((()=>spawnTask(num+1)), 1000)
        else
          done()
      spawnTask(0)

  module.exports = FarmOutTask