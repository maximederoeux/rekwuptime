json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :employee_id, :in
  json.url attendance_url(attendance, format: :json)
end
