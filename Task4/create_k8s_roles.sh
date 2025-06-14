#!/bin/bash

# Скрипт создания ролей для разработчиков и DevOps в Kubernetes

NAMESPACE="default"  # Можно изменить на нужный namespace

echo "Создание ролей в Kubernetes..."
echo "------------------------------"

# Создаем developer-role (только просмотр подов)
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: $NAMESPACE
  name: developer-role
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
EOF

# Создаем devops-role (полное управление подами)
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: $NAMESPACE
  name: devops-role
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
EOF

echo "------------------------------"
echo "Роли успешно созданы:"
echo "1. developer-role - просмотр подов (get, list, watch)"
echo "2. devops-role - полное управление подами"
echo ""
echo "Для привязки ролей к группам используйте RoleBinding"