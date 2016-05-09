json.array!(@stores) do |store|
  json.extract! store, :id, :nombre, :direccion,:products_count
end
