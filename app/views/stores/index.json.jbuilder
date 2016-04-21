json.array!(@stores) do |store|
  json.extract! store, :id, :nombre, :direccion
  json.url store_url(store, format: :json)
end
