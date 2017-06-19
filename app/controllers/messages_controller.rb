class MessagesController < ApplicationController
  before_action :define_to_user, only: [:show, :new]

  def index
    message_counts = Message.select('user_id, count(*)').
      where(to_user_id: current_user.id).where(is_read: false).
      group(:user_id).collect{ |m| [m.user_id, m.count] }.to_h

    @users = User.active.where('users.id != ?', current_user)
    @users = @users.collect{ |u| {sent_count: message_counts[u.id] || 0, user: u}}.
      sort_by{ |v| v[:sent_count]}.reverse
  end

  def top_count
    r = Message.where(to_user_id: current_user.id, is_read: false)
    if (id = params[:to_user_id].to_i) && id > 0
      r = r.where('user_id != ?', id)
    end
    @top_count = r.count
    @top_count = @top_count > 0 ? " (#{@top_count})" : ''
  end

  def show
    @messages = Message.get_conversation(current_user, @to_user, params[:after_id].to_i)
  end

  def new
    @message = Message.new
    @messages = Message.get_conversation(current_user, @to_user, 0)
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
