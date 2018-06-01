
BRANCH = $(shell git branch | grep '* ' | cut -d\  -f 2)


build: building-software-at-the-edges.md
	mkpage "title=text:Building software at the edges of heterogeneous repositories" "content=README.md" page.tmpl > index.html
	mkslides "title=text:Building software at the edges of heterogeneous repositories" building-software-at-the-edges.md slide.tmpl

generic: FORCE
	mkpage "title=text:Building software at the edges of heterogeneous repositories" "content=README.md" > index.html
	mkslides "title=text:Building Software at the Edges of Repositories" building-software-at-the-edges.md
	
clean: FORCE
	rm *.html

status:
	git status

save:
	git add *.html
	if [ "$(msg)" != "" ]; then git commit -am "$(msg)"; else git commit -am "Quick Save"; fi
	git push origin $(BRANCH)

publish: build
	bash publish.bash

	
FORCE:
