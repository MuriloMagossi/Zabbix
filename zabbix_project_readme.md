# Zabbix CI/CD Automático com GitHub Actions e Harbor

Este projeto demonstra a implementação de uma esteira completa de **CI/CD (Integração e Entrega Contínuas)** utilizando **GitHub Actions**, um repositório de imagens privado (**Harbor**) e a orquestração de contêineres (**Docker Compose**) para realizar o deploy automatizado de uma stack de monitoramento do **Zabbix**.

Todo o ambiente foi projetado para rodar localmente utilizando o subsistema Windows para Linux (WSL), servindo como um laboratório prático de práticas DevOps e Infraestrutura como Código (IaC).

## Arquitetura do Projeto

A esteira de automação segue o seguinte fluxo:
1. **Desenvolvimento:** O código (`Dockerfile` e `docker-compose.yml`) é alterado e enviado ao GitHub via `git push`.
2. **GitHub Actions:** A nuvem do GitHub recebe o código e aciona a pipeline definida em `.github/workflows/deploy.yml`.
3. **Self-Hosted Runner:** Um agente local (instalado no WSL) recebe os comandos do GitHub e executa as tarefas na própria máquina hospedeira.
4. **Linting & Testes:** A sintaxe do `Dockerfile` é validada utilizando o `hadolint` para garantir boas práticas.
5. **Build & Push:** O Runner constrói uma imagem customizada do Zabbix Server (configurando fuso horário local) e faz o envio (Push) para o **Harbor Local**.
6. **Deploy:** O Runner baixa a nova imagem do Harbor e utiliza o `docker compose up -d` para provisionar o banco de dados PostgreSQL, o Zabbix Server e a interface Web (Nginx).

## Tecnologias Utilizadas

*   **GitHub Actions:** Orquestração da pipeline de CI/CD.
*   **Docker & Docker Compose:** Containerização e gerenciamento da infraestrutura.
*   **Harbor:** Container Registry privado para armazenamento seguro das imagens geradas.
*   **Zabbix:** Plataforma de monitoramento open-source.
*   **PostgreSQL:** Banco de dados relacional para a stack do Zabbix.
*   **Ubuntu (WSL):** Sistema operacional base para o laboratório.

## Pré-requisitos para Execução

Para rodar este projeto na sua máquina local, você precisará ter instalado e configurado no seu ambiente Linux/WSL:

1. **Docker Engine e Docker Compose** instalados e rodando.
2. **Harbor** rodando localmente (acessível via `localhost`).
3. **GitHub Self-Hosted Runner** configurado no seu repositório e em execução (`./run.sh`).
4. Arquivo `/etc/docker/daemon.json` configurado para aceitar o Harbor local como um *insecure-registry*:
   ```json
   { "insecure-registries":["localhost", "127.0.0.1"] }
   ```

### Variáveis e Secrets (GitHub)
Você precisará configurar os seguintes **Secrets** no repositório do GitHub (*Settings > Secrets and variables > Actions*):
*   `HARBOR_USER`: Seu usuário do Harbor local (ex: `admin`).
*   `HARBOR_PASSWORD`: Sua senha do Harbor local.

## Como Executar

Por se tratar de um ambiente automatizado, você não precisa iniciar o Zabbix manualmente. Siga os passos:

1. Clone o repositório no seu ambiente WSL:
   ```bash
   git clone https://github.com/murilomagossi/Zabbix
   cd Zabbix
   ```
2. Faça qualquer alteração nos arquivos ou simplesmente force um commit para acionar a pipeline:
   ```bash
   git commit --allow-empty -m "Aciona pipeline de deploy"
   git push origin main
   ```
3. Acompanhe a aba **Actions** no GitHub. A pipeline passará pelos estágios de **Test**, **Build** e **Deploy**.
4. Quando a pipeline finalizar (status verde), acesse a interface web do Zabbix pelo navegador:
   * **URL:** `http://localhost:8080`
   * **Usuário:** `Admin`
   * **Senha:** `zabbix`

## Limpeza do Ambiente (Tear Down)

Para parar e remover todos os contêineres e volumes gerados pelo projeto, execute na raiz do repositório local:
```bash
docker compose down -v
```
*(Nota: O uso da flag `-v` removerá o volume nomeado `zabbix-db-data`, apagando o banco de dados. Remova a flag se quiser preservar o histórico do Zabbix).*