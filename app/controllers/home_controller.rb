class HomeController < ApplicationController
  before_filter :authenticate_account!, except: :index

  def index
    redirect_to api_request_path if current_account
  end

  def api_request
    if params[:api_path]
      begin
        @response = current_account_token.get("/api/v3/" + params[:api_path])
      rescue OAuth2::Error => e
        @error = e
      end
    end
  end
end
