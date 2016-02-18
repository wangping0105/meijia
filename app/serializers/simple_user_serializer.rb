class SimpleUserSerializer < ActiveModel::Serializer
  include NonullSerializerable

  self.root = false
  attributes :id, :email, :created_at, :name, :phone

  #string型属性
  self.stringify_keys = [:email, :created_at, :name, :phone]
  #integer型属性
  self.integerify_keys = [:id]
  #float型属性
  self.floatify_keys = []

end
