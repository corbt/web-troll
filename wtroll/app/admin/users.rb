ActiveAdmin.register User, as: "API User" do
	menu priority: 3

  form do |f|
  	f.inputs :name, :email
    f.actions
  end


	controller do
		before_action :generate_key, only: :create

		def generate_key
			params['api_user']['api_key'] = SecureRandom.hex 20
		end

	end
end
