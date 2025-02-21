watch:
	mkdir -p dist/
	cp *.ttl dist/
	cp -r images dist/
	mkdir -p dist/backbone
	cp backbone/model.ttl dist/backbone/model.ttl
	mkdir -p dist/placenames
	cp placenames/*.ttl dist/placenames/
	cp placenames/*.png dist/placenames/
	make build
	watchmedo shell-command \
		--patterns="*.adoc;*.css" \
		--ignore-directories \
		--recursive \
		--command='make build' \
		.

build:
	asciidoctor README.adoc -o dist/index.html
	asciidoctor document/supermodel.adoc -o dist/supermodel.html
	asciidoctor placenames/model.adoc -o dist/placenames/index.html

http:
	httpwatcher --root dist \
		--host 127.0.0.1 \
		--port 8000 \
		--no-browser