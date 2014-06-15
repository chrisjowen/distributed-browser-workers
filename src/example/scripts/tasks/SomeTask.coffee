define "SomeTask", (require, exports, module) =>
  class SomeTask
    @name= "Some"
    @description= "yeah"
    execute : (@taskRunner, done) =>
      for num in [0..100]
        @taskRunner.queue("SomeOtherTask", num, num+1)
      done()


  module.exports = SomeTask