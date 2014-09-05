require "on_the_rocks/version"
require "open-uri"
require "fileutils"

module OnTheRocks

  class Installer

    def initialize
      @sassdir = "app/assets/stylesheets/"
      @oldcss= "app/assets/stylesheets/application.css"
      @sasspath = "app/assets/stylesheets/application.css.scss"
      @base = "app/assets/stylesheets/base/_base.scss"
    end

    def sassify
      if File.exist?('#{@oldcss}')
        `mv #{@oldcss} #{@sasspath}`
      end
      File.truncate(@sasspath, 0)
    end

    def neat_bitters
      `neat install`
      `cd app/assets/stylesheets/ && bitters install`
    end

    def remove_gridsettings
      @grid = Regexp.escape("// @import 'grid_settings';")

      IO.write(@base, File.open(@base) { |file| file.read.gsub(/#{@grid}/, "") })
    end

    def write_imports
      `echo "@import 'bourbon';\n@import 'base/grid_settings';\n@import 'neat';\n@import 'base/base';\n\n// All other imports">>#{@sasspath}`
    end
  end
end
