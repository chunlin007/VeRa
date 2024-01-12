#! /bin/bash

#修改configure:2339行，增加-ljansson

if [ -e build ]
then
	rm -rf build
fi
	mkdir build && cd build
	../configure --with-sdlabi=1.2 --target-list=gnuarmeclipse-softmmu --disable-kvm
	make -j 
