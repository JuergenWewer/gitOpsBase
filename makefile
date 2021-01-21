.PHONY: compile

compile: 
	kubectl kustomize eksconnect/overlays/onprem-dvit/cluster
	# kubectl apply -k eksconnect/overlays/onprem-dvit/cluster --dry-run
	