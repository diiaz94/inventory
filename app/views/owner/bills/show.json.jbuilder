json.extract! @bill, :id, :total, :pago, :created_at, :updated_at
json.url owner_commerce_store_url(@commerce,@store)