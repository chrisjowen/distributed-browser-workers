define "SomeOtherTask", (require, exports, module) =>
  class SomeOtherTask
    @name= "SomeOther"
    @description= "yeah"
    execute : (@taskRunner, done, args) =>
      queueUpSomeTasks = () =>
        @taskRunner.log("Got result #{parseInt(args[0])+parseInt(args[1])}")
        done()
      @taskRunner.log("Peforming long running task to add #{args[0]} and #{args[1]}")
      setTimeout(queueUpSomeTasks, 5000)


  module.exports = SomeOtherTask