#!/bin/bash

# Verificar que hay al menos 6 argumentos
if [ "$#" -lt 6 ]; then
  echo "Uso: $0 <Nombre_VM> <Tipo_SO> <CPUs> <RAM_MB> <VRAM_MB> <Disco_GB>"
  exit 1
fi

# Argumentos
NOMBRE_VM=$1
TIPO_SO=$2
CPUS=$3
RAM_MB=$4
VRAM_MB=$5
DISCO_GB=$6

# Nombres de los controladores
CONTROLADOR_SATA="${NOMBRE_VM}_SATA"
CONTROLADOR_IDE="${NOMBRE_VM}_IDE"

# Ruta del disco
VHD="${NOMBRE_VM}_disk.vdi"

# Crear la VM
VBoxManage createvm --name "$NOMBRE_VM" --ostype "$TIPO_SO" --register

# Configurar CPU, RAM y VRAM
VBoxManage modifyvm "$NOMBRE_VM" --cpus "$CPUS" --memory "$RAM_MB" --vram "$VRAM_MB"

# Crear disco duro virtual
VBoxManage createmedium disk --filename "$VHD" --size "$((DISCO_GB * 1024))" --format VDI

# Crear y asociar el controlador SATA
VBoxManage storagectl "$NOMBRE_VM" --name "$CONTROLADOR_SATA" --add sata --controller IntelAhci
VBoxManage storageattach "$NOMBRE_VM" --storagectl "$CONTROLADOR_SATA" --port 0 --device 0 --type hdd --medium "$VHD"

# Crear y asociar el controlador IDE
VBoxManage storagectl "$NOMBRE_VM" --name "$CONTROLADOR_IDE" --add ide --controller PIIX4

# Mostrar la configuración final
VBoxManage showvminfo "$NOMBRE_VM"
