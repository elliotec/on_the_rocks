require "on_the_rocks/version"
require "fileutils"

module OnTheRocks
  class Generator
    def initialize(sassdir="app/assets/stylesheets/", oldcss="app/assets/stylesheets/application.css", mainsass="app/assets/stylesheets/application.css.scss")
      @sassdir = sassdir
      @oldcss= oldcss
      @mainsass = mainsass
      #@base = "app/assets/stylesheets/base/_base.scss"
    end

    def normalize
      unless File.exist?("normalize.css")
        FileUtils.cp_r(all_stylesheets, @sassdir)
      end
      puts "Normlalized."
    end

    def sassify
      if File.exist?('#{@oldcss}')
        FileUtils.mv '#{@oldcss}', '#{@mainsass}'
      end
    end

    def add_mainsass
      unless File.exist?('#{@mainsass}')
        FileUtils.touch '#{@mainsass}'
      end
      File.truncate(@mainsass, 0)
    end

    def install_files
      `bourbon_install`
      `neat install`
      `cd #{@sassdir} && bitters install`
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

    # def remove_gridsettings
    #   @grid = Regexp.escape("// @import 'grid_settings';")

    #   IO.write(@base, File.open(@base) { |file| file.read.gsub(/#{@grid}/, "") })
    # end

    def write_imports
      `echo "@import 'normalize';\n@import 'bourbon';\n@import 'base/grid_settings';\n@import 'neat';\n@import 'base/base';\n\n// All other imports">>#{@sasspath}`
    end
  end
end
