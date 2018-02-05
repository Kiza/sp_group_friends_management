class SubscriptionController < ApplicationController

  # POST subscription
  def create
    requestor = params[:requestor].strip
    requestor = requestor.strip unless requestor.nil?

    target = params[:target].strip
    target = target.strip unless target.nil?

    subscription = Subscription.new(by_user:requestor, to_user:target)

    payload = {success:true}
    begin
      subscription.save!
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
