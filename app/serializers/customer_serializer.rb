class CustomerSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :address, :contact, :is_admin
end
