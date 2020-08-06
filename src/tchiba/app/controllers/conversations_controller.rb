class ConversationsController < ApplicationController
  before_action :authenticate
  
  def index
    @to_conversations = Conversation.where(to_user_id: current_user.id)
    @from_conversations = Conversation.where(from_user_id: current_user.id)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end

  def new
    @blend = Blend.find(params[:blend_id])

    if Conversation.find_by(blend_id: @blend.id, from_user_id: current_user.id)
      redirect_to conversation_path(Conversation.find_by(blend_id: @blend.id, from_user_id: current_user.id))
    end
    
    @conversation = Conversation.create(to_user_id: @blend.user.id, from_user_id: current_user.id, blend_id: @blend.id)

    @message = Message.new
  end

  def create
    @conversation = Conversation.find(params[:id])
    if @conversation.messages.create(strong_message_params)
      redirect_to conversation_path(@conversation)
    else
      flash[:alert] = "Could not send message"
      render 'new'
    end
  end

  def add
    @conversation = Conversation.find(params[:id])
    unless @conversation.is_active
      flash[:alert] = "Cannot send message as this conversation is inactive"
      redirect_to conversation_path(@conversation) and return
    end

    if @conversation.messages.create(strong_add_params)
      redirect_to conversation_path(@conversation)
    else
      flash[:alert] = "Could not send message"
      render 'new'
    end
  end

  def inactive
    conversation = Conversation.find(params[:id])
    
    if conversation.to_user_id != current_user.id
      flash[:alert] = "You don't have permission to do this"
      redirect_to conversation_path(@conversation) and return
    end

    conversation.update(is_active: false)
    flash[:alert] = "Conversation is no longer active"
    redirect_to conversation_path(conversation)
  end

  def destroy
    conversation = Conversation.find(params[:id])

    if conversation.to_user_id != current_user.id
      flash[:alert] = "You don't have permission to do this"
      redirect_to conversation_path(@conversation) and return
    end

    conversation.messages.destroy_all
    conversation.destroy
    flash[:alert] = "Conversation deleted"
    redirect_to conversations_path
  end

private

  def strong_new_params
    params.require(:message).permit(:content)
  end

  def strong_add_params
    params.require(:message).permit(:content, :is_from_user)
  end

  def set_conversation
  end
end
