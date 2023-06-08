# README

Aplicação para estudo de microsserviços utilizando "somente" a gem [Bunny](https://github.com/ruby-amqp/bunny) tanto para publicar como para consumir mensagens. Cadastro de produtos e envio destas informações para uma espécie de estoque.

* Ruby on Rails 7.0.5 (Ruby 3.2.1)

* Instalação do [RabbitMQ](https://www.rabbitmq.com/download.html). Necessário para rodar o projeto, se desejar utilizar um serviço na nuvem, recomendo o [CloudAMQP](https://www.cloudamqp.com/). Porém neste projeto rodei tudo local, verificando o tráfego de mensagens via UI do RabbitMQ, veja [aqui](https://www.rabbitmq.com/management.html#getting-started) como instalar.

## Simbora!

Aqui nos temos a aplicação que será o consumidor de mensagens, terá seus endpoins específicos, mas nada impede de também ser um publicador.

O consumer precisa ficar escutando na mensageria se há uma nova mensagem para si, uma aplicação que consome pode ficar ouvindo em uma ou várias filas ao mesmo tempo, depende da sua evolução na aplicação.

Para isso, foi necessário utilizar a *gem Foreman* (não é necessário declarar no gemfile, localmente) que está sendo chamada no arquivo *bin/dev* quando se executa o *./bin/dev* com referência do arquivo *Procfile.dev*, ambos os arquivos foram criados manualmente. Estes arquivos são importantes pois manterão o *bin/consumer* ativo na escuta das mensagens.

O consumer está na pasta *bin*, porém pode estar onde você deseja, na lib ou até mesmo em serviço, desde que ele esteja sendo apontado no arquivo *Procfile.dev* para poder estar ativo sempre que o servidor estiver de "pé".

Perceba que no arquivo *bin/consumer* há uma chamada para um serviço, este serviço é responsável pela criação do item no estoque, o item possui um atributo a mais, *quantity*, que é atualizado na própria aplicação após o cadastro do produto. Com isso separamos as responsabilidades do cadastro de produtos e da organização de quantidades no estoque.

Após efetuar o cadastro do produto no *register_product*, este enviará a mensagem para o *stock* que estará ouvindo as mensagens que chegam, e assim cadastrará o *item* com as informações necessárias, e assim, com o método PUT ou via console, você poderá manusear o novo item cadastrado para o estoque e atualizar a quantidade e/ou outros atributos.

Com isso, você terá a base para usar a sua imaginação e estudar um pouco mais sobre microsserviços, material bastante escasso em português para o Ruby on Rails.
