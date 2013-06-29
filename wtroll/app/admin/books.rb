ActiveAdmin.register Book do
	menu priority: 1

	show title: :title do |book|
		attributes_table do
			row :id
			row :title
			row :author
			row :url
			row :author_url
			table_for book.isbns do
				column "ISBNs" do |isbn|
					isbn.number
				end
			end
		end
	end
end
