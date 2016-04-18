  json.extract! @user, :id, :cedula, :slug
  json.extract! @user.profile, :id, :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sex_name, :email, :celular

