class RegisterController < ApplicationController

	# load the register form
	def index
	end

	# handles the form POST requests
	def store
		@account = Account.new(params['account'])
		if @account.save
			flash[:success] = "Your account has been successfully created"
			redirect_to('/')
		else
			flash[:danger] = Array.new
		    @account.errors.full_messages.each do |error_message|
		      flash[:danger] << error_message
		    end
			redirect_to :back
		end
	end

end
