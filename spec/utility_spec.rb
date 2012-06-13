require 'spec_helper'

describe Heron::Utility do
  
  describe "cleans up messy titles" do
    
    it('by setting prepositions to lower case') { Heron::Utility.make_proper_title('Examples Of Messy Titles').should include('of') }
    it('by always capitalizing the first word') do
      Heron::Utility.make_proper_title('examples Of Messy Titles').should include('Examples')
      Heron::Utility.make_proper_title('in the air').should include('In')
    end
    it('by removing excess whitespace') { Heron::Utility.make_proper_title(' Glee  ').length.should be(4) }
    
  end
  
end