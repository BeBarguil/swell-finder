# 💼 Guia de Entrevista - Surf Spot Finder

Este documento lista perguntas comuns em entrevistas para vagas júnior e como este projeto demonstra as respostas.

## 🎯 Perguntas Técnicas

### Ruby on Rails

**P: Explique o padrão MVC no Rails.**

**R:** Este projeto demonstra claramente o MVC:
- **Models** (`app/models/`): Beach e SurfCondition com lógica de negócio
- **Views** (`app/views/`): ERB templates com Tailwind CSS
- **Controllers** (`app/controllers/`): BeachesController gerencia requisições

**Exemplo prático:**
```ruby
# Controller recebe request
def index
  @beaches = Beach.all  # Model
end
# View renderiza @beaches
```

---

**P: O que são migrations e por que são importantes?**

**R:** Versionamento do schema do banco. No projeto:
```ruby
# db/migrate/xxx_create_beaches.rb
create_table :beaches do |t|
  t.string :name
  t.decimal :latitude
  # ...
end
```

**Benefícios:**
- Versionamento do banco
- Reversível com `rails db:rollback`
- Trabalho em equipe facilitado

---

**P: Como você lida com validações de dados?**

**R:** No modelo Beach:
```ruby
validates :name, presence: true
validates :latitude, numericality: true
validates :difficulty_level, inclusion: { in: %w[beginner intermediate advanced] }
```

**Por quê?**
- Integridade de dados
- Mensagens de erro claras
- Validação antes de salvar no banco

---

**P: Explique Active Record associations.**

**R:** No projeto:
```ruby
# Beach has_many SurfConditions
class Beach < ApplicationRecord
  has_many :surf_conditions, dependent: :destroy
end

# SurfCondition belongs_to Beach
class SurfCondition < ApplicationRecord
  belongs_to :beach
end
```

**Uso:**
```ruby
beach.surf_conditions  # Acessa todas as condições
condition.beach        # Acessa a praia
```

---

### Database

**P: Por que PostgreSQL ao invés de SQLite?**

**R:** 
- ✅ Produção-ready (usado no Heroku)
- ✅ Suporte a tipos avançados (futuro: PostGIS para geo)
- ✅ Melhor performance com muitos dados
- ✅ Mais usado em empresas

---

**P: Como você otimiza queries?**

**R:** 
1. **Eager Loading** para evitar N+1:
```ruby
Beach.includes(:surf_conditions).all
```

2. **Indexes** para busca rápida:
```ruby
add_index :beaches, [:latitude, :longitude]
```

3. **Scopes** para queries reutilizáveis:
```ruby
scope :near, ->(lat, lng) { ... }
```

---

### Frontend

**P: Por que Tailwind ao invés de Bootstrap?**

**R:**
- ✅ Utility-first (mais flexível)
- ✅ Menor bundle size (purge unused CSS)
- ✅ Mais moderno
- ✅ Melhor para customização

**Exemplo:**
```html
<div class="bg-blue-600 hover:bg-blue-700 rounded-lg p-4">
```

---

**P: Como você implementou geolocalização?**

**R:** Usando a Geolocation API do browser:
```javascript
navigator.geolocation.getCurrentPosition(
  (position) => {
    const lat = position.coords.latitude;
    const lng = position.coords.longitude;
    // Redireciona com parâmetros
    window.location.href = `/?lat=${lat}&lng=${lng}`;
  }
);
```

**Trade-offs:**
- ✅ Preciso (usa GPS)
- ❌ Requer permissão
- ✅ Funciona offline

---

### Testes

**P: Como você testa seus modelos?**

**R:** Com RSpec:
```ruby
RSpec.describe Beach do
  it 'is valid with valid attributes' do
    beach = Beach.new(name: 'Teste', latitude: -23, ...)
    expect(beach).to be_valid
  end
  
  it 'calculates distance correctly' do
    distance = beach.distance_from(-22, -43)
    expect(distance).to be > 0
  end
end
```

**Testes cobrem:**
- Validações
- Métodos de negócio
- Associações

---

## 🔧 Perguntas de Arquitetura

**P: Como você estruturaria este app para escalar?**

**R:**
1. **PostGIS** para queries geográficas eficientes
2. **Redis** para cache de condições
3. **Background jobs** (Sidekiq) para atualizar dados
4. **CDN** para assets
5. **Paginação** para muitas praias

---

**P: Como você implementaria autenticação?**

