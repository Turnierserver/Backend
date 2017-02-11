#!/bin/bash
set -e

function dl()
{
    for arch in x86_64 any
    do
	for repo in core extra
	do
	    wget -q --show-progress -O $1.tar.xz https://www.archlinux.org/packages/$repo/$arch/$1/download/ \
		&& return 0 \
		|| rm -f $1.tar.xz
	done
    done
    return 1
}

test ! -d root || rm -rf root
mkdir root

test ! -d build || rm -rf build
mkdir build
pushd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr ../..
make -j2
make DESTDIR=../root install
popd

for pkg in $(cat packages.txt)
do
    test -r $pkg.tar.xz || dl $pkg
    bsdtar xf $pkg.tar.xz -C root
done

sudo docker build --tag backend .
