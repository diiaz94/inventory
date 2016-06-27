json.array!(@closures) do |closure|
  json.extract! closure, :id, :seller_id
  json.url closure_url(closure, format: :json)
end
