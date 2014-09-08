require "on_the_rocks/version"
require "fileutils"

module OnTheRocks
  class Generator
    def initialize
      @sassdir = "app/assets/stylesheets/"
      @oldcss= "app/assets/stylesheets/application.css"
      @mainsass = "app/assets/stylesheets/application.css.scss"
    end

    def start
      install
    end

    def install
      normalize
      install_files
      sassify
    end

    def normalize
      if File.exist?("#{@sassdir}normalize.css")
        FileUtils.mv("#{@sassdir}normalize.css", "#{@sassdir}normalize.css.old")
      end
      FileUtils.cp_r(all_stylesheets, @sassdir)
      puts "Normlalized."
    end

    def install_files
      FileUtils.cd(@sassdir) do
        `bourbon install`
        `neat install`
        `bitters install`
      end
      puts "Installed Bourbon, Neat, and Bitters files."
    end

    def sassify
      rename_oldcss
      new_mainsass
      File.truncate(@mainsass, 0)
      imports  
    end

    def rename_oldcss
      if File.exist?(@oldcss) && File.exist?(@mainsass) == false
        FileUtils.cp(@oldcss, "#{@oldcss}.old")
        FileUtils.mv(@oldcss, @mainsass)
        puts "Renamed old css file."
      end
    end

    def new_mainsass
      unless File.exist?(@mainsass)
        FileUtils.mkdir_p(@sassdir)
        FileUtils.touch(@mainsass)
        puts "Created main Sass file."
      end
    end

    def imports
      `echo "@import 'normalize';\n@import 'bourbon';\n@import 'base/grid_settings';\n@import 'neat';\n@import 'base/base';\n\n// All other imports">>#{@mainsass}`
      puts "Imported imports."
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
  end
end
