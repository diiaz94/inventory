json.array!(@commerces) do |commerce|
  json.extract! commerce, :id, :nombre, :descripcion, :deposits_count,:stores_count, :sellers_count
  json.url owner_commerce_url(commerce, format: :json)
end
