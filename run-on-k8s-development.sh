#!/bin/bash

if [ $# -ne 1 ]; then
  echo "引数に start もしくは stop を指定してください"
  exit 1
fi

if [ $1 = "start" ]; then

  echo "Deploying microservice-demo services on k8s development env..."
  kubectl apply -k services/overlays/development

  echo "Waiting for the services to start up..."
  kubectl wait --timeout=600s --for=condition=ready pod --all -n ms-demo
fi

if [ $1 = "stop" ]; then
  echo "Deleting microservice-demo services  on k8s development env..."
  kubectl delete -k services/overlays/development
fi

