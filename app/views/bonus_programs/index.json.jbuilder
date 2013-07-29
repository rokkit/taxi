json.array!(@bonus_programs) do |bonus_program|
  json.extract! bonus_program, :name, :rate
  json.url bonus_program_url(bonus_program, format: :json)
end
