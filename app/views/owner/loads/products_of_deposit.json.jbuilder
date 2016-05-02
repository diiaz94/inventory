json.array!(@loads) do |load|
  json.extract! load, :id, :cantidad, :precio
  json.extract! load.product, :id, :nombre_marca
  json.url load_url(load, format: :json)
end
