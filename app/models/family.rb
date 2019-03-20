class Family
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Includes

  default_scope {order(status: 'asc', name: 'asc')}

  field :name, type: String
  field :status, type: String

  embeds_many :members
end
