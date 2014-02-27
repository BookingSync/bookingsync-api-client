class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  after_action :allow_bookingsync_iframe

  private

  def allow_bookingsync_iframe
    response.headers['X-Frame-Options'] = 'ALLOW-FROM https://www.bookingsync.com https://bookingsync.dev'
  end
end
