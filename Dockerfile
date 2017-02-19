FROM finalduty/archlinux

RUN pacman -Q | awk '{print $1}' | pacman --noconfirm -Syu -; \
    pacman --noconfirm -S qt5-base cmake clang make; \
    yes | pacman -Scc
COPY . /opt/backend
WORKDIR /opt/backend
RUN CC=clang CXX=clang++ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr .; \
    make -j2 install; \
    sed -i 's|HoldPkg|#HoldPkg|g' /etc/pacman.conf; \
    pacman -Q | awk '{print $1}' >/tmp/packages.txt; \
    cat packages.txt | while read line; do echo -n " -e '$line' "; done | xargs grep --invert-match /tmp/packages.txt >/tmp/remove.txt; \
    cat /tmp/remove.txt | pacman --noconfirm -Rdd -; \
    rm -rf /tmp/*; \
    rm -rf /usr/share/man/* /usr/include/*; \
    ls -d /usr/share/locale/* | grep --invert-match "en_GB" | xargs rm -rf
