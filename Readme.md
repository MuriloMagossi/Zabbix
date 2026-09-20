Fazer um CI/CD

Para subir uma infra zabbix e monitorar um server linux

Fazendo o teste e subindo toda a infra

Aqui está a estrutura do projeto organizada em um passo a passo lógico para a implementação da sua pipeline.

### 1. Definição da Arquitetura e Ambiente

* **Infraestrutura:** Para este laboratório, você pode utilizar uma única máquina para hospedar o Runner e também para receber o deploy.


* **Justificativa do Setup:** Como boas práticas ditam o uso de máquinas separadas para essas funções no cenário de produção, mantenha o discurso alinhado para explicar que essa concentração em uma única máquina ocorre por ser um ambiente interno de estudos e sem recursos dedicados.



### 2. Escolha do Alvo do Deploy

* **Opção A (Foco em Infra/Monitoramento):** Criar uma pipeline que suba o Zabbix para monitorar o próprio servidor. (Escolher opção A)


* **Opção B (Foco em Frontend):** Fazer o deploy de uma aplicação frontend simples, que pode ser gerada com o auxílio de IA (como o ChatGPT).



### 3. Preparação das Ferramentas

* **Repositório:** Inicie o projeto utilizando o GitLab, que é a plataforma de preferência para o controle de versão e CI/CD.


* **GitLab Runner:** Instale e registre o Runner na sua máquina. Ter o Runner rodando localmente facilitará bastante na hora de explicar o funcionamento interno e o fluxo do projeto.


* **Registry de Imagens:** Configure o Harbor para atuar como o repositório onde as imagens serão armazenadas.



### 4. Estruturação da Pipeline (CI/CD)

O arquivo da pipeline deverá ser dividido em três estágios (stages) principais:

* **Stage de Teste:** Execute testes básicos para validar o funcionamento do código ou da imagem gerada, como por exemplo, garantir que uma base em Java (ou outra linguagem escolhida) esteja correta antes de avançar.


* **Stage de Build:** Configure o runner para construir a imagem da aplicação. Após a construção, a pipeline deve realizar o login e enviar (push) essa imagem finalizada para o Harbor.


* **Stage de Deploy:** Insira os comandos para que a máquina de destino baixe (pull) a imagem do Harbor e execute o deploy da aplicação de forma automatizada.



Se precisar de ajuda com a sintaxe do `.gitlab-ci.yml` ou com a orquestração dos containers ao colocar a mão na massa, é só avisar.jd 