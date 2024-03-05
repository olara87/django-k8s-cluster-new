1. Test django
'''
python manage.py test
'''
2. Build container
'''
docker build -f Dockerfile \
    -t registry.digitalocean.com/django-k8s-container-registry/django-k8s-web:latest \
    -t registry.digitalocean.com/django-k8s-container-registry/django-k8s-web:v1 \
    .
'''
3. Push container to DO container registry
'''
docker push registry.digitalocean.com/django-k8s-container-registry/django-k8s-web --all-tags
'''
4. Update secrets
'''
kubectl delete secret django-k8s-web-prod-env --from-env-file=web/.env.prod
'''
5. Update Deployment
'''
kubectl apply -f k8s/apps/django-k8s-web.yaml
'''
6. Wait for rollout to finish
'''
kubectl rollout status deployment/django-k8s-web-deployment
'''
7. Migrate Database
'''
export SINGLE_POD_NAME=$(kubectl get pod -l app=django-k8s-web-deployment -o jsonpath="{.items[0].metadata.name}")
'''
or
'''
export SINGLE_POD_NAME=$(kubectl get pod -l=app=django-k8s-web-deployment -o NAME | tail -n 1)
'''
RUN the migrations
'''
kubectl exec -it $SINGLE_POD_NAME -- sh /app/migrate.sh
'''