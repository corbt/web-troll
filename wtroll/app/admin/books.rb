ActiveAdmin.register Book do
	menu priority: 1

	index do
		column :title
		column :author
		column :reading_level
		column "ISBNs" do |book|
			book.isbns.map &:number
		end
		column :calculation_status
		column "API requester", :user
		default_actions
	end

	show title: :title do |book|
		attributes_table do
			row :id
			row :title
			row :author
			row :url
			row :author_url
			row :user
			table_for book.isbns do
				column "ISBNs" do |isbn|
					isbn.number
				end
			end
		end
	end
end
