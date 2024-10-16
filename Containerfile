FROM git.almalinux.org/charles2/calcite:9
# Fixes
RUN mkdir /var/roothome && \
chown root:root /var/roothome && \
chmod 700 /var/roothome
# LibreWolf
RUN curl --create-dirs -Lo /root/pubkey.gpg https://repo.librewolf.net/pubkey.gpg && \
echo "importing" && \
rpm --import /root/pubkey.gpg && \
rm -vf /root/pubkey.gpg && \
dnf swap firefox https://repo.librewolf.net/pool/librewolf-131.0.2-1-linux-x86_64-rpm.rpm -y
# hardened_malloc
RUN curl --create-dirs -Lo /usr/lib/libhardened_malloc.so https://github.com/charles8191/hardened_malloc/raw/refs/heads/main/libhardened_malloc.so && \
chmod +x /usr/lib/libhardened_malloc.so && \
echo "/usr/lib/libhardened_malloc.so" > /etc/ld.so.preload 
# Configuration
RUN curl --create-dirs -Lo /etc/chrony.conf https://github.com/GrapheneOS/infrastructure/raw/refs/heads/main/chrony.conf && \
curl --create-dirs -Lo /usr/local/lib/sysctl.d/local.conf https://github.com/GrapheneOS/infrastructure/raw/refs/heads/main/sysctl.d/local.conf
COPY scap.sh /root/scap.sh
RUN (bash /root/scap.sh || true) && \
rm -vf /root/scap.sh
# Clean
RUN rm -vfr /var/roothome
