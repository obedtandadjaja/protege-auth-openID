class PasswordResetsController < ApplicationController

	def new
  	end

  	def create
	  account = Account.find_by_email(params[:email])
	  account.send_password_reset if account
	  flash[:success] = "Email sent with password reset instructions."
	  redirect_to '/login'
	end

	def edit
	  @account = Account.find_by_password_reset_token!(params[:id])
	end

	def update
	  @account = Account.find_by_password_reset_token!(params[:format])
	  if @account.password_reset_sent_at < 1.hours.ago
	  	flash[:danger] = "Password reset has expired."
	    redirect_to new_password_reset_path
	  elsif @account.update_attributes(params[:account])
	  	flash[:success] = "Password has been reset!"
	    redirect_to '/auth/login'
	  else
	  	flash[:danger] = Array.new
	    @account.errors.full_messages.each do |error_message|
	      flash[:danger] << error_message
	    end
	    redirect_to :back
	  end
	end

end
