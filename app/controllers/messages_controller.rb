class MessagesController < ApplicationController


  #create the new message
  #
  def create
    @codroo = Codroo.find(params[:codroo_id])
    @message = @codroo.messages.new(params[:message])
    @message.message_id = params[:id]
    @message.active = 1
    @message.user_id = current_user.id
    if @message.save
      redirect_to([@codroo,@message], :notice => "Message published!")
    else
      render :action => "add"
    end
  end

  #view a message and all of it's replies
  def show
    @codroo = Codroo.find(params[:codroo_id])
    @message = Message.find(params[:id])
  end

end
