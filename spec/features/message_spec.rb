require 'rails_helper'

describe 'navigate' do
  before do
    @user = FactoryGirl.create :user
    login_as(@user, :scope => :user)
    @to_user = FactoryGirl.create(:user, {name: 'User Two'})
  end

  describe 'index' do
    before do
      visit new_message_path(to_user_id: @to_user.id)
    end

  	it 'can be reached successfully' do
  		expect(page.status_code).to eq(200)
  	end

  	it 'has a title of message' do
  		expect(page).to have_content(/Переписка з/)
  	end

    it 'has a message list' do
      message1 = FactoryGirl.create :message, user: @to_user, to_user_id: @user.id
      message2 = FactoryGirl.create :message, body: 'mesasge two', 
        user: @user, to_user_id: @to_user.id
      visit new_message_path(to_user_id: @to_user.id)
      expect(page).to have_content(/mesasge one|mesasge two/)
    end
  end

  describe 'creation' do
  	before do
      visit new_message_path(to_user_id: @to_user.id)
  	end

  	it 'has a new form that can be reached' do
  		expect(page.status_code).to eq(200)
  	end

  	it 'can be created from new form page' do
      fill_in 'message[body]', with: 'hello my friend'
      click_on 'say'
      visit new_message_path(to_user_id: @to_user.id)
      expect(page).to have_content('hello my friend')
  	end

    it 'will have a user associated it' do
      fill_in 'message[body]', with: 'aloha'
      click_on "say"
      expect(@user.messages.last.body).to eq('aloha')
    end
  end

  describe 'top menu message count' do
    before do
      2.times do 
        FactoryGirl.create :message, user: @to_user, to_user_id: @user.id
      end
      visit root_path
    end

    it 'has a user list that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can see new messages count in top menu' do
      expect(page).to have_content('User Two (2)')
    end
  end
end