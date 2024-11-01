FROM ghcr.io/charles8191/calcite/9
ARG LIBREWOLF_VERSION=132.0-1
COPY scap.sh /scap.sh
RUN sed -i 's,rockylinux.org,github.com/charles8191/netherite,g' /usr/lib/os-release && \
sed -i 's,Rocky Linux,Netherite,g' /usr/lib/os-release && \
sed -i 's,Rocky,Netherite,g' /usr/lib/os-release && \
sed -i 's,rockylinux,netherite,g' /usr/lib/os-release && \
sed -i 's,rocky-linux,netherite,g' /usr/lib/os-release && \
sed -i 's,rocky,netherite,g' /usr/lib/os-release && \
sed -i 's,ID_LIKE="rhel centos fedora",ID_LIKE="rhel centos fedora rocky",g' /usr/lib/os-release && \
sed -i 's,BUG_REPORT_URL,JUNK_BUG_REPORT_URL,g' /usr/lib/os-release && \
sed -i 's,ROCKY_SUPPORT_PRODUCT,JUNK_ROCKY_SUPPORT_PRODUCT,g' /usr/lib/os-release && \
sed -i 's,REDHAT_SUPPORT_PRODUCT,JUNK_REDHAT_SUPPORT_PRODUCT,g' /usr/lib/os-release && \
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
curl --create-dirs -Lo /usr/lib/NetworkManager/conf.d/30-nm-privacy.conf https://github.com/divestedcg/Brace/raw/refs/heads/master/brace/usr/lib/NetworkManager/conf.d/30-nm-privacy.conf && \
(bash /scap.sh || true) && \
rm -vf /scap.sh && \
dnf clean all
