module.exports = (grunt) ->
  #Load grunt tasks
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-nodemon'

  #Configure tasks
  grunt.initConfig
    nodemon:
      dev: 
        options:
          watch: ['!node_modules/**', '!public/**', '**/*.js','**/*.coffee']
          legacyWatch: true
          delay: 300
        script: 'main'

    less:
      dev:
        options:
          compress: false
          # paths: ['less', '<%= bowerDirectory %>/bootstrap/less']
        files: 'public/css/style.css' : 'public/less/style.less'
    
    watch:
      less:
        files: "public/less/*"
        tasks: ['less']

    concurrent:
      watch:
        tasks: ['watch:less', 'nodemon:dev']
        options:
          logConcurrentOutput: true

  grunt.registerTask 'develop', ['less','concurrent:watch']