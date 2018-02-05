class MessageController < ApplicationController

  # GET /message/recipients
  def recipients
    sender = params[:sender]
    sender = sender.strip unless sender.nil?

    text = params[:text]
    text = text.strip unless text.nil?

    send_to = Message.recipients(sender, text)

    payload = {
      "success": true,
      "recipients": send_to,
    }

    render json: payload, status: :ok
  end
end
