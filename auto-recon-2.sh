#!/bin/bash

# Armazenando o nome do arquivo de alvos em uma variável
targets_file="targets.txt"

# Verificando se o arquivo de alvos existe
if [ ! -f "$targets_file" ]; then
  echo "Arquivo de alvos não encontrado. Verifique se o caminho está correto."
  exit 1
fi

# Lendo cada linha do arquivo de alvos
while IFS= read -r target; do
  echo "Iniciando reconhecimento de $target..."

  # Executando cada ferramenta de reconhecimento
  echo "Executando NaaBu..."
  naabu -t "$target" -o "naabu_$target.txt"

  echo "Executando Amass..."
  amass enum -d "$target" -o "amass_$target.txt"

  echo "Executando WhatWeb..."
  whatweb "$target" -o "whatweb_$target.txt"

  echo "Executando Subfinder..."
  subfinder -d "$target" -o "subfinder_$target.txt"

  echo "Executando WAFW00F..."
  wafw00f "$target" -o "wafw00f_$target.txt"

  echo "Executando DirSearch..."
  python3 dirsearch.py -u "$target" -o "dirsearch_$target.txt"

  echo "Executando DNSrecon..."
  dnsrecon -d "$target" -o "dnsrecon_$target.txt"

  echo "Reconhecimento de $target concluído."
  echo
done < "$targets_file"
