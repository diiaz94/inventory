json.array!(@products) do |load|
  json.extract! load.product, :id, :nombre_marca 
  json.extract! load, :cantidad
end