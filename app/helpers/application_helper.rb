module ApplicationHelper
	def get_url(base_url, doc_url)
		if Rails.env == 'development'
			asset_url(doc_url)
		end
	end
end