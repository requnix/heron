module Heron
  class Utility
    def self.make_proper_title(messy_title)
      new_title = []
      messy_title.downcase.split(' ').each_with_index do |word, index|
        if index > 0 && %w(of the in on to and is a an).include?(word)
          new_title << word
        else
          new_title << "#{ word[0].upcase }#{ word.slice(1, word.length) }"
        end
      end
      new_title.join(' ')
    end
  end
end
