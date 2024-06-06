#!/bin/bash

# Atualiza o repositório de pacotes
sudo apt-get update

# Instala pacotes necessários para usar repositórios HTTPS
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Adiciona a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Adiciona o repositório do Docker ao APT
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Atualiza o repositório de pacotes novamente
sudo apt-get update

# Instala o Docker
sudo apt-get install -y docker-ce

# Adiciona o usuário atual ao grupo do Docker
sudo usermod -aG docker $USER

# Baixa a última versão estável do Docker Compose
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Aplica permissões de execução ao binário do Docker Compose
sudo chmod +x /usr/local/bin/docker-compose

# Verifica as versões instaladas
docker --version
docker-compose --version

echo "Instalação completa. Para aplicar as mudanças de grupo, feche e reabra o terminal ou execute: newgrp docker"

