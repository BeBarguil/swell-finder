# 🏄‍♂️ Surf Spot Finder

[![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-7.1-CC0000?style=for-the-badge&logo=ruby-on-rails)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![TailwindCSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)](https://tailwindcss.com/)

## 📖 Sobre o Projeto

**Surf Spot Finder** é uma aplicação web que ajuda surfistas a encontrar as melhores praias para surfar baseado em sua localização atual. O app mostra informações detalhadas sobre condições de surf, incluindo altura das ondas (swell), velocidade e direção do vento, e classifica cada praia por nível de dificuldade.

### ✨ Funcionalidades

- 🌍 **Geolocalização**: Encontre praias próximas usando sua localização
- 🌊 **Monitoramento de Swell**: Visualize altura, período e direção das ondas
- 💨 **Informações de Vento**: Velocidade e direção do vento em tempo real
- 📊 **Classificação de Dificuldade**: Praias categorizadas para iniciantes, intermediários e avançados
- 📈 **Histórico de Condições**: Acompanhe mudanças nas condições de surf
- 🎯 **Interface Moderna**: Design responsivo e intuitivo com Tailwind CSS
- 📱 **Mobile-First**: Totalmente otimizado para dispositivos móveis

## 🚀 Tecnologias Utilizadas

### Backend
- **Ruby on Rails 7.1**: Framework web fullstack
- **PostgreSQL**: Banco de dados relacional
- **Active Record**: ORM para modelagem de dados

### Frontend
- **HTML5 & ERB**: Templates
- **Tailwind CSS**: Framework CSS utility-first
- **JavaScript (Vanilla)**: Geolocalização e interatividade
- **Stimulus.js**: Framework JavaScript modesto

### APIs e Integrações
- **Geolocation API**: Localização do usuário
- **HTTParty**: Cliente HTTP para requisições de APIs externas
- **Geocoder**: Geocoding e cálculos de distância

## 📋 Pré-requisitos

Antes de começar, você precisa ter instalado:

- Ruby 3.2.0 ou superior
- Rails 7.1 ou superior
- PostgreSQL 14 ou superior
- Node.js 18 ou superior (para assets)
- Git

## ⚙️ Instalação e Configuração

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/surf-spot-finder.git
cd surf-spot-finder
```

### 2. Instale as dependências

```bash
bundle install
```

### 3. Configure o banco de dados

Crie um arquivo `config/database.yml`:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: surf_spot_finder_development

test:
  <<: *default
  database: surf_spot_finder_test

production:
  <<: *default
  database: surf_spot_finder_production
  username: surf_spot_finder
  password: <%= ENV["SURF_SPOT_FINDER_DATABASE_PASSWORD"] %>
```

### 4. Crie e popule o banco de dados

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 5. Inicie o servidor

```bash
rails server
```

Acesse `http://localhost:3000` no seu navegador.

## 🗂️ Estrutura do Projeto

```
surf-spot-finder/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   └── beaches_controller.rb
│   ├── models/
│   │   ├── beach.rb
│   │   └── surf_condition.rb
│   ├── views/
│   │   ├── layouts/
│   │   │   └── application.html.erb
│   │   └── beaches/
│   │       ├── index.html.erb
│   │       ├── show.html.erb
│   │       └── _beach_card.html.erb
│   └── assets/
│       └── stylesheets/
├── config/
│   ├── routes.rb
│   ├── database.yml
│   └── application.rb
├── db/
│   ├── migrate/
│   │   ├── xxx_create_beaches.rb
│   │   └── xxx_create_surf_conditions.rb
│   └── seeds.rb
├── Gemfile
└── README.md
```

## 💾 Modelos de Dados

### Beach (Praia)

```ruby
- name: string              # Nome da praia
- latitude: decimal         # Latitude
- longitude: decimal        # Longitude
- city: string             # Cidade
- state: string            # Estado
- country: string          # País (default: 'BR')
- description: text        # Descrição
- difficulty_level: string # beginner | intermediate | advanced
- beach_type: string       # Beach break | Point break | Reef break
- ideal_swell_direction    # Direção ideal do swell
- ideal_wind_direction     # Direção ideal do vento
```

### SurfCondition (Condições de Surf)

```ruby
- beach_id: integer        # Referência para Beach
- wave_height: decimal     # Altura das ondas (metros)
- wave_period: decimal     # Período das ondas (segundos)
- wave_direction: integer  # Direção das ondas (graus)
- wind_speed: decimal      # Velocidade do vento (km/h)
- wind_direction: integer  # Direção do vento (graus)
- water_temperature: decimal # Temperatura da água (°C)
- forecast_time: datetime  # Horário da previsão
```

## 🧪 Testes

Para rodar os testes:

```bash
# Todos os testes
bundle exec rspec

# Testes específicos
bundle exec rspec spec/models/beach_spec.rb
bundle exec rspec spec/controllers/beaches_controller_spec.rb
```

## 🌐 API Endpoints

### Listar Praias

```
GET /beaches
GET /beaches?lat=-23.0128&lng=-43.3089
```

Retorna lista de praias. Se `lat` e `lng` forem fornecidos, retorna praias ordenadas por distância.

### Detalhes da Praia

```
GET /beaches/:id
```

Retorna informações detalhadas de uma praia específica com condições atuais.

## 🔮 Próximas Funcionalidades

- [ ] Integração com API de previsão de ondas (Stormglass, Windy)
- [ ] Sistema de favoritos
- [ ] Previsão de 7 dias
- [ ] Notificações push quando condições estiverem boas
- [ ] Sistema de comentários e avaliações
- [ ] Fotos e vídeos das praias
- [ ] Integração com mapas interativos
- [ ] PWA (Progressive Web App)
- [ ] Autenticação de usuários
- [ ] Dashboard administrativo

## 📱 Screenshots

### Página Principal
![Home Page](docs/screenshots/home.png)

### Detalhes da Praia
![Beach Details](docs/screenshots/beach-details.png)

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

**Seu Nome**

- GitHub: [@seu-usuario](https://github.com/seu-usuario)
- LinkedIn: [seu-nome](https://linkedin.com/in/seu-nome)
- Email: seu.email@exemplo.com

## 🙏 Agradecimentos

- Comunidade Ruby on Rails
- Surfistas que inspiraram este projeto
- Contribuidores open source

---

⭐ Se este projeto te ajudou, considere dar uma estrela!

🏄‍♂️ **Boas ondas!**
