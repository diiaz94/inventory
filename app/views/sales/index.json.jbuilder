json.array!(@sales) do |sale|
  json.extract! sale, :id, :cantidad, :precio
  json.url sale_url(sale, format: :json)
end
