IMAGE = quay.io/ovrclk/akash-docs
KEY   = master

server:
	bundle exec middleman server

installdeps:
	gem install bundler
	bundle

deploy: build img img-push remove create

build:
	bundle exec middleman build --clean

img:
	docker build -t $(IMAGE) .

img-run:
	docker run --rm -p 8080:80 -it $(IMAGE)

img-push:
	docker push $(IMAGE)

create:
	akash deployment create akash.yml -k master > .akash

remove: 
	akash deployment close $(shell cat .akash | head -1) -k $(KEY)

.PHONY: server installdeps deploy img img-run img-push create remove
