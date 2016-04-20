json.array!(@brands) do |brand|
  json.extract! brand, :id, :nombre, :descripcion
  json.url brand_url(brand, format: :json)
end
