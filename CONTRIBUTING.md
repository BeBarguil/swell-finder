# 🤝 Guia de Contribuição

Obrigado por considerar contribuir para o Surf Spot Finder! Este documento fornece diretrizes para contribuição.

## 📋 Código de Conduta

- Seja respeitoso e inclusivo
- Aceite críticas construtivas
- Foque no que é melhor para a comunidade
- Mostre empatia com outros contribuidores

## 🚀 Como Contribuir

### Reportar Bugs

Antes de reportar um bug, verifique se já não foi reportado em [Issues](https://github.com/seu-usuario/surf-spot-finder/issues).

**Template de Bug Report:**

```markdown
**Descrição:**
[Descrição clara do bug]

**Passos para Reproduzir:**
1. Vá para '...'
2. Clique em '....'
3. Role até '....'
4. Veja o erro

**Comportamento Esperado:**
[O que deveria acontecer]

**Comportamento Atual:**
[O que está acontecendo]

**Screenshots:**
[Se aplicável]

**Ambiente:**
- OS: [e.g. Ubuntu 22.04]
- Browser: [e.g. Chrome 120]
- Ruby Version: [e.g. 3.2.0]
- Rails Version: [e.g. 7.1.0]
```

### Sugerir Features

**Template de Feature Request:**

```markdown
**Problema que esta feature resolve:**
[Descrição clara do problema]

**Solução Proposta:**
[Como você imagina que isso funcionaria]

**Alternativas Consideradas:**
[Outras soluções que você pensou]

**Contexto Adicional:**
[Screenshots, mockups, etc]
```

### Contribuir com Código

1. **Fork o repositório**

2. **Clone seu fork**
```bash
git clone https://github.com/seu-usuario/surf-spot-finder.git
cd surf-spot-finder
```

3. **Crie uma branch**
```bash
git checkout -b feature/nome-da-feature
# ou
git checkout -b fix/nome-do-bug
```

**Convenção de nomes de branches:**
- `feature/` - Nova funcionalidade
- `fix/` - Correção de bug
- `docs/` - Apenas documentação
- `refactor/` - Refatoração de código
- `test/` - Adicionar testes

4. **Rode o setup**
```bash
./bin/setup
```

5. **Faça suas alterações**

6. **Adicione testes**
```ruby
# spec/models/sua_feature_spec.rb
RSpec.describe SuaFeature do
  it 'faz o que deveria fazer' do
    # seu teste aqui
  end
end
```

7. **Rode os testes**
```bash
bundle exec rspec
```

8. **Commit suas mudanças**
```bash
git add .
git commit -m "feat: adiciona feature X"
```

**Convenção de Commits (Conventional Commits):**
- `feat:` - Nova feature
- `fix:` - Correção de bug
- `docs:` - Documentação
- `style:` - Formatação
- `refactor:` - Refatoração
- `test:` - Testes
- `chore:` - Manutenção

**Exemplos:**
```bash
git commit -m "feat: adiciona sistema de favoritos"
git commit -m "fix: corrige cálculo de distância"
git commit -m "docs: atualiza README com instruções de deploy"
git commit -m "test: adiciona testes para BeachesController"
```

9. **Push para seu fork**
```bash
git push origin feature/nome-da-feature
```

10. **Abra um Pull Request**

**Template de Pull Request:**

```markdown
## Descrição
[Descrição clara das mudanças]

## Tipo de Mudança
- [ ] Bug fix
- [ ] Nova feature
- [ ] Breaking change
- [ ] Documentação

## Checklist
- [ ] Meu código segue o style guide do projeto
- [ ] Fiz self-review do código
- [ ] Comentei código complexo
- [ ] Atualizei a documentação
- [ ] Minhas mudanças não geram novos warnings
- [ ] Adicionei testes que provam que meu fix funciona
- [ ] Testes novos e existentes passam localmente

## Screenshots (se aplicável)
[Screenshots das mudanças]

## Issues Relacionadas
Fixes #123
```

## 💻 Guia de Estilo

### Ruby/Rails

**Use o Rubocop:**
```bash
bundle exec rubocop
```

**Convenções:**

```ruby
# BOM
def calculate_distance(latitude, longitude)
  # código aqui
end

# RUIM
def calc_dist(lat, lng)
  # código aqui
end
```

- Use nomes descritivos
- Métodos com no máximo 10 linhas
- Classes com responsabilidade única
- Sempre adicione testes

### JavaScript

```javascript
// BOM
const getUserLocation = () => {
  // código aqui
};

// RUIM
function getLoc() {
  // código aqui
}
```

- Use `const` e `let`, evite `var`
- Arrow functions quando possível
- Nomes descritivos em camelCase

### CSS/Tailwind

```html
<!-- BOM -->
<div class="bg-blue-600 hover:bg-blue-700 text-white p-4 rounded-lg">

<!-- RUIM -->
<div class="bg-blue-600 hover:bg-blue-700 text-white padding-4 rounded-large">
```

- Use classes utility do Tailwind
- Seja consistente com espaçamento
- Mobile-first approach

## 🧪 Testes

**Todo código novo deve ter testes!**

### Models

```ruby
RSpec.describe Beach do
  describe '#distance_from' do
    it 'calcula distância corretamente' do
      beach = Beach.new(latitude: -23, longitude: -43)
      distance = beach.distance_from(-22, -43)
      expect(distance).to be > 0
    end
  end
end
```

### Controllers

```ruby
RSpec.describe BeachesController do
  describe 'GET #index' do
    it 'retorna sucesso' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
```

### Coverage

Mantenha cobertura de testes acima de 80%.

```bash
bundle exec rspec --format documentation
```

## 📝 Documentação

- Atualize README.md se necessário
- Adicione comentários em código complexo
- Documente decisões arquiteturais em ARCHITECTURE.md
- Atualize CHANGELOG.md (seguindo [Keep a Changelog](https://keepachangelog.com/))

## 🔍 Code Review

Todos os PRs passam por code review. Esperamos:

- ✅ Código limpo e legível
- ✅ Testes passando
- ✅ Sem conflitos com main
- ✅ Descrição clara do PR
- ✅ Screenshots se houver mudanças visuais

## 🎯 Prioridades

Áreas onde contribuições são especialmente bem-vindas:

1. **Testes** - Aumentar cobertura
2. **Documentação** - Melhorar docs
3. **Performance** - Otimizações
4. **UI/UX** - Melhorias de interface
5. **Acessibilidade** - WCAG compliance

## 💬 Dúvidas?

- Abra uma [Issue](https://github.com/seu-usuario/surf-spot-finder/issues)
- Entre em discussões existentes
- Mande email: seu.email@exemplo.com

## 🙏 Agradecimentos

Obrigado por contribuir! Toda ajuda é muito apreciada. 🏄‍♂️

---

**Lembre-se:** Código é escrito uma vez, mas lido muitas vezes. Escreva pensando em quem vai ler!
