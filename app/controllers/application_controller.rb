class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_filter :set_locale

  def url_options
    { :locale => I18n.locale }.merge(super)
  end


  private
  def set_locale
    extracted_locale = params[:locale] || extract_locale_from_accept_language
    I18n.locale = (I18n::available_locales.include? extracted_locale.to_sym) ?
                    extracted_locale : I18n.default_locale
  end

  def extract_locale_from_accept_language
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
