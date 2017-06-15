require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "Creation" do
  	before do
  		@message = FactoryGirl.create :message, {user: FactoryGirl.create(:user)}
  	end

  	it 'can be created' do	
  		expect(@message).to be_valid
  	end

  	it 'cannot be created without a body' do
  		@message.body = nil
  		expect(@message).to_not be_valid
  	end
  end
end