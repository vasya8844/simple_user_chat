require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @user = FactoryGirl.create(:user)
    @to_user = FactoryGirl.create(:user, {name: 'User Two'})
  end

  describe "Creation" do
  	before do
  		@message = FactoryGirl.create :message, {user: @user, to_user_id: @to_user.id}
  	end

  	it 'can be created' do	
  		expect(@message).to be_valid
  	end

  	it 'cannot be created without a body' do
  		@message.body = nil
  		expect(@message).to_not be_valid
  	end
  end

  describe 'get_conversation' do
    before do
      2.times do 
        FactoryGirl.create :message, {user: @user, to_user_id: @to_user.id}
      end
      3.times do 
        FactoryGirl.create :message, {user: @to_user, to_user_id: @user.id}
      end
    end

    it 'return return all messages' do
      expect(Message.get_conversation(@user, @to_user, 0).size).to eq(5)
    end

    it 'return update is_read depend on user' do
      expect(Message.where(is_read: true).count).to eq(0)
      Message.get_conversation(@user, @to_user, 0)
      expect(Message.where(is_read: true).count).to eq(3)
    end
  end
end