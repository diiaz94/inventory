json.array!(@users) do |user|
  json.extract! user, :id, :cedula, :crypted_password, :salt, :slug, :type_id, :persona_id
  json.url user_url(user, format: :json)
end
