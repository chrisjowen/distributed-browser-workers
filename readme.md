Use the browser as a distributed worker :)
-------------------------------------------

This is just a hacky play project to see if I could use socket.io to push jobs to various browsers to independently process some work.

Running it
----------------------

- npm install & bower install
- grunt

Starting a worker
- visit: http://localhost:9000. Here you can kick off a task that will queue up another 100 tasks (1 per second) to add 2 numbers together

Monitoring
- visit: http://localhost:9000/monitor.html. See whats happening :)


![idle](https://raw.githubusercontent.com/chrisjowen/distributed-browser-workers/master/src/example/img/idle.png)
![connecting](https://raw.githubusercontent.com/chrisjowen/distributed-browser-workers/master/src/example/img/connectedb.png)
![disconnected](https://raw.githubusercontent.com/chrisjowen/distributed-browser-workers/master/src/example/img/disconnected.png)


Testing it
------------

Come on!!! This is a mess about project :)
