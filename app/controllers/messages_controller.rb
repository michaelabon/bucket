class MessagesController < ApplicationController
  def receive
    logger.info("Params: " + <<-PARAMS)
      #{params}
    PARAMS
    logger.info("Body: " + <<-BODY)
      #{request.body.read}
    BODY

    message = Message.new(receive_params(params))

    return render nothing: true, status: :bad_request unless message.valid?

    bucket = Bucket::Bucket.new
    message_response = bucket.process(message)

    if message_response.present?
      render json: { text: message_response }
    else
      render json: {}
    end
  end

  private

  def receive_params(params)
    params.permit(:token, :text, :user_name)
  end
end