**R:**
```ruby
# Gemfile
gem 'devise'

# Model
class User < ApplicationRecord
  devise :database_authenticatable, :registerable
  has_many :favorite_beaches
end
```

---

**P: Como você integraria com uma API externa?**

**R:**
```ruby
# Service Object
class StormglassService
  include HTTParty
  base_uri 'api.stormglass.io'
  
  def get_surf_data(lat, lng)
    self.class.get('/weather/point', {
      query: { lat: lat, lng: lng },
      headers: { 'Authorization': ENV['STORMGLASS_KEY'] }
    })
  end
end
```

---

## 💡 Perguntas Comportamentais

**P: Conte sobre um desafio técnico que enfrentou.**

**R:** "No Surf Spot Finder, precisei calcular distâncias entre coordenadas geográficas. Inicialmente tentei uma fórmula simples de Pitágoras, mas descobri que não funciona bem para coordenadas geográficas devido à curvatura da Terra.

Pesquisei e implementei a fórmula de Haversine, que considera a Terra como esfera. Testei com localizações conhecidas e validei os resultados. Aprendi a importância de pesquisar o problema antes de implementar e sempre validar resultados."

---

**P: Como você decide quais tecnologias usar?**

**R:** "Para o Surf Spot Finder, escolhi:
- **Rails**: Já conhecia e é rápido para prototipar
- **PostgreSQL**: Produção-ready e suporta geo-queries (futuro)
- **Tailwind**: Moderno e flexível
- **Vanilla JS**: Projeto simples, não precisa de React

Considerei:
1. Requisitos do projeto
2. Escalabilidade futura
3. Adoção no mercado
4. Curva de aprendizado"

---

**P: Como você aprende novas tecnologias?**

**R:** "Neste projeto:
1. Li documentação oficial do Rails
2. Assisti tutoriais sobre Tailwind
3. Implementei features incrementalmente
4. Escrevi testes para validar aprendizado
5. Documentei decisões (ARCHITECTURE.md)

Aprendo melhor fazendo projetos reais com objetivos claros."

---

## 🎨 Demonstrações Práticas

### Show me how you...

**...crio uma nova feature?**

"Vou adicionar sistema de favoritos:

1. **Criar migration:**
```bash
rails g migration CreateFavorites user:references beach:references
rails db:migrate
```

2. **Criar model e associações:**
```ruby
class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :beach
end
```

3. **Adicionar rotas:**
```ruby
resources :beaches do
  post 'favorite', on: :member
end
```

4. **Controller action:**
```ruby
def favorite
  current_user.favorites.create(beach: @beach)
  redirect_to @beach, notice: 'Praia favoritada!'
end
```

5. **View:**
```erb
<%= button_to 'Favoritar', favorite_beach_path(@beach) %>
```

6. **Testar:**
```ruby
it 'allows user to favorite a beach' do
  # ...
end
```

---

**...faço debug?**

"Se um bug aparecer:

1. **Ler erro no terminal/logs**
2. **Usar `rails console` para testar:**
```ruby
beach = Beach.first
beach.current_conditions
```

3. **Adicionar `byebug` no código:**
```ruby
def index
  byebug  # Para aqui
  @beaches = Beach.all
end
```

4. **Verificar logs do Rails:**
```bash
tail -f log/development.log
```

5. **Escrever teste que reproduz o bug**
6. **Fixar e validar com teste**"

---

## 📊 Métricas de Sucesso

**P: Como você mede sucesso de um projeto?**

**R:**
- ✅ **Código:** Clean, testado, documentado
- ✅ **Funcionalidade:** Features funcionam como esperado
- ✅ **Performance:** Tempo de resposta < 200ms
- ✅ **Manutenibilidade:** Outros devs entendem o código
- ✅ **Deploy:** Funciona em produção

**Neste projeto:**
- 9 praias cadastradas
- Testes passando (models)
- README completo
- Deploy-ready (Heroku)
- Geo-localização funcional

---

## 🚀 Próximos Passos

Para impressionar em entrevista:

1. ✅ **Adicione mais testes** (coverage > 80%)
2. ✅ **Integre API real de surf**
3. ✅ **Deploy no Heroku** (tenha URL rodando)
4. ✅ **Adicione CI/CD** (GitHub Actions)
5. ✅ **Documente no README** cada feature

---

**Dica Final:** Sempre tenha o projeto rodando durante a entrevista para demonstrar ao vivo!
