prod:
	doo g c1 doo b
	doo g c1 doo u

sync:
	make -C ~/dev/docker/dops build
	make -C ~/dev/docker/c1 build
	doo g c1 doo b
	doo g c1 doo u

build:
	doo b

run:
	doo r -p 80:4242

dev:
	doo d -p 80:4242
