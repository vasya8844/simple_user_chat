class MessagesController < ApplicationController
  before_filter :define_to_user, only: [:show, :new]

  def index
    @users = User.active.
      select('users.id, name, count(*) - 1 unread_count').
      joins('LEFT JOIN messages m ON m.user_id = users.id').
      where('users.id != ?', current_user).
      where('m.id IS NULL OR m.is_read = ? AND m.to_user_id = ?', false, current_user.id).
      group('users.id').
      order('unread_count DESC')
  end

  def show
    ids = [current_user.id, @to_user.id]
    @messages = Message.
      where('user_id IN (?) AND to_user_id IN (?)', ids, ids).
      where('id > ?', params[:after_id].to_i).
      order('created_at DESC')
  end

  def new
    @message = Message.new
    @messages = Message.order('created_at DESC')
  end

  def create
    respond_to do |format|
      select_to_user(params[:message][:to_user_id])
      if current_user
        ps = message_params
        ps[:to_user_id] = @to_user.id
        @message = current_user.messages.build(ps)
        if @message.save
          flash[:success] = 'done!'
        else
          flash[:error] = 'failed.'
        end
        format.html {redirect_to root_url}
        format.js 
      else
        format.html {redirect_to root_url}
        format.js {render nothing: true}
      end
    end
  end
    
  private
  def define_to_user
    select_to_user(params[:to_user_id])
  end

  def select_to_user(user_id)
    @to_user = User.find_by_id user_id
    raise 'undefined to user' unless @to_user
    raise 'can not speac with youself' if @to_user == current_user
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
