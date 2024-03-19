#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 fichier_ips.txt"
    exit 1
fi

input_file=$1

if ! command -v ufw &> /dev/null; then
    echo "Erreur: ufw n'est pas installé sur ce système."
    sudo apt install ufw
fi

if ! ufw status | grep -q "Status: active"; then
    echo "Erreur: ufw n'est pas activé. Veuillez l'activer pour utiliser ce script."
    sudo ufw enable
fi

# Bloquer chaque adresse IP du fichier avec ufw
while IFS= read -r ip_address; do
    ufw deny from "$ip_address" comment "Blocked by script"
done < "$input_file"

echo "Les adresses IP du fichier '$input_file' ont été bloquées avec succès."
