require "on_the_rocks/version"
require "fileutils"

module OnTheRocks
  class Generator
    def initialize(arguments)
      @subcommand = arguments.first
      @sassdir = "app/assets/stylesheets/"
      @oldcss= "app/assets/stylesheets/application.css"
      @mainsass = "app/assets/stylesheets/application.css.scss"
    end

    def run
      if @subcommand == "install"
        install
      end
    end

    def install
      normalize
      sassify
      install_files
      declare_imports
    end

    def normalize
      unless File.exist?("#{@sassdir}normalize.css")
        FileUtils.cp_r(all_stylesheets, @sassdir)
      end
      puts "Normlalized."
    end

    def sassify
      if File.exist?(@oldcss) && ! File.exist?(@mainsass)
        FileUtils.cp(@oldcss, "#{@oldcss}.old")
        FileUtils.mv(@oldcss, @mainsass)
        puts "Renamed old css file."
      else
        FileUtils.touch(@mainsass)
        puts "Created main Sass file."
      end
    end

    def install_files
      `bourbon install`
      `neat install`
      FileUtils.cd(@sassdir)
      `bitters install`
      puts "Installed Bourbon, Neat, and Bitters files."
    end

    def all_stylesheets
      Dir["#{stylesheets_directory}/*"]
    end

    def stylesheets_directory
      File.join(top_level_directory, "app", "assets", "stylesheets")
    end

    def top_level_directory
      File.dirname(File.dirname(File.dirname(__FILE__)))
    end

    def declare_imports
      File.truncate(@mainsass, 0)
      `echo "@import 'normalize';\n@import 'bourbon';\n@import 'base/grid_settings';\n@import 'neat';\n@import 'base/base';\n\n// All other imports">>#{@mainsass}`
      puts "Declared imports."
    end
  end
end
