#!/bin/bash

while true; do
  echo ""
  echo "===== MENÚ DE SERVICIOS ====="
  echo "1. Listar contenido de una carpeta"
  echo "2. Crear un archivo de texto con una línea"
  echo "3. Comparar dos archivos de texto"
  echo "4. Usar comando AWK"
  echo "5. Usar comando GREP"
  echo "6. Salir"
  echo "============================="
  read -p "Selecciona una opción (1-6): " opcion

  case $opcion in
    1)
      read -p "Ingresa la ruta absoluta de la carpeta: " ruta
      if [ -d "$ruta" ]; then
        ls -l "$ruta"
      else
        echo "La carpeta no existe."
      fi
      ;;
    2)
      read -p "Escribe la línea de texto: " linea
      read -p "Nombre del archivo a crear: " archivo
      echo "$linea" > "$archivo"
      echo "Archivo '$archivo' creado con el texto."
      ;;
    3)
      read -p "Ruta del primer archivo: " archivo1
      read -p "Ruta del segundo archivo: " archivo2
      if [[ -f "$archivo1" && -f "$archivo2" ]]; then
        diff "$archivo1" "$archivo2"
      else
        echo "Uno o ambos archivos no existen."
      fi
      ;;
    4)
      echo "Ejemplo con AWK: imprimir la segunda columna de un archivo"
      read -p "Ingresa el archivo de texto: " awkfile
      if [ -f "$awkfile" ]; then
        awk '{print $2}' "$awkfile"
      else
        echo "Archivo no encontrado."
      fi
      ;;
    5)
      echo "Ejemplo con GREP: buscar líneas que contengan una palabra"
      read -p "Ingresa la palabra a buscar: " palabra
      read -p "Ingresa el archivo donde buscar: " grepfile
      if [ -f "$grepfile" ]; then
        grep "$palabra" "$grepfile"
      else
        echo "Archivo no encontrado."
      fi
      ;;
    6)
      echo "Saliendo del menú..."
      break
      ;;
    *)
      echo "Opción no válida."
      ;;
  esac
done
