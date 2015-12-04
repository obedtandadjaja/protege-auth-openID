class RegisterController < ApplicationController

	# load the register form
	def index
	end

	# handles the form POST requests
	def store
		@account = Account.new(params['account'])
		@account.save
		redirect_to('/')
	end

end
