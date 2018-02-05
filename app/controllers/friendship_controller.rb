require 'set'

class FriendshipController < ApplicationController

  # POST /friendship
  def create
    friends = params[:friends]
    payload = Friendship.parse_two_friends(friends)

    if payload[:success]
      friends = payload[:friends]
      result = Friendship.create(friends[0], friends[1])
      if result[:success]
        render json: result, status: :ok
      else
        render json: result, status: :bad_request
      end 
    else
      render json: payload, status: :bad_request
    end

  end

  # GET /friendship
  def index
    email = params[:email]
    email = email.strip unless email.nil?
    
    friends = Friendship.where(user: email).map{|f| f.friend}

    payload = {
      "success": true,
      "friends": friends,
      "count": friends.size
    }

    render json: payload, status: :ok
  end

  def common
    friends = params[:friends]
    payload = {success: false}

    payload = Friendship.parse_two_friends(friends)
    if payload[:success]
      friends = payload[:friends]
      friends = Friendship.common_friends(friends[0], friends[1])
      payload = {
        success: true,
        friends: friends,
        count: friends.size
      } 
      render json: payload, status: :ok
    else
      render json: payload, status: :bad_request
    end
  end

end
