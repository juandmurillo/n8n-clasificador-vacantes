#!/bin/sh
# Comprueba las respuestas 400 del flujo publicado. No llama al LLM ni escribe en la hoja.
URL="${1:-http://localhost:5678/webhook/vacante}"

probar() {
  codigo=$(curl -s -o /dev/null -w '%{http_code}' -X POST "$URL" -H "Content-Type: application/json" -d "$2")
  if [ "$codigo" = "400" ]; then echo "OK    $1"; else echo "FALLA $1 (HTTP $codigo)"; fi
}

probar "texto vacío" '{"texto":"   "}'
probar "sin campo texto" '{"otro":"x"}'
probar "texto no es string" '{"texto":123}'
