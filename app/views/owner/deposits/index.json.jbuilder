json.array!(@deposits) do |deposit|
  json.extract! deposit, :id, :nombre, :descripcion,:products_count
end
