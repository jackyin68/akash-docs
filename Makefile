IMAGE = quay.io/ovrclk/akash-docs
KEY   = master

server:
	bundle exec middleman

installdeps:
	gem install bundler
	bundle

deploy: img img-push remove create

img:
	docker build -t $(IMAGE) .

img-run:
	docker run --rm -p 4567:4567 -it $(IMAGE)

img-push:
	docker push $(IMAGE)

create:
	akash deployment create akash.yml -k master > .akash

remove: 
	akash deployment close $(shell cat .akash | head -1) -k $(KEY)

.PHONY: server installdeps deploy img img-run img-push create remove
