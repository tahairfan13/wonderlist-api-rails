class AddingColumnToDocuments < ActiveRecord::Migration[5.1]
  def change
  	add_column :documents, :doc_file_name, :string
  	add_column :documents, :doc_content_type ,:string
  	add_column :documents, :doc_file_size, :integer
  	add_column :documents, :doc_updated_at, :timestamp
  end
end
