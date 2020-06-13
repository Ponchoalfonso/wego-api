json.ignore_nil!
json.profile do
  json.extract! @user, :name, :last_name, :second_last_name, :birthday, :phone_number
  json.picutre_url @user.profile_picture_url
end