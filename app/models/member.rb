class Member
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :last_name, type: String
  field :relation, type: String
  field :doc, type: String
  field :course, type: String

  embeds_many :contacts
end