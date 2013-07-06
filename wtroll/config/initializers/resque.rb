class Authentication
	def initialize app 
		@app = app 
	end

	def call env
		env['warden'].authenticate! :database_authenticatable, :rememberable, scope: :admin_user
		@app.call env
	end
end

Resque::Server.use Authentication