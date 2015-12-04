class Connect::FakesController < ApplicationController
  before_filter :require_anonymous_access

  def create
    account = Account.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if account && account.authenticate(params[:password])
      	# Save the user id inside the browser cookie. This is how we keep the user
      	# logged in when they navigate around the website.
      	authenticate Connect::Fake.authenticate
      	logged_in!
    else
      	# If user's login doesn't work, send them back to the login form.
      	flash[:notice] = "The email/password you entered is incorrect. Please try again."
      	redirect_to '/auth/login'
    end
  end

end
