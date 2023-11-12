clean:
	rm -rf *.o
	rm -rf *.out
	rm -rf *.so
	rm -rf *.a
	rm -rf *.exe

helloworld.o: helloworld.o
	aarch64-linux-gnu-as -o helloworld.o helloworld.S

helloworld: helloworld.o
	aarch64-linux-gnu-ld -o helloworld helloworld.o

build: helloworld

run-qemu: build
	qemu-aarch64 helloworld
