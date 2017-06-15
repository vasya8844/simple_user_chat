require 'rails_helper'

describe 'navigate' do
  before do
    @user = FactoryGirl.create :user
    login_as(@user, :scope => :user)
  end

  describe 'index' do
    before do
      visit new_message_path
    end

  	it 'can be reached successfully' do
  		expect(page.status_code).to eq(200)
  	end

  	it 'has a title of message' do
  		expect(page).to have_content(/Переписка/)
  	end

    it 'has a message list' do
      message1 = FactoryGirl.create :message, user: User.first
      message2 = FactoryGirl.create :message, body: 'mesasge two', user: User.first
      visit new_message_path
      expect(page).to have_content(/mesasge one|mesasge two/)
    end
  end

  describe 'creation' do
  	before do
  		visit new_message_path
  	end

  	it 'has a new form that can be reached' do
  		expect(page.status_code).to eq(200)
  	end

  	it 'can be created from new form page' do
      fill_in 'message[body]', with: 'hello my friend'
      click_on 'say'
      expect(page).to have_content('hello my friend')
  	end

    it 'will have a user associated it' do
      fill_in 'message[body]', with: 'aloha'
      click_on "say"

      expect(User.last.messages.last.body).to eq('aloha')
    end
  end
end