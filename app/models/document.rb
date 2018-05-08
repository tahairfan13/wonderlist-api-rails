class Document < ApplicationRecord
  # associations	
  belongs_to :user, dependent: :destroy
  belongs_to :documentable, polymorphic: true
  has_attached_file :doc

  attr_accessor :input #this will be the attribute we use to send the data

  #validation
  before_create :decode_base64_doc
  validates_attachment_content_type :doc, :content_type =>["image/jpg", "image/jpeg", "image/png", "image/gif"]


  protected
  def decode_base64_doc
    content_type = input[/(image\/[a-z]{3,4})/]
    input.slice! input[/data:(image\/.{3,}),/]
    decoded_data = Base64.decode64(input)

    data = StringIO.new(decoded_data)
    data.class_eval do
      attr_accessor :content_type, :original_filename
    end

    data.content_type = content_type
    content_type.slice! "image/"
    data.original_filename = 'pic_'+Time.now.to_s+'.'+content_type

    self.input = ""

    self.doc = data
  end
end
