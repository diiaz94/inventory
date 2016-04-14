json.array!(@products) do |product|
  json.extract! product, :id, :nombre, :descripcion
  json.url product_url(product, format: :json)
end
