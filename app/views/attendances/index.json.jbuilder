json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :user_id, :in
  json.url attendance_url(attendance, format: :json)
end
