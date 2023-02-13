#!/bin/bash

# Nome do arquivo de texto que contém a lista de alvos
target_file="targets.txt"

# Loop através dos alvos no arquivo de texto
while read target; do
  echo "Scanning $target"

  # Execute o nmap de forma furtiva
  echo "Running nmap on $target"
  nmap -A -T4 --open --min-rate 400 "$target" > "$target-nmap.txt"

  # Execute o whatweb de forma furtiva
  echo "Running whatweb on $target"
  whatweb --random-user-agent "$target" > "$target-whatweb.txt"

  # Execute o subfinder de forma furtiva
  echo "Running subfinder on $target"
  subfinder -d "$target" --silent > "$target-subfinder.txt"

  # Execute o wafw00f de forma furtiva
  echo "Running wafw00f on $target"
  wafw00f --rand-agent "$target" > "$target-wafw00f.txt"

  # Execute o dirsearch de forma furtiva
  echo "Running dirsearch on $target"
  python3 dirsearch.py -u "$target" --random-agents -e * > "$target-dirsearch.txt"

  # Execute o dnsrecon de forma furtiva
  echo "Running dnsrecon on $target"
  dnsrecon -d "$target" --noreverse --threads 10 --silent > "$target-dnsrecon.txt"

  echo "Scanning $target completed"
  echo ""
done < "$target_file"

echo "All scans completed"
