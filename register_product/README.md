# README

Aplicação para estudo de microsserviços utilizando "somente" a gem [Bunny](https://github.com/ruby-amqp/bunny) tanto para publicar como para consumir mensagens. Cadastro de produtos e envio destas informações para uma espécie de estoque.

* Ruby on Rails 7.0.5 (Ruby 3.2.1)

* Instalação do [RabbitMQ](https://www.rabbitmq.com/download.html). Necessário para rodar o projeto, se desejar utilizar um serviço na nuvem, recomendo o [CloudAMQP](https://www.cloudamqp.com/). Porém neste projeto rodei tudo local, verificando o tráfego de mensagens via UI do RabbitMQ, veja [aqui](https://www.rabbitmq.com/management.html#getting-started) como instalar.

## Simbora!

A publicação é a parte mais simples, a criação do código pode ser um serviço, no caso você encontrará em **app/services/publisher.rb**. As informação das filas, por exemplo, já deixei fixadas, mas você pode configurar uma ou mais filas. Passando somente como argumento a mensagem, ou seja, o payload neste caso. Lembrando que é necessário fazer o parse para json antes do envio.

Após a criação, utilizei o callback no model de product para chamar o serviço de publicação após a criação do produto, enviando somente os parâmetros que são do meu interesse para a outra aplicação. Uma espécie de stock.

Você pode criar um hash e enviar os parâmetros via *rails console*, ou pode fazer uma requisição via client (insomnia, postman, etc). Porém atráves da requisição ele percorrerá o fluxo normal.

Basicamente, configuração da gem Bunny e a chamada do serviço para o envio de mensagem.
