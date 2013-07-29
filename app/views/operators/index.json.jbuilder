json.array!(@operators) do |operator|
  json.extract! operator, 
  json.url operator_url(operator, format: :json)
end
