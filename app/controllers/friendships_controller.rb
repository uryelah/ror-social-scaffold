class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def show; end

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      flash[:notice] =  'You sent a Friendship request'
    else
      flash[:alert] = 'You failed to send a Friendship request'
    end
    friendship_redirect
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update_attribute(:status, true)
    @friendship_two = Friendship.new(user_id: @friendship.friend_id, friend_id: @friendship.user_id, status: true)
    @friendship_two.save
    flash[:notice] = 'Friendship has been accepted'
    friendship_redirect
  end

  def destroy
    Friendship.find(params[:id]).destroy
    flash[:notice] = 'Friendship has been rejected'
    friendship_redirect
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id, :user_id, :id)
  end

  def friendship_redirect
    redirect_back(fallback_location: root_path)
  end
end
