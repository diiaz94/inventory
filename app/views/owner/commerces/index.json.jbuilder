json.array!(@commerces) do |commerce|
  json.extract! commerce, :id, :nombre, :descripcion
  json.url commerce_url(commerce, format: :json)
end
