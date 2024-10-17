FROM git.almalinux.org/charles2/calcite:9
ARG LIBREWOLF_VERSION=131.0.2-1
# Fixes
RUN mkdir /var/roothome && \
chown root:root /var/roothome && \
chmod 700 /var/roothome
# Branding
RUN sed -i 's,wiki.almalinux.org,github.com/charles8191/netherite,g' /usr/lib/os-release && \
sed -i 's,ID="almalinux",ID="netherite",g' /usr/lib/os-release && \
sed -i 's,ALMALINUX_MANTISBT_PROJECT="AlmaLinux-9",,g' /usr/lib/os-release && \
sed -i 's,ALMALINUX_MANTISBT_PROJECT_VERSION="9.4",,g' /usr/lib/os-release && \
sed -i 's,AlmaLinux,Netherite,g' /usr/lib/os-release && \
sed -i 's,almalinux,netherite,g' /usr/lib/os-release && \
sed -i 's,ID_LIKE="rhel centos fedora",ID_LIKE="rhel centos fedora almalinux",g' /usr/lib/os-release
# LibreWolf
RUN curl --create-dirs -Lo /root/pubkey.gpg https://repo.librewolf.net/pubkey.gpg && \
echo "importing" && \
rpm --import /root/pubkey.gpg && \
rm -vf /root/pubkey.gpg && \
dnf swap firefox https://repo.librewolf.net/pool/librewolf-${LIBREWOLF_VERSION}-linux-x86_64-rpm.rpm -y
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
