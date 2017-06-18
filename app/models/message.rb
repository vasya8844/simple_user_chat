class Message < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length: {maximum: 200}

  def self.get_conversation(user, to_user, after_id)
    ids = [user.id, to_user.id]

    list = where('user_id IN (?) AND to_user_id IN (?)', ids, ids).
      where('id > ?', after_id).
      order('created_at DESC')

    list.select{ |message| message.to_user_id == user.id && !message.is_read }.each do |message|
      message.is_read = true
      message.save
    end

   	list
  end
end

