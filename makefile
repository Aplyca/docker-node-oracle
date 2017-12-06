build:
	docker build -t aplyca/node-oracle .

push:
	docker login
	DOCKERCLOUD_NAMESPACE=aplyca docker push aplyca/node-oracle
