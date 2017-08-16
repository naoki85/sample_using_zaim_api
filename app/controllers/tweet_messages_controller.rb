class TweetMessagesController < ApplicationController
  before_action :set_tweet_message, only: [:show, :edit, :update, :destroy]

  def index
    @tweet_messages = TweetMessage.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @tweet_message = TweetMessage.new
  end

  def create
    @tweet_message = TweetMessage.new(tweet_message_params)
    @tweet_message.user_id = current_user.id

    if @tweet_message.save
      redirect_to @tweet_message, notice: 'Tweet Message was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tweet_message.update(tweet_message_params)
      redirect_to @tweet_message, notice: 'Tweet Message was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tweet_message.destroy
    redirect_to tweet_messages_path, notice: 'Tweet Message was successfully deleted.'
  end

  private

  def set_tweet_message
    @tweet_message = TweetMessage.find(params[:id])
  end

  def tweet_message_params
    params.fetch(:tweet_message, {}).permit(:message, :threshold, :condition)
  end

end
