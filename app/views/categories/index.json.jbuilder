json.array!(@categories) do |category|
  json.extract! category, :id, :nombre, :descripcion
  json.url category_url(category, format: :json)
end
