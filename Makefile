# -----------------------------------------------------------------------------
# Define Commands
# -----------------------------------------------------------------------------

clean: # Clean all resources in this mono repo structure.
	@kubectl delete -k ./k8s 2> /dev/null || true

build: # Build the cloud native container artifacts
	@mkdir -p ./dist/
	
deploy: # Deploy the the current Kubernetes cluster
	@kubectl apply -k ./k8s/

connect: # Connect and port forward to localhost
	@echo "https://localhost:8080/"
	@kubectl port-forward svc/argocd-server -n argocd 8080:443
	
update-password: # Change the admin password
	@echo "Initial 'admin' password:"
	@kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
	@argocd login localhost:8080 --insecure
	@argocd account update-password
# CLI Example: 
#  - argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default
