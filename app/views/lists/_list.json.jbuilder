 json.extract! list, :id, :name, :created_at, :updated_at

 json.cover_picture do
 	json.partial! "documents/document", document: list.document
 end


 # This is another way to achieve the functionality but the above one looks more sophisticated
                      #json.name list.name
                      #json.tasks list.tasks
