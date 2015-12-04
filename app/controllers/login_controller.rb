class LoginController < ApplicationController
  before_filter :require_anonymous_access

  # always redirect to /auth/login for access
  def main
  	redirect_to '/auth/login'
  end

  # display the login form
  def index
  end
end
