# -----------------------------------------------------------------------------
# Define Commands
# -----------------------------------------------------------------------------

clean: # Clean all resources in this mono repo structure.
	@kubectl delete -k ./config/local 2> /dev/null || true

build: # Build the cloud native container artifacts
	@mkdir -p ./dist/
	
deploy: # Deploy the the current Kubernetes cluster
	@kubectl apply -k ./config/local/
	