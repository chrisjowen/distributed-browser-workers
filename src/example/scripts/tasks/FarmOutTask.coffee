define "FarmOutTask", (require, exports, module) =>
  class FarmOutTask
    @name= "FarmOutTask"
    @description= "yeah"
    execute : (@taskRunner, done, args) =>
      num = parseInt(args[0])
      @taskRunner.log("Spawning add task for args #{num} and #{num+1}")

      spawnTask = (num) =>
        @taskRunner.queue("AddTask", num, num+1)
        if num!=100
          @taskRunner.queue("FarmOutTask", num+1)

        done()

      setTimeout((() => spawnTask(num)), 1000)

  module.exports = FarmOutTask