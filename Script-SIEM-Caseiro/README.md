
-----

````markdown
# 🛡️ SIEM Caseiro com ELK Stack (Elasticsearch, Logstash, Kibana)

Este projeto implementa um **mini-SIEM (Security Information and Event Management)** baseado no famoso **ELK Stack** (Elasticsearch, Logstash/Filebeat, e Kibana) para monitoramento e análise de logs em sistemas Linux pessoais.

É uma solução ideal para estudos de **cibersegurança**, **observabilidade** e **monitoramento de eventos locais**, transformando dados brutos em inteligência acionável.

---

## 💡 Componentes do Stack

| Componente | Função Principal |
| :--- | :--- |
| **Elasticsearch** | **Armazenamento:** Banco de dados orientado a busca, responsável por armazenar e indexar logs de forma escalável. |
| **Kibana** | **Visualização:** Interface gráfica para criar dashboards, visualizar e analisar os dados coletados e as tendências de segurança. |
| **Filebeat** | **Coleta (Agente Leve):** Agente de coleta leve (Shipper) que envia logs e métricas do sistema local para o Elasticsearch. |

---

## 🚀 Instalação

Você pode escolher entre o método **manual** para entender cada etapa ou utilizar o **script automatizado** para uma configuração rápida.

### Pré-requisitos

* Sistema Operacional: Linux baseado em **Debian** (ex: Zorin OS, Ubuntu, Mint).
* Acesso e permissões de **sudo**.
* Conexão ativa com a internet.

### ⚡ Opção 1: Instalação Automática com Script (Recomendado)

O script **`install_elk.sh`** executa todas as etapas abaixo de forma automatizada, garantindo a instalação e ativação dos serviços.

1.  Dê permissão de execução e execute o script:
    ```bash
    sudo chmod +x install_elk.sh
    sudo ./install_elk.sh
    ```

> O script cuidará de: instalar dependências, adicionar o repositório da Elastic, instalar os pacotes, e habilitar/iniciar os serviços do Elasticsearch, Kibana e Filebeat.

---

### 🧩 Opção 2: Instalação Manual

Siga os passos abaixo para instalar e configurar o Stack ELK:

#### 1️⃣ Atualize o Sistema e Instale as Dependências
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install apt-transport-https openjdk-11-jdk wget curl -y
````

#### 2️⃣ Adicione o Repositório Oficial da Elastic

```bash
wget -qO - [https://artifacts.elastic.co/GPG-KEY-elasticsearch](https://artifacts.elastic.co/GPG-KEY-elasticsearch) | sudo apt-key add -
echo "deb [https://artifacts.elastic.co/packages/7.x/apt](https://artifacts.elastic.co/packages/7.x/apt) stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
```

#### 3️⃣ Instale os Pacotes Principais

```bash
sudo apt update
sudo apt install elasticsearch kibana filebeat -y
```

#### 4️⃣ Ative e Inicie os Serviços

```bash
# Elasticsearch
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

# Kibana
sudo systemctl enable kibana
sudo systemctl start kibana

# Filebeat
sudo systemctl enable filebeat
sudo systemctl start filebeat
```

#### 5️⃣ Verifique o Status

Confirme se todos os serviços estão ativos (`active (running)`):

```bash
sudo systemctl status elasticsearch
sudo systemctl status kibana
sudo systemctl status filebeat
```

-----

## 🌐 Acessando e Configurando

Após a instalação, os serviços estarão acessíveis via `localhost`.

| Serviço | Endereço | Descrição |
| :--- | :--- | :--- |
| **Kibana** | `http://localhost:5601` | Interface gráfica para começar a visualizar seus logs. |
| **Elasticsearch** | `http://localhost:9200` | API principal. Confirme a instalação com um JSON de resposta. |

### Configuração de Logs (Filebeat)

O Filebeat é o seu agente de coleta. Por padrão, ele monitora logs comuns do sistema em `/var/log/`.

Para ajustar quais diretórios ou tipos de log serão monitorados, edite o arquivo principal de configuração:

```bash
sudo nano /etc/filebeat/filebeat.yml
```

-----

## 🔬 Dica para Testes Rápidos

Para gerar um log artificial e verificar se o Stack está funcionando corretamente, utilize o comando `logger`:

```bash
logger "Teste SIEM Caseiro: Log enviado em $(date)"
```

Em seguida, acesse o **Kibana → Discover** e procure pela mensagem recém-criada.

-----

## 🚨 Nota Importante de Segurança

Este ambiente foi desenvolvido **exclusivamente para fins educacionais e uso pessoal/laboratorial (Homelab)**.

**NÃO** utilize este setup como SIEM corporativo em produção. Ele carece das camadas de segurança, controle de acesso (autenticação), criptografia e redundância necessárias para ambientes empresariais.

-----

## 🧾 Licença

Distribuído sob a licença **MIT**. Sinta-se à vontade para estudar, modificar e aprimorar o projeto.

-----

## 👤 Autor e Referência

**Autor:** Alan Jones Stacholski Júnior
**Base:** Zorin OS 18 (Linux)
**Propósito:** Estudo e prática de observabilidade e cibersegurança pessoal com o stack ELK.

```
```
