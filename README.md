# Aliato Project Manager

Aplicação para gerenciamento de projetos de clientes.

Esta aplicação foi desenvolvida como parte do Projeto Integrador (PI) da UNIVESP.

## Pré-requisitos

Certifique-se de ter os seguintes itens instalados em sua máquina:

- **Ruby 3.2.2**: Necessário para executar a aplicação Rails.
- **Docker**: Para containerização.
- **Docker Compose**: Para gerenciar aplicações Docker multi-contêiner.

## Começando

Siga estes passos para iniciar a aplicação:

1. **Clone o repositório:**

   ```sh
   git clone https://github.com/mario-adriano/aliato-project-manager.git

2. **Construa e execute os contêineres Docker:**

   ```sh
   sudo docker-compose up

3. **Construa o banco:**

   ```sh
   rails db:create

4. **Para migrar o banco:**

  ```sh
  rails db:migrate

5. **Inicie o servidor Rails:**

   ```sh
   rails s

A aplicação deverá estar acessível em http://localhost:3000.
