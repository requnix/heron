require 'spec_helper'

describe Heron::Identifier do
  
  describe "detects episodes" do
    ultimate_spiderman = 'Ultimate Spiderman.S01E01.Great.Power.720p.WEB-DL.DD5.1.H264.mkv'
    
    it('and returns a Heron::Episode') { Heron::Identifier.what_is?(ultimate_spiderman).should be_a(Heron::Episode) }
    it('and identifies the show title') { Heron::Identifier.what_is?(ultimate_spiderman).show.should eq('Ultimate Spiderman') }
    it('and identifies the season') { Heron::Identifier.what_is?(ultimate_spiderman).season.should eq(1) }
    it('and identified the episode number') { Heron::Identifier.what_is?(ultimate_spiderman).episode.should eq(1) }
    it('and identifies the title if present') { Heron::Identifier.what_is?(ultimate_spiderman).title.should eq('Great Power') }
    it('and identifies the quality') { Heron::Identifier.what_is?(ultimate_spiderman).quality.should eq('720p') }
    it('and identifies the source') { Heron::Identifier.what_is?(ultimate_spiderman).source.should eq('WEB-DL') }
    it('and ifentifies the video codec') { Heron::Identifier.what_is?(ultimate_spiderman).video.should eq('x264') }
    it('and identifies the audio codecs') { Heron::Identifier.what_is?(ultimate_spiderman).audio.should eq(['DD5.1']) }
    it('and identifies the file extension') { Heron::Identifier.what_is?(ultimate_spiderman).extension.should eq('mkv') }
    
    the_voice_uk = 'the.voice.uk.s01e09.720p.hdtv.x264-c4tv.mkv'
    it('and identifies the country if present') { Heron::Identifier.what_is?(the_voice_uk).country.should eq('UK') }
    
    thundercats = 'Thundercats.2011.S01E24.720p.WEB-DL.AAC2.0.H264-Reaperza.mkv'
    it('and identifies the year if present') { Heron::Identifier.what_is?(thundercats).year.should eq(2011) }
    it('and identifies the release group if present') { Heron::Identifier.what_is?(thundercats).group.should eq('Reaperza') }
    
  end
  
end