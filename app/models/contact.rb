class Contact
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :type, type: String
    field :content, type: String
end
