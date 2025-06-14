#!/bin/bash

# Скрипт создания RoleBindings для пользователей Kubernetes
NAMESPACE="default"  # Можно изменить на нужный namespace

echo "Создание RoleBindings..."
echo "------------------------"

# Привязка пользователя read01 к developer-role
kubectl create rolebinding read01-developer-binding \
  --namespace=$NAMESPACE \
  --role=developer-role \
  --user=read01

# Привязка пользователя full01 к devops-role
kubectl create rolebinding full01-devops-binding \
  --namespace=$NAMESPACE \
  --role=devops-role \
  --user=full01

echo "------------------------"
echo "RoleBindings успешно созданы:"
echo "1. Пользователь read01 привязан к developer-role"
echo "2. Пользователь full01 привязан к devops-role"
echo ""
echo "Проверить можно командами:"
echo "  kubectl get rolebindings -n $NAMESPACE"
echo "  kubectl describe rolebinding read01-developer-binding -n $NAMESPACE"