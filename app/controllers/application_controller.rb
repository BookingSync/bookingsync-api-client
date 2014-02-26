class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_account

  private

  def current_account
    @current_account ||= Account.find(session[:account_id]) if session[:account_id]
  end

  def current_account_token
    @current_account_token ||= begin
      token = OAuth2::AccessToken.new(oauth_client,
        current_account.oauth_access_token,
        refresh_token: current_account.oauth_refresh_token,
        expires_at: current_account.oauth_expires_at.to_i)

      if token.expired?
        token = token.refresh!
        current_account.update_token!(token)
      end

      token
    end
  end

  def oauth_client
    client_options = {
      site: ENV['BOOKINGSYNC_URL'],
      connection_opts: {headers: {accept: "application/vnd.api+json"}}
    }
    client_options[:ssl] = {verify: false} if Rails.env.development?
    OAuth2::Client.new(ENV['BOOKINGSYNC_APP_ID'], ENV['BOOKINGSYNC_APP_SECRET'],
      client_options)
  end
end
