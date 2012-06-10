require 'fileutils'
require 'heron/episode'
require 'heron/utility'

module Heron
  class Identifier
    
    # Known tokens either occur as-is, downcased or uppercased. The keys of
    # hashes indicate the prefered format.
    KNOWN_TOKENS = {
      video: {
        'x264' => ['h.264', 'h264', 'x264']
      },
      audio: ['dd5.1', 'aac2.0', 'dts'],
      quality: ['720p', '1080p', '1080i'],
      source: {
        'WEB-DL' => ['web-dl', 'web dl'],
        'HDTV' => ['hdtv'],
        'BluRay' => ['bluray', 'brrip', 'bdrip']
      }
    }
    
    def self.what_is?(file_in_question)
      case File.basename(file_in_question)
      when /s(\d{2})e(\d{2})/i
        match_data = Regexp.last_match
        # Create an Episode object to store what we know about the episode
        episode = Episode.new
        episode.path = file_in_question
        
        # Split on this since we know it's there already
        episode.season = match_data[1].to_i
        episode.episode = match_data[2].to_i
        title_segment = match_data.pre_match.downcase
        details_segment = match_data.post_match.downcase
        
        # Store the extension
        episode.extension = File.basename(file_in_question).slice(-3, 3)
        
        # Work out the show
        title_segment.gsub!(/\(?\[?(\d{4})\)?\]?/, ' ')
        year = $1.to_i
        episode.year = year if year > 1900
        
        title_segment.gsub!(/[\(\[\.\s](uk|us)[\)\]\.\s]/i, ' ')
        country = $1
        episode.country = country.upcase if country
        
        episode.show = Utility.make_proper_title(title_segment.gsub('.', ' ').strip)
        
        # See if we can get a title
        possible_title_length = known_token_occurences.collect { |token| details_segment.downcase.index(token) }.compact.min
        possible_title = details_segment.slice(0, possible_title_length).gsub(".", " ").strip
        episode.title = Utility.make_proper_title(possible_title) if possible_title.length > 0
        details_segment = details_segment.slice(possible_title_length, details_segment.length)
        
        # Tags with info about the file
        episode.source = identify_source(details_segment)
        episode.quality = identify_quality(details_segment)
        episode.video = identify_video(details_segment)
        episode.audio = identify_audio(details_segment)
        
        # Time to get tricky to identify the group
        potential_group = File.basename(file_in_question, ".#{episode.extension}").split(/[-\s\.]/).last
        
        episode.group = potential_group unless known_token_occurences.include?(potential_group.downcase)
        original_file_lowercase = File.basename(file_in_question) === File.basename(file_in_question).downcase
        episode.group = episode.group.upcase if original_file_lowercase
        
        return episode
        
      end
    end
    
    def self.identify_source(details)
      KNOWN_TOKENS[:source].each do |preferred, potentials|
        potentials.each do |potential|
          index = details.downcase.index(potential)
          return preferred if index and index >= 0
        end
      end
      nil
    end
    
    def self.identify_quality(details)
      KNOWN_TOKENS[:quality].each do |token|
        return token if details.downcase.index(token) >= 0
      end
      nil
    end
    
    def self.identify_video(details)
      KNOWN_TOKENS[:video].each do |preferred, potentials|
        potentials.each do |potential|
          index = details.downcase.index(potential)
          return preferred if index and index >= 0
        end
      end
      nil
    end
    
    def self.identify_audio(details)
      tracks = []
      KNOWN_TOKENS[:audio].each do |token|
        index = details.downcase.index(token)
        tracks << token.upcase if index and index >= 0
      end
      tracks.length > 0 ? tracks : nil
    end
    
    def self.known_token_occurences
      (KNOWN_TOKENS[:audio] + KNOWN_TOKENS[:quality] +
      KNOWN_TOKENS[:source].values + KNOWN_TOKENS[:video].values).flatten
    end
    
  end
end
