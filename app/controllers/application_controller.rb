class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: :modern

  private

  def after_authentication_url
    posts_path
  end

  def after_logout_url
    about_path
  end
end
