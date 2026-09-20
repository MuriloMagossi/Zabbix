# Guia de Inicialização do Ambiente

## 1. Inicie o Serviço do Docker
No terminal do WSL, inicie o daemon do Docker:

```bash
sudo service docker start
```

---

## 2. Suba o Harbor (Registry Privado)
Navegue até a pasta de infraestrutura do Harbor e suba os containers com privilégios de administrador:

```bash
cd ~/projeto/harbor
sudo docker compose up -d
```

> *(Aguarde cerca de 20 a 30 segundos para que o banco de dados interno do Harbor inicialize totalmente).*

---

## 3. Ative o GitHub Runner (O Operário)
Inicie o agente de execução do GitHub Actions para que ele volte a escutar as demandas da sua pipeline:

```bash
cd ~/projeto/actions-runner
./run.sh
```

> *(Deixe esta janela do terminal aberta exibindo a mensagem "Listening for Jobs").*

---

## 4. Dispare a Esteira no GitHub
Com a máquina online, o *Job Olheiro* da pipeline detectará o seu Runner ativo. Para colocar o Zabbix no ar:

1. Acesse o seu repositório no GitHub.
2. Vá até a aba **Actions**.
3. Selecione a última execução bem-sucedida.
4. No canto superior direito, clique em **Re-run jobs > Re-run all jobs**.

---

## 🌐 Endpoints de Acesso

### **Zabbix Web UI**
* **URL:** [http://localhost:8080](http://localhost:8080)
* **Usuário:** `Admin`
* **Senha:** `zabbix`

### **Harbor Registry**
* **URL:** [http://localhost](http://localhost)
* **Usuário:** `admin`