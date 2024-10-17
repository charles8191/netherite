FROM git.almalinux.org/charles2/calcite:9
ARG LIBREWOLF_VERSION=131.0.2-1
COPY scap.sh /scap.sh
RUN sed -i 's,wiki.almalinux.org,github.com/charles8191/netherite,g' /usr/lib/os-release && \
sed -i 's,ID="almalinux",ID="netherite",g' /usr/lib/os-release && \
sed -i 's,ALMALINUX_MANTISBT_PROJECT,JUNK_ALMALINUX_MANTISBT_PROJECT,g' /usr/lib/os-release && \
sed -i 's,AlmaLinux,Netherite,g' /usr/lib/os-release && \
sed -i 's,almalinux,netherite,g' /usr/lib/os-release && \
sed -i 's,ID_LIKE="rhel centos fedora",ID_LIKE="rhel centos fedora almalinux",g' /usr/lib/os-release && \
sed -i 's,BUG_REPORT_URL,JUNK_BUG_REPORT_URL,g' /usr/lib/os-release && \
curl --create-dirs -Lo /pubkey.gpg https://repo.librewolf.net/pubkey.gpg && \
rpm --import /pubkey.gpg && \
rm -vf /pubkey.gpg && \
dnf install firewalld -y && \
dnf swap firefox https://repo.librewolf.net/pool/librewolf-${LIBREWOLF_VERSION}-linux-x86_64-rpm.rpm -y && \
curl --create-dirs -Lo /usr/lib/libhardened_malloc.so https://github.com/charles8191/hardened_malloc/raw/refs/heads/main/libhardened_malloc.so && \
chmod +x /usr/lib/libhardened_malloc.so && \
echo "/usr/lib/libhardened_malloc.so" > /etc/ld.so.preload && \
curl --create-dirs -Lo /etc/chrony.conf https://github.com/GrapheneOS/infrastructure/raw/refs/heads/main/chrony.conf && \
curl --create-dirs -Lo /usr/local/lib/sysctl.d/local.conf https://github.com/GrapheneOS/infrastructure/raw/refs/heads/main/sysctl.d/local.conf && \
(bash /scap.sh || true) && \
rm -vf /scap.sh && \
dnf clean all
