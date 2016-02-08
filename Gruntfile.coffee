module.exports = (grunt) ->
  #Load grunt tasks
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
