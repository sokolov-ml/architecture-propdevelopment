#!/bin/bash

# Скрипт для создания пользователей Kubernetes с базовой аутентификацией (совместимый со старыми версиями Bash)

# Список пользователей (можно изменить)
USERS=("read01" "full01")

# Функция генерации случайного пароля
generate_password() {
  openssl rand -base64 12 | tr -dc 'a-zA-Z0-9' | head -c 16
  return 0
}

echo "Создание пользователей Kubernetes..."
echo "---------------------------------"

# Создаем временный файл для хранения учетных данных
CREDENTIALS_FILE=$(mktemp)
trap 'rm -f "$CREDENTIALS_FILE"' EXIT

# Создаем каждого пользователя
for USER in "${USERS[@]}"; do
  PASSWORD=$(generate_password)
  kubectl config set-credentials "$USER" --username="$USER" --password="$PASSWORD"
  echo "$USER:$PASSWORD" >> "$CREDENTIALS_FILE"
done

# Выводим результаты
echo ""
echo "Созданы следующие пользователи:"
echo "-----------------------------"
cat "$CREDENTIALS_FILE" | while read -r line; do
  USER=${line%:*}
  PASS=${line#*:}
  echo "Логин: $USER"
  echo "Пароль: $PASS"
  echo "-----------------------------"
done

echo "Готово! Пользователи добавлены в конфигурацию kubectl."