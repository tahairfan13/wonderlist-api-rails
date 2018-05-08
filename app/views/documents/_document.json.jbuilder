json.extract! document, :id, :name, :created_at, :updated_at
json.url get_url(request.base_url, document.doc.url)