# Yuph

### O que é a Yuph?

Sabe as coisas que você ama, mas podiam ser melhores ou as que você quer, mas não existem? Acreditamos que através de compartilhamento e discussão com outras pessoas, as chances destas ideias se tornarem realidade são muito maiores. Por isso criamos uma rede social de brainstorm. Um lugar para você compartilhar ideias, desde as mais banais até as mais complexas, iniciar discussões, receber feedback e deixar a comunidade fazer a parte dela.

Leia mais na [wiki](https://github.com/Yuph/Yuph/wiki/O-projeto)

### Começando a desenvolver

Estamos usando o [rbenv](https://github.com/sstephenson/rbenv) para controlar a versão do Ruby. A versão usada é a 2.0.0-rc2 e pode ser instalada com o [ruby-build](https://github.com/sstephenson/rbenv#installing-ruby-versions). Depois de instalada:

 * Instale as dependências:

    $ # Instale o postgresql

    $ bundle

 * Crie os bancos de dados

    $ sudo -u postgres psql

    $ postgres=# create user yuph with password 'suasenha';

    $ postgres=# create database yuph_development owner yuph;

    $ postgres=# create database yuph_production owner yuph;

    $ postgres=# create database yuph_test owner yuph;

 * Rode as migrações

    $ bundle exec rake db:migrate

 * Para usar o servidor do AmazonS3 para o upload de imagens crie essas duas variáveis de ambiente com os seus dados de acesso do Amazon: `AWS_SECRET_ACCESS_KEY`, `AWS_ACCESS_KEY_ID'

 * Inicie o servidor

    $ rails s

 * Opcionalmente rode os testes:

    $ bundle exec rake spec

### Deployment

#### Heroku

Em breve

#### Amazon

Em breve