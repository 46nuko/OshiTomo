class Public::SessionsController < Public::ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }
  before_action :reject_inactive_user, only: [:create]
  def new
  end

  def create
    if (user = User.find_by(name: params[:name]))&.authenticate(params[:password])
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
   private

  def reject_inactive_user
    user = User.find_by(email_address: params[:email_address])
    return if user.nil?
    return unless user.authenticate(params[:password])
    unless user.is_active?
      redirect_to new_user_registration_path, alert: "退会済みのアカウントです。再度ご登録ください。"
    end
  end
end
