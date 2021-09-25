# README
## RailsDockerBase Server

### Inicialização

Optei pela utilização do docker, para que possa ser rodado com qualquer maquina. Para iniciar o projeto rodar o comando abaixo, esse processo pode demorar um pouco para até montar o docker e baixar as gems
```bash
docker-compose up
```

Depois de iniciado, para utilização da primeira vez, é necessário realizar o bundle, e as ações do banco com os comandos abaixo:
```bash
docker-compose run server bundle install
```
```bash
docker-compose run server rake db:create && docker-compose run server rake db:migrate && docker-compose run server rake db:seed
```

### Testes
Para rodar os testes é necessário realizar as ações do banco de teste:
```bash
docker-compose run server rake db:create RAILS_ENV=test && docker-compose run server rake db:migrate RAILS_ENV=test && docker-compose run server rake db:seed RAILS_ENV=test
```
Para rodar os testes:

```bash
docker-compose run server rspec
```
