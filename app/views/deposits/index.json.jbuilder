json.array!(@deposits) do |deposit|
  json.extract! deposit, :id, :nombre, :descripcion
  json.url deposit_url(deposit, format: :json)
end
