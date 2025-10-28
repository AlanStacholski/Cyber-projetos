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
