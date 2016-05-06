json.array!(@products) do |product|
  json.extract! product.product, :id, :nombre_marca, :cantidad
end