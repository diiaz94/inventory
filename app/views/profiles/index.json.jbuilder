json.array!(@profiles) do |profile|
  json.extract! profile, :id, :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :email, :celular
  json.url profile_url(profile, format: :json)
end
