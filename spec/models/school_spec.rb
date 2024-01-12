require 'rails_helper'

RSpec.describe School, type: :model do
  fixtures :schools
  
  describe 'School' do
    it 'populates schools table' do
      # Load the fixtures
  
      # Now, you can check if the schools table is populated
      expect(School.count).to be > 0
  
      # Access fixture data
      columbia = schools(:columbia)
      expect(columbia.name).to eq 'Columbia University in the City of New York'
  
      # Add more assertions as needed
    end
  end
end
