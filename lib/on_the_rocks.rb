#require "on_the_rocks/version"

module OnTheRocks

  class Installer

    def initialize
      @sassdir = "app/assets/stylesheets/"
      @sasspath = "app/assets/stylesheets/application.css.scss"
      @base = "app/assets/stylesheets/base/_base.scss"
    end

    def bourbon_install
      `bourbon install` 
    end

    def truncate
      `mv app/assets/stylesheets/application.css #{@sasspath}` 
      File.truncate(@sasspath, 0)
    end

    def neat_install
      `neat install`
    end

    def bitters_install
      `cd #{@sassdir}`
      `bitters install`
    end

    def grid_remove
      grid = Regexp.escape("// @import 'grid_settings';")

      IO.write(@base,
        File.open(@base) do |file|
          file.read.gsub(/#{grid}/, "")
        end
      )
    end
    def write_imports
      `echo -e "@import\\ 'bourbon';\\n@import\\ 'base/grid_settings';\\n
      @import\\ 'neat';\\n@import\\ 'base/base';\\n\\n//\\ All\\ other\\ imports
      >>#{@sasspath}"`
    end
  end
end
