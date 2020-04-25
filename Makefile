all:
	@echo "The franklin rule builds the franklin firmware and puts the .deb packages that need to be installed under ./build"
	@echo "The arch_disk rule creates a disk that will (eventually) automatically flash arch linux onto your beaglebone (for now run the dd/restart manually)"

franklin:
	docker build -t franklinstein .
	mkdir -p build
	rm -rf build/*
	docker run -it --rm -v "${PWD}/build":/build franklinstein

	# git clone https://github.com/helixarch/debtap.git
	# ./debtap/debtap -u
	# ./debtap/debtap -U franklin/*.deb

arch_disk:
	./create_install_disk.sh

clean:
	rm -rf build arm_arch.disk
