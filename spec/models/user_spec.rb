require 'rails_helper'

class HashStub2 
    def hashes
      [{
      email: "user1@columbia.edu",
      password: "password",
      },
      {
      email: "user2@columbia.edu",
      password: "password",
      }]
    end
end

RSpec.describe User, type: :model do
    fixtures :users, :schools
  
    it "can be created" do
        user1 = users(:user1)
        user2 = users(:user2)
        user1.school = schools(:columbia)
        user2.school = schools(:columbia)
    
        expect(user1).to be_valid
        expect(user2).to be_valid
    end

    it "has existing email" do 
        email = "user1@columbia.edu"
        table = HashStub2.new
        users = User.from_table(table)
        user1 = users.find {|f| f[:email] == email }
        expect(User.with_email(email).email).to eq user1[:email]
    end
  
end