class BlacklistController < ApplicationController

  # POST /blacklist
  def create
    requestor = params[:requestor]
    requestor = requestor.strip unless requestor.nil?

    target = params[:target]
    target = target.strip unless target.nil?

    blacklist = Blacklist.new(by_user: requestor, blocked: target)

    payload = {success:true}
    begin
      blacklist.save!
    rescue ActiveRecord::RecordInvalid => e
      payload = {success:false, error:e.message}
    end

    if payload[:success]
      render json: payload, status: :ok
    else
      render json: payload, status: :bad_request
    end
  end
end
