# Models

Modelos da aplicação, um diagrama de suas relações e atributos pode ser visto [aqui](https://dl.dropboxusercontent.com/u/2701879/uploads/yuph/models_complete.svg) e uma versão mais simples [aqui](https://dl.dropboxusercontent.com/u/2701879/uploads/yuph/models_brief.svg).

## Ability

Usando cancancan (https://github.com/CanCanCommunity/cancancan). Define as
ações que um usuário está autorizado a realizar nos diversos modelos.

## User ( app/models/user.rb )

Usa devise (https://github.com/plataformatec/devise) para autenticação

### Atributos:

* email, dados de login, login com facebook

### Associações

  profile_id: Perfil com mais dados do usuário

## Profile ( app/models/profile.rb )

### Atributos:

* nick, first_name, ...
* image_file_name (imagem no AWS)

## Idea ( app/models/idea.rb )

### Atributos:

* name, description, mini_description
* image_file_name (imagem no AWS)

### Associações:

* idea_admins: Pertence a um User a partir do IdeaAdmin
* follows: denota que um usuário segue uma ideia

## IdeaAdmin

### Atributos:

* user_id
* idea_id

## IdeaComment

### Atributos:

### Associações:

## Category

## Post

## PostComment

## Notification

# Views

## Compilar assets

Fazer isto antes de adicionar features novas no CSS

    $ rake assets:precompile

E também simular fazer em produção

    $ RAILS_ENV=production rake assets:precompile

Isso garante que não haverão erros de assets em produção.

# Testes

## Como rodar

Limpa o banco de dados, roda o `db:seed` e roda todos testes

    $ rake

Roda todos os testes

    $ rake spec

Roda um teste específico

    $ rake spec spec/models/user_spec.rb

# Outros

* Interface de admin ( https://github.com/barsukov/rails_admin )
* Paginação ( https://github.com/amatsuda/kaminari )
* Paperclip e Aws ( https://github.com/thoughtbot/paperclip )
* Atividade Recente ( https://github.com/pokonski/public_activity )
* Omniauth ( https://github.com/intridea/omniauth )