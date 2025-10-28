# 🖥️ SIEM Caseiro com ELK Stack (Elasticsearch, Kibana e Filebeat)

Este projeto implementa um **mini-SIEM (Security Information and Event Management)** baseado no **ELK Stack** para monitoramento e análise de logs em sistemas Linux pessoais.  
Ideal para estudos de **cibersegurança**, **observabilidade** e **monitoramento de eventos locais**.

---

## 📦 Componentes Principais

| Componente | Função |
|-------------|--------|
| **Elasticsearch** | Banco de dados orientado a busca, responsável por armazenar e indexar logs. |
| **Kibana** | Interface gráfica para visualização e análise dos dados coletados. |
| **Filebeat** | Agente de coleta leve que envia logs do sistema para o Elasticsearch. |

---

## ⚙️ Instalação do Stack ELK

Você pode seguir o processo **manual** descrito abaixo ou simplesmente executar o **script automatizado `install_elk.sh`**, que realiza toda a instalação por você.

---

### 🧰 Requisitos

- Linux baseado em **Debian** (Zorin OS, Ubuntu, Mint etc.)
- Permissões de **sudo**
- Conexão com a internet
- (Opcional) Conhecimento básico em terminal Linux

---

### 🧩 Instalação Manual

#### 1️⃣ Atualize o sistema
```bash
sudo apt update && sudo apt upgrade -y
````

#### 2️⃣ Instale dependências necessárias

```bash
sudo apt install apt-transport-https openjdk-11-jdk wget curl -y
```

#### 3️⃣ Adicione o repositório oficial da Elastic

```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
```

#### 4️⃣ Atualize os repositórios e instale os pacotes

```bash
sudo apt update
sudo apt install elasticsearch kibana filebeat -y
```

#### 5️⃣ Ative e inicie os serviços

```bash
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

sudo systemctl enable kibana
sudo systemctl start kibana

sudo systemctl enable filebeat
sudo systemctl start filebeat
```

#### 6️⃣ Verifique se os serviços estão rodando

```bash
sudo systemctl status elasticsearch
sudo systemctl status kibana
sudo systemctl status filebeat
```

#### 7️⃣ (Opcional) Configure o Filebeat para enviar logs locais

O arquivo de configuração principal do Filebeat está localizado em:

```bash
/etc/filebeat/filebeat.yml
```

Você pode editar este arquivo para definir quais diretórios ou tipos de log serão monitorados.
Por exemplo:

```bash
sudo nano /etc/filebeat/filebeat.yml
```

---

### ⚡ Instalação Automática com Script

Para simplificar o processo, foi criado o script **`install_elk.sh`**, que executa todos os comandos acima automaticamente.

Execute:

```bash
sudo chmod +x install_elk.sh
sudo ./install_elk.sh
```

O script cuidará de:

* Instalar dependências;
* Adicionar o repositório da Elastic;
* Instalar e habilitar os serviços do Elasticsearch, Kibana e Filebeat;
* E verificar automaticamente se os serviços estão ativos.

---

## 🌐 Acessando os Serviços

Após a instalação, verifique se os serviços estão rodando corretamente:

**Kibana (interface web):**

```
http://localhost:5601
```

**Elasticsearch (API):**

```
http://localhost:9200
```

Se tudo estiver funcionando, você verá uma resposta JSON com informações da instância Elasticsearch.

---

## 📊 Coleta de Logs

O Filebeat é responsável por coletar e enviar logs do sistema local.
Por padrão, ele coleta logs do diretório:

```
/var/log/
```

Você pode adicionar ou remover fontes no arquivo `filebeat.yml`, conforme seu caso de uso.

---

## 🧠 Dica para Testes

Quer testar se tudo está funcionando?
Gere alguns logs artificiais com:

```bash
logger "Teste de log enviado em $(date)"
```

Em seguida, acesse o **Kibana → Discover** e procure pelo log recém-criado.

---

## 🔒 Importante

Este ambiente é voltado **exclusivamente para fins educacionais** e **uso pessoal/laboratorial**.
Não utilize este setup como SIEM corporativo em produção — ele não possui camadas de segurança, controle de acesso ou redundância configuradas.

---

## 🧾 Licença

Distribuído sob a licença **MIT**.
Sinta-se à vontade para estudar, modificar e aprimorar conforme seu aprendizado.

---

## ✝️ 

> “O prudente vê o perigo e busca refúgio, mas o inexperiente segue adiante e sofre as consequências.”
> — *Provérbios 22:3*
---

**Autor:** Alan Jones Stacholski Júnior

**Base:** Zorin OS 18 (Linux)

**Propósito:** Estudo e prática de observabilidade e cibersegurança pessoal com o stack ELK.

```
