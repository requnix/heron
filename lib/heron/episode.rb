module Heron
  class Episode
    
    attr_accessor :path, :show, :country, :year, :season, :episode, :title,
                  :quality, :source, :video, :audio, :group, :extension
    
    def to_s
      output = ""
      output << @show
      output << " (#{@country})" if @country
      output << " (#{@year})" if @year
      output << " [#{'%02i' % @season}x#{'%02i' % @episode}]"
      output << " #{@title}" if @title
      output << " -" if @quality or @source or @video or @audio
      output << " #{@quality}" if @quality
      output << " #{@source}" if @source
      output << " #{@video}" if @video
      output << " #{@audio.join(' ')}" if @audio
      output << " - #{@group}" if @group
      output << ".#{@extension}"
      output
    end
    
  end
end
