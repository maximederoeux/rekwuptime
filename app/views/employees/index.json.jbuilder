json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :first_name, :status
  json.url employee_url(employee, format: :json)
end
