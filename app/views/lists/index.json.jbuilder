json.timestamp @timestamp
json.page_size @lists.size
if @lists.size == 0
	json.more_available false
else
	json.more_available !@lists.last_page?
end

json.total_records @lists.total_count

json.page @lists.current_page

json.total_pages @lists.total_pages


json.lists do
	json.array! @lists, partial: "lists/list", as: :list	
end
