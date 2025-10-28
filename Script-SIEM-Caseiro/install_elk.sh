#!/bin/bash

# Script de Instalação Automatizada - ELK Stack
# SIEM Caseiro - Projeto Educacional

set -e  # Para em caso de erro

echo "   Instalação Automatizada - ELK Stack"
echo "   SIEM Caseiro"
echo ""

# Função para verificar se comando existe
comando_existe() {
    command -v "$1" >/dev/null 2>&1
}

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}[1/7] Atualizando sistema${NC}"
sudo apt update -qq

echo -e "${YELLOW}[2/7] Instalando dependências${NC}"
sudo apt install -y wget curl gnupg apt-transport-https openjdk-11-jdk > /dev/null 2>&1

echo -e "${YELLOW}[3/7] Adicionando repositório Elastic${NC}"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list > /dev/null
sudo apt update -qq

echo -e "${YELLOW}[4/7] Instalando Elasticsearch${NC}"
sudo apt install -y elasticsearch > /dev/null 2>&1

# Configurar Elasticsearch
sudo tee /etc/elasticsearch/elasticsearch.yml > /dev/null <<EOF
cluster.name: siem-home
node.name: node-1
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
network.host: localhost
http.port: 9200
xpack.security.enabled: false
xpack.security.enrollment.enabled: false
xpack.security.http.ssl.enabled: false
xpack.security.transport.ssl.enabled: false
EOF

echo -e "${GREEN}✓ Elasticsearch configurado${NC}"

echo -e "${YELLOW}[5/7] Instalando Kibana${NC}"
sudo apt install -y kibana > /dev/null 2>&1

# Configurar Kibana
sudo tee /etc/kibana/kibana.yml > /dev/null <<EOF
server.port: 5601
server.host: "localhost"
server.name: "SIEM-Home"
elasticsearch.hosts: ["http://localhost:9200"]
EOF

echo -e "${GREEN}✓ Kibana configurado${NC}"

echo -e "${YELLOW}[6/7] Instalando Filebeat${NC}"
sudo apt install -y filebeat > /dev/null 2>&1

# Configurar Filebeat
sudo tee /etc/filebeat/filebeat.yml > /dev/null <<EOF
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/auth.log
    - /var/log/syslog
  fields:
    log_type: system

filebeat.config.modules:
  path: \${path.config}/modules.d/*.yml
  reload.enabled: true

output.elasticsearch:
  hosts: ["localhost:9200"]
  
setup.kibana:
  host: "localhost:5601"
EOF

# Habilitar módulo system
sudo filebeat modules enable system

# Configurar módulo system
sudo tee /etc/filebeat/modules.d/system.yml > /dev/null <<EOF
- module: system
  syslog:
    enabled: true
  auth:
    enabled: true
EOF

echo -e "${GREEN}✓ Filebeat configurado${NC}"

echo -e "${YELLOW}[7/7] Iniciando serviços...${NC}"

# Iniciar Elasticsearch
sudo systemctl enable elasticsearch > /dev/null 2>&1
sudo systemctl start elasticsearch

echo "Aguardando Elasticsearch iniciar (30s)..."
sleep 30

# Testar Elasticsearch
if curl -s "localhost:9200" > /dev/null; then
    echo -e "${GREEN}✓ Elasticsearch rodando!${NC}"
else
    echo -e "${RED}✗ Erro ao iniciar Elasticsearch${NC}"
    exit 1
fi

# Iniciar Kibana
sudo systemctl enable kibana > /dev/null 2>&1
sudo systemctl start kibana

echo "Aguardando Kibana iniciar (60s)..."
sleep 60

# Iniciar Filebeat e fazer setup
sudo systemctl enable filebeat > /dev/null 2>&1
echo "Configurando índices no Elasticsearch..."
sudo filebeat setup -e > /dev/null 2>&1
sudo systemctl start filebeat

echo ""
echo "=========================================="
echo -e "${GREEN}   Instalação Concluída!${NC}"
echo "=========================================="
echo ""
echo "Serviços rodando:"
echo "  • Elasticsearch: http://localhost:9200"
echo "  • Kibana: http://localhost:5601"
echo "  • Filebeat: Coletando logs"
echo ""
echo "Comandos úteis:"
echo "  Status: sudo systemctl status elasticsearch kibana filebeat"
echo "  Logs: sudo journalctl -u elasticsearch -f"
echo ""
echo "Acesse o Kibana em: http://localhost:5601"
echo "Vá em Menu → Discover para ver seus logs!"
echo ""
