class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :password, :email, :balance
  has_many :wagers
end
