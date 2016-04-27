json.array!(@sellers) do |seller|
  json.extract! seller, :id, :user_id, :commerce_id, :store_id
  json.url seller_url(seller, format: :json)
end
