json.array!(@products) do |product|
  json.extract! product.product, :id, :codigo_nombre_marca, :nombre, :marca
  json.extract! product, :cantidad,:precio
end