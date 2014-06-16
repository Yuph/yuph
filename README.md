# Yuph

![travis-ci](https://travis-ci.org/Yuph/yuph.svg)

### O que é a Yuph?

Sabe as coisas que você ama, mas podiam ser melhores ou as que você quer, mas não existem? Acreditamos que através de compartilhamento e discussão com outras pessoas, as chances destas ideias se tornarem realidade são muito maiores. Por isso criamos uma rede social de brainstorm. Um lugar para você compartilhar ideias, desde as mais banais até as mais complexas, iniciar discussões, receber feedback e deixar a comunidade fazer a parte dela.

Leia mais na [wiki](https://github.com/Yuph/Yuph/wiki/O-projeto)

### Documentação para desenvolvimento

 * [No github](https://github.com/Yuph/yuph/tree/master/doc)

### Começando a desenvolver

Estamos usando o [rbenv](https://github.com/sstephenson/rbenv) para controlar a versão do Ruby. A versão usada é a 2.0.0-rc2 e pode ser instalada com o [ruby-build](https://github.com/sstephenson/rbenv#installing-ruby-versions). Depois de instalada:

 * Instale as dependências:

    $ # Instale o postgresql

    $ bundle

 * Crie os bancos de dados

    $ sudo -u postgres psql

    $ postgres=# create user yuph with password 'yuph';

    $ postgres=# create database yuph_development owner yuph;

    $ postgres=# create database yuph_production owner yuph;

    $ postgres=# create database yuph_test owner yuph;

 * Rode as migrações

    $ bundle exec rake db:migrate

 * Inicie o servidor

    $ rails s

 * Opcionalmente rode os testes:

    $ bundle exec rake spec

### Configurações extras e variáveis de ambiente

 * Para usar o servidor do AmazonS3 para o upload de imagens crie essas duas variáveis de ambiente com os seus dados de acesso do Amazon: `AWS_SECRET_ACCESS_KEY`, `AWS_ACCESS_KEY_ID` e uma outra chamada `S3_BUCKET_NAME` com o nome do seu bucket no Amazon. Essas são usadas para imagens de usuários e ideias.

 * Para usar logins com o Facebook use as variáveis de ambiente `FACEBOOK_APP_ID` e `FACEBOOK_APP_SECRET` com os dados do seu aplicativo de Facebook e também não se esqueça de configurar o url de callback (veja [aqui](http://stackoverflow.com/a/20465258/414642))

 * Para configurar o envio de emails use as variáveis de ambiente `RAILS_SMTP_USER`, `RAILS_SMTP_PASSWORD` e `RAILS_SMTP_SERVER`. Também use a variável `RAILS_PRODUCTION_HOST` com o endereço da sua aplicação para que os links mandados dentro dos emails sejam corretos. Veja [aqui](https://github.com/Yuph/yuph/blob/master/config/environments/production.rb#L66) e [aqui](https://github.com/Yuph/yuph/blob/master/config/environments/production.rb#L71).

 * Use a variável de ambiente `GA_TRACKER_CODE` para o seu código de Google Analytics

### Deployment

#### Heroku

Em breve

#### Amazon

Em breve