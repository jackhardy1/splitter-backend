class BillSerializer < ActiveModel::Serializer
  attributes :id, :event, :image, :user_id
end
