json.array!(@commerce.deposits) do |deposit|
  json.extract! deposit, :id, :nombre, :descripcion
end