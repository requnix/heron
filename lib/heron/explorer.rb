require 'fileutils'

module Heron
  class Explorer
    
    def initialize(source_path = '.', destination_path = '~/Media')
      @source_path = source_path
      @destination_path = destination_path
    end
    
    def analyze
      eligible_files.
        collect { |file| Identifier.what_is?(file) }.
        group_by(&:show).each do |show, episodes|
          puts "+- #{show}"
          episodes.each { |episode| puts "   |- #{episode}" }
        end
    end
    
  protected
    
    # List all files in the folder recursively
    def all_files
      Dir[File.join(File.expand_path(@source_path || '.'),"**", "*")]
    end
    
    # Only process mkv files for now
    def eligible_files
      all_files.select { |file| file =~ /.*\.mkv$/ }
    end
  end
end
