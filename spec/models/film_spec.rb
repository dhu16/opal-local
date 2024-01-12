require 'rails_helper'

RSpec.describe Film, type: :model do
  fixtures :films

  it "can be created" do
    sample_film = films(:sample_film)

    expect(sample_film).to be_valid
  end

end
