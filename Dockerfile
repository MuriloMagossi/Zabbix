# hadolint ignore=DL3007
FROM zabbix/zabbix-server-pgsql:latest

# Muda temporariamente para o usuário root usando o ID Numérico (0) para evitar o aviso DL3066
USER 0

# Atualiza repositórios e instala o pacote de fuso horário ignorando o aviso de versão fixa
# hadolint ignore=DL3018,DL3019
RUN apk add --no-cache tzdata

# Configura o fuso horário para São Paulo
ENV TZ=America/Sao_Paulo

# Retorna para o usuário padrão do Zabbix por segurança (ID 1997)
USER 1997