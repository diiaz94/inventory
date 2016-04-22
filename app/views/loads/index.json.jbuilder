json.array!(@loads) do |load|
  json.extract! load, :id, :cantidad, :precio
  json.url load_url(load, format: :json)
end
