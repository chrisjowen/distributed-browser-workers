'use strict';
module.exports = function (grunt) {
    // Project configuration.
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-exec');
    grunt.loadNpmTasks('grunt-concurrent');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-mocha');

    grunt.initConfig({

        concurrent: {
            webAndWorker: {
                tasks: [ 'exec:master','connect:web', 'watch'],
                options: {
                    logConcurrentOutput : true,
                    limit: 6
                }
            }
        },
        coffee: {
            web: {
                files: {
                    '.tmp/web/js/bQueue.client.js': ['src/client/*.coffee'],
                    '.tmp/web/js/example.js': ['src/example/app.coffee','src/example/**/*.coffee'],
                    '.tmp/web/js/monitor.js': ['src/monitor/monitor.coffee']
                }
            },
            test: {
                expand: true,
                cwd: 'test',
                src: ['*.coffee', '**/*.coffee'],
                dest: '.tmp',
                ext: '.js'
            }
        },
        connect: {
            web: {
                options: {
                    port: 9000,
                    base: '.tmp/web',
                    keepalive: true
                }
            }
        },
        watch: {
            coffee: {
                files: ['src/monitor/monitor.coffee','src/client/*.coffee', 'src/example/scripts/*.coffee', 'src/example/scripts/**/*.coffee'],
                tasks: ['coffee:web']
            },
            html: {
                files: ['src/monitor/*.html', 'src/example/*.html'],
                tasks: ['copy']
            }

        },
        exec: {
            master: {
                command: 'coffee src/server/app.coffee'
            }
        },
        mocha: {
            test: {
                src: ['tests/**/*.html']
            }
        },
        copy: {
            example : {
                files: [
                    {expand: true, cwd: "src/example/", src: ['*.html'], dest: '.tmp/web/', filter: 'isFile', force: true},
                    {expand: true, cwd: "src/monitor/", src: ['*.html'], dest: '.tmp/web/', filter: 'isFile', force: true},
                    {expand: true, src: ['bower_components/**/**/**/*.*'], dest: '.tmp/web/'}
                    ]
            }

        }
    });

    grunt.registerTask('default', [
        'copy:example',
        'coffee',
        'concurrent'
    ]);

    grunt.registerTask('test', [
        'coffee:test'
    ]);


};