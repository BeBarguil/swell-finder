# 🚀 Guia de Início Rápido - Surf Spot Finder

Este guia vai te ajudar a ter o projeto rodando em menos de 5 minutos!

## 📋 Checklist Rápido

```bash
# 1. Clone o projeto
git clone https://github.com/seu-usuario/surf-spot-finder.git
cd surf-spot-finder

# 2. Instale dependências
bundle install

# 3. Configure banco de dados
# Edite config/database.yml com suas credenciais PostgreSQL
rails db:create db:migrate db:seed

# 4. Rode o servidor
rails server

# 5. Acesse http://localhost:3000
```

## 🐳 Usando Docker (Opcional)

Se preferir usar Docker:

```bash
# Build
docker-compose build

# Rode
docker-compose up

# Setup banco
docker-compose run web rails db:create db:migrate db:seed
```

## 🌐 Deploy no Heroku

```bash
# Login no Heroku
heroku login

# Crie app
heroku create seu-surf-spot-finder

# Adicione PostgreSQL
heroku addons:create heroku-postgresql:hobby-dev

# Deploy
git push heroku main

# Rode migrations
heroku run rails db:migrate db:seed

# Abra o app
heroku open
```

## ⚡ Comandos Úteis

```bash
# Resetar banco de dados
rails db:reset

# Rodar testes
bundle exec rspec

# Console Rails
rails console

# Ver rotas
rails routes

# Limpar cache
rails tmp:clear
```

## 🐛 Troubleshooting

### Erro de conexão com PostgreSQL
```bash
# Verifique se PostgreSQL está rodando
sudo service postgresql status

# Inicie se necessário
sudo service postgresql start
```

### Erro de permissões
```bash
# Dê permissão aos arquivos
chmod +x bin/*
```

### Erro de gems
```bash
# Limpe bundle e reinstale
bundle clean --force
bundle install
```

## 📚 Próximos Passos

1. ✅ Explore a interface
2. ✅ Teste a geolocalização
3. ✅ Veja os detalhes das praias
4. ✅ Customize os dados no `db/seeds.rb`
5. ✅ Adicione suas próprias praias!

## 💡 Dicas

- Use o Chrome ou Firefox para melhor compatibilidade com geolocalização
- Permita acesso à localização quando solicitado
- Os dados de seed são ficcionais - integre com uma API real de surf!
- Explore o código em `app/models` para entender a lógica

## 🎯 Features Para Implementar

Ideias para expandir o projeto:

1. [ ] Integrar com API real de surf (Stormglass, Surfline)
2. [ ] Adicionar autenticação de usuários
3. [ ] Sistema de favoritos
4. [ ] Previsão de 7 dias
5. [ ] Notificações push
6. [ ] Upload de fotos das praias
7. [ ] Sistema de ratings
8. [ ] Mapa interativo

---

🏄‍♂️ **Boas ondas e bom código!**
