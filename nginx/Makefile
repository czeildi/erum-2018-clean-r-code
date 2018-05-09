IMAGE_NAME=ernum-2018-clean-r-code-nginx

build/nginx:
	docker build -t $(IMAGE_NAME) .

start/nginx:
	docker run --rm --net=host $(IMAGE_NAME)