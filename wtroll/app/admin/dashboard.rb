ActiveAdmin.register_page "Dashboard" do
	menu false

  controller do
    def index
        redirect_to admin_books_path
    end
  end
end
