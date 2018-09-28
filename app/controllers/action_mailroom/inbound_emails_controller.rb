# TODO: Add access protection using basic auth with verified tokens. Maybe coming from credentials by default?
# TODO: Spam/malware catching?
# TODO: Specific bounces for SMTP good citizenship: 200/404/400
class ActionMailroom::InboundEmailsController < ActionController::Base
  skip_forgery_protection
  before_action :require_rfc822_message, only: :create

  def create
    ActionMailroom::InboundEmail.create_from_raw_email!(params[:message])
    head :created
  end

  private
    def require_rfc822_message
      head :unsupported_media_type unless params.require(:message).content_type == 'message/rfc822'
    end
end
