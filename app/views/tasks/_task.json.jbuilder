json.extract! task, :id, :name, :created_at, :updated_at

 json.cover_picture do
 	json.array! task.document, partial: "documents/document", as: :document
 end