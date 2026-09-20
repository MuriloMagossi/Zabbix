FROM zabbix/zabbix-server-pgsql:latest

# Muda temporariamente para o usuário root para instalar pacotes
USER root

# Atualiza repositórios e instala o pacote de fuso horário
RUN apk update && apk add --no-cache tzdata

# Configura o fuso horário para São Paulo
ENV TZ=America/Sao_Paulo

# Retorna para o usuário padrão do Zabbix por segurança (ID 1997)
USER 1997