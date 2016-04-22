json.array!(@downloads) do |download|
  json.extract! download, :id, :cantidad, :precio
  json.url download_url(download, format: :json)
end
