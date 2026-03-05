# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌊 Limpando banco de dados..."
SurfCondition.destroy_all
Beach.destroy_all

puts "🏖️ Criando praias..."

# Praias do Rio de Janeiro
beaches_data = [
  {
    name: "Praia da Barra da Tijuca",
    latitude: -23.0128,
    longitude: -43.3089,
    city: "Rio de Janeiro",
    state: "RJ",
    difficulty_level: "intermediate",
    beach_type: "Beach break",
    ideal_swell_direction: "S, SW",
    ideal_wind_direction: "N, NE",
    description: "Uma das praias mais longas do Rio, com boas ondas para surfistas intermediários."
  },
  {
    name: "Praia do Arpoador",
    latitude: -22.9881,
    longitude: -43.1906,
    city: "Rio de Janeiro",
    state: "RJ",
    difficulty_level: "advanced",
    beach_type: "Point break",
    ideal_swell_direction: "S, SW",
    ideal_wind_direction: "N",
    description: "Famosa praia do Rio com ondas consistentes e pôr do sol incrível. Ideal para surfistas experientes."
  },
  {
    name: "Praia de Grumari",
    latitude: -23.0461,
    longitude: -43.5192,
    city: "Rio de Janeiro",
    state: "RJ",
    difficulty_level: "beginner",
    beach_type: "Beach break",
    ideal_swell_direction: "S",
    ideal_wind_direction: "N, NW",
    description: "Praia selvagem e preservada, ótima para iniciantes nos dias de ondas menores."
  },
  
  # Praias de São Paulo
  {
    name: "Praia de Maresias",
    latitude: -23.7914,
    longitude: -45.5567,
    city: "São Sebastião",
    state: "SP",
    difficulty_level: "intermediate",
    beach_type: "Beach break",
    ideal_swell_direction: "S, SE",
    ideal_wind_direction: "N, NW",
    description: "Uma das melhores praias de São Paulo para surf, com ondas consistentes e boa infraestrutura."
  },
  {
    name: "Praia da Joaquina",
    latitude: -27.6281,
    longitude: -48.4469,
    city: "Florianópolis",
    state: "SC",
    difficulty_level: "advanced",
    beach_type: "Beach break",
    ideal_swell_direction: "S, SE",
    ideal_wind_direction: "N, NW",
    description: "Praia icônica de Floripa, sede de campeonatos internacionais de surf."
  },
  {
    name: "Praia Mole",
    latitude: -27.6058,
    longitude: -48.4308,
    city: "Florianópolis",
    state: "SC",
    difficulty_level: "intermediate",
    beach_type: "Beach break",
    ideal_swell_direction: "S, SE",
    ideal_wind_direction: "W, NW",
    description: "Praia jovem e animada com boas ondas para intermediários."
  },
  
  # Praias do Nordeste
  {
    name: "Praia de Itacaré",
    latitude: -14.2764,
    longitude: -38.9964,
    city: "Itacaré",
    state: "BA",
    difficulty_level: "intermediate",
    beach_type: "Beach break",
    ideal_swell_direction: "E, SE",
    ideal_wind_direction: "W, SW",
    description: "Destino clássico de surf na Bahia com diversas praias e beach breaks."
  },
  {
    name: "Praia de Pipa",
    latitude: -6.2297,
    longitude: -35.0664,
    city: "Tibau do Sul",
    state: "RN",
    difficulty_level: "beginner",
    beach_type: "Beach break",
    ideal_swell_direction: "E, SE",
    ideal_wind_direction: "W",
    description: "Famosa praia do Rio Grande do Norte com ondas para todos os níveis."
  },
  {
    name: "Praia de Fernando de Noronha",
    latitude: -3.8549,
    longitude: -32.4281,
    city: "Fernando de Noronha",
    state: "PE",
    difficulty_level: "advanced",
    beach_type: "Reef break",
    ideal_swell_direction: "NE, E",
    ideal_wind_direction: "SE",
    description: "Paraíso do surf com águas cristalinas e ondas perfeitas (Cacimba do Padre)."
  }
]

beaches = beaches_data.map do |beach_data|
  Beach.create!(beach_data)
end

puts "✅ #{beaches.count} praias criadas!"

puts "🌊 Criando condições de surf..."

# Criar condições para cada praia
beaches.each do |beach|
  # Criar condições atuais
  current_condition = SurfCondition.create!(
    beach: beach,
    wave_height: rand(0.5..2.5).round(1),
    wave_period: rand(8.0..14.0).round(1),
    wave_direction: rand(0..359),
    wind_speed: rand(5.0..20.0).round(1),
    wind_direction: rand(0..359),
    water_temperature: rand(20.0..26.0).round(1),
    forecast_time: Time.current
  )
  
  # Criar histórico (últimas 24h)
  24.times do |i|
    SurfCondition.create!(
      beach: beach,
      wave_height: rand(0.3..2.0).round(1),
      wave_period: rand(7.0..13.0).round(1),
      wave_direction: rand(0..359),
      wind_speed: rand(3.0..25.0).round(1),
      wind_direction: rand(0..359),
      water_temperature: rand(19.0..26.0).round(1),
      forecast_time: Time.current - i.hours,
      created_at: Time.current - i.hours
    )
  end
end

puts "✅ Condições de surf criadas!"
puts "🏄‍♂️ Database populado com sucesso!"
puts ""
puts "📊 Resumo:"
puts "  - #{Beach.count} praias"
puts "  - #{SurfCondition.count} registros de condições"
puts ""
puts "🚀 Para ver: rails server"
