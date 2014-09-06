require "on_the_rocks/version"
require "fileutils"
require "thor"

module OnTheRocks
  class Generator < Thor

    def initialize(sassdir="app/assets/stylesheets/", oldcss="app/assets/stylesheets/application.css", mainsass="app/assets/stylesheets/application.css.scss")
      @sassdir = sassdir
      @oldcss= oldcss
      @mainsass = mainsass
      #@base = "app/assets/stylesheets/base/_base.scss"
    end

    def normalize
      FileUtils.install "*/normalize.css", "#{@sassdir}normalize.css"
    end

    def sassify
      if File.exist?('#{@oldcss}')
        FileUtils.mv '#{@oldcss}', '#{@mainsass}'
      end

      unless File.exist?('#{@mainsass}')
        FileUtils.mkdir_p '#{@sassdir}'
        FileUtils.touch '#{@mainsass}'
      end

      File.truncate(@mainsass, 0)
    end

    def install_files
      `bourbon_install`
      `neat install`
      `cd #{@sassdir} && bitters install`
    end

    # def remove_gridsettings
    #   @grid = Regexp.escape("// @import 'grid_settings';")

    #   IO.write(@base, File.open(@base) { |file| file.read.gsub(/#{@grid}/, "") })
    # end

    def write_imports
      `echo "@import 'bourbon';\n@import 'base/grid_settings';\n@import 'neat';\n@import 'base/base';\n\n// All other imports">>#{@sasspath}`
    end
  end
end
