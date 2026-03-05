# 🏗️ Arquitetura e Decisões Técnicas

## Visão Geral

Este documento explica as decisões arquiteturais do **Surf Spot Finder** e como diferentes componentes trabalham juntos.

## 📐 Arquitetura da Aplicação

### Padrão MVC (Model-View-Controller)

```
┌─────────────────────────────────────────┐
│           Browser/Cliente               │
│  (HTML, CSS, JavaScript, Geolocation)   │
└──────────────┬──────────────────────────┘
               │ HTTP Request
               ▼
┌─────────────────────────────────────────┐
│            Routes (config/routes.rb)    │
└──────────────┬──────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────┐
│         Controllers                      │
│  - BeachesController                    │
│  - ApplicationController                │
└──────────────┬──────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────┐
│           Models                         │
│  - Beach (praias)                       │
│  - SurfCondition (condições)            │
└──────────────┬──────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────┐
│         Database (PostgreSQL)           │
│  - beaches table                        │
│  - surf_conditions table                │
└─────────────────────────────────────────┘
```

## 🗂️ Camadas da Aplicação

### 1. Camada de Apresentação (Views)

**Tecnologias:**
- ERB (Embedded Ruby)
- Tailwind CSS
- Vanilla JavaScript

**Decisão:** Utilizamos Tailwind CSS ao invés de Bootstrap porque:
- Mais flexibilidade e customização
- Utility-first approach facilita prototipagem rápida
- Arquivo final menor (unused CSS é removido)
- Mais moderno e em alta demanda no mercado

**Views principais:**
- `layouts/application.html.erb`: Layout base
- `beaches/index.html.erb`: Listagem de praias
- `beaches/show.html.erb`: Detalhes da praia
- `beaches/_beach_card.html.erb`: Partial reutilizável

### 2. Camada de Controle (Controllers)

**BeachesController:**
- `index`: Lista praias (com filtro por localização)
- `show`: Exibe detalhes de uma praia específica

**Padrão RESTful:** Seguimos convenções REST do Rails para rotas e actions.

### 3. Camada de Modelo (Models)

#### Beach Model
```ruby
- Validações de presença e formato
- Cálculo de distância (Haversine formula)
- Métodos de apresentação (difficulty_label)
- Associação has_many com SurfCondition
```

#### SurfCondition Model
```ruby
- Validações de valores numéricos
- Métodos de análise (good_conditions?, swell_quality)
- Formatação de dados (wave_height_formatted)
- Associação belongs_to com Beach
```

### 4. Camada de Dados (Database)

**Escolha do PostgreSQL:**
- Suporte a tipos geográficos (PostGIS - futuro)
- Robusto para produção
- Amplamente usado em empresas
- Gratuito no Heroku

**Schema:**
```sql
beaches
  - id, name, latitude, longitude
  - city, state, country
  - difficulty_level, beach_type
  - timestamps

surf_conditions
  - id, beach_id (FK)
  - wave_height, wave_period, wave_direction
  - wind_speed, wind_direction
  - water_temperature
  - timestamps
```

## 🔄 Fluxo de Dados

### 1. Busca por Localização

```
User clicks "Usar Minha Localização"
    ↓
Browser Geolocation API retorna lat/lng
    ↓
JavaScript faz redirect com ?lat=X&lng=Y
    ↓
BeachesController#index processa parâmetros
    ↓
Model Beach calcula distâncias
    ↓
View renderiza praias ordenadas por proximidade
```

### 2. Exibição de Condições

```
User acessa /beaches/:id
    ↓
BeachesController#show busca praia
    ↓
Model Beach.current_conditions retorna última condição
    ↓
SurfCondition calcula qualidade do swell
    ↓
View renderiza cards com condições formatadas
```

## 🎯 Decisões Técnicas Importantes

### 1. Geolocalização Client-Side

**Por quê?**
- Mais precisa (usa GPS do dispositivo)
- Não requer API key externa
- Funciona offline após permissão

**Trade-off:** Requer permissão do usuário

### 2. Cálculo de Distância no Modelo

**Implementação:**
```ruby
def distance_from(lat, lng)
  # Fórmula de Haversine
  # Calcula distância em km entre dois pontos geográficos
end
```

**Por quê?**
- Lógica de negócio pertence ao modelo
- Reutilizável em diferentes contextos
- Testável unitariamente

**Futuro:** Migrar para PostGIS para queries mais eficientes

### 3. Seeds com Dados Reais

**Por quê?**
- Demonstra o app funcionando imediatamente
- Dados brasileiros (mercado local)
- Praias conhecidas (fácil validação)

### 4. Partials Reutilizáveis

```erb
<%= render partial: 'beach_card', locals: { beach: beach } %>
```

**Vantagens:**
- DRY (Don't Repeat Yourself)
- Facilita manutenção
- Componentes testáveis

## 🚀 Performance e Otimizações

### 1. Eager Loading

```ruby
@beaches = Beach.includes(:surf_conditions).all
```
Evita N+1 queries ao buscar condições de várias praias.

### 2. Indexes no Banco

```ruby
add_index :beaches, [:latitude, :longitude]
add_index :surf_conditions, [:beach_id, :created_at]
```

### 3. Scopes no Model

```ruby
scope :near, ->(lat, lng, distance) { ... }
```
Queries reutilizáveis e legíveis.

## 🔐 Segurança

### 1. CSRF Protection
Rails inclui por padrão proteção contra CSRF.

### 2. SQL Injection Prevention
Active Record sanitiza queries automaticamente.

### 3. Mass Assignment Protection
Strong parameters no controller.

## 🧪 Estratégia de Testes

### Testes de Modelo
- Validações
- Métodos de cálculo
- Associações

### Testes de Controller (futuro)
- Rotas funcionam
- Respostas corretas
- Parâmetros aceitos

### Testes de Integração (futuro)
- Fluxos completos
- JavaScript funcionando

## 📈 Escalabilidade

### Limitações Atuais
- Cálculo de distância in-memory (não escala para milhares de praias)
- Sem cache
- Sem paginação

### Melhorias Futuras

1. **PostGIS para queries geográficas:**
```sql
SELECT * FROM beaches 
WHERE ST_DWithin(location::geography, ST_Point(lng, lat)::geography, 50000)
ORDER BY ST_Distance(location::geography, ST_Point(lng, lat)::geography);
```

2. **Redis para cache:**
```ruby
Rails.cache.fetch("beach_conditions_#{beach.id}", expires_in: 1.hour) do
  beach.current_conditions
end
```

3. **Background jobs para atualizar condições:**
```ruby
UpdateSurfConditionsJob.perform_later
```

4. **CDN para assets:**
```ruby
config.asset_host = 'https://cdn.example.com'
```

## 🎓 Conceitos Demonstrados

Este projeto demonstra conhecimento em:

✅ **Ruby on Rails MVC**
✅ **Active Record ORM**
✅ **RESTful API design**
✅ **Database modeling**
✅ **Frontend development (HTML/CSS/JS)**
✅ **Geolocalização**
✅ **Responsive design**
✅ **Git e versionamento**
✅ **Testing (RSpec)**
✅ **Deployment (Heroku)**

## 🔄 Próximas Iterações

1. **v2.0**: Integração com API real de surf
2. **v2.1**: Autenticação e favoritos
3. **v2.2**: Previsão de 7 dias
4. **v2.3**: PWA e notificações
5. **v2.4**: Upload de fotos

---

**Mantido por:** [Seu Nome]  
**Última atualização:** Janeiro 2024
