# Based on Calcite
FROM ghcr.io/charles8191/calcite/9
# Adding configuration files
ADD net-privacy.conf /usr/lib/NetworkManager/conf.d/30-net-privacy.conf
ADD chrony.conf /etc/chrony.conf
ADD chrony.conf /usr/etc/chrony.conf
ADD tunables.conf /usr/lib/sysctl.d/tunables.conf
RUN \
set -x && \
# Install mimalloc
curl --create-dirs -Lo /usr/lib64/libmimalloc-secure.so https://github.com/charles8191/mimalloc-secure/raw/refs/heads/main/libmimalloc-secure.so && \
chmod +x /usr/lib64/libmimalloc-secure.so && \
echo "/usr/lib64/libmimalloc-secure.so" > /etc/ld.so.preload && \
echo "/usr/lib64/libmimalloc-secure.so" > /usr/etc/ld.so.preload && \
# Branding
sed -i 's,rockylinux.org,github.com/charles8191/netherite,g' /usr/lib/os-release && \
sed -i 's,Rocky Linux,Netherite,g' /usr/lib/os-release && \
sed -i 's,Rocky,Netherite,g' /usr/lib/os-release && \
sed -i 's,rockylinux,netherite,g' /usr/lib/os-release && \
sed -i 's,rocky-linux,netherite,g' /usr/lib/os-release && \
sed -i 's,rocky,netherite,g' /usr/lib/os-release && \
sed -i 's,ID_LIKE="rhel centos fedora",ID_LIKE="rhel centos fedora rocky",g' /usr/lib/os-release && \
sed -i 's,BUG_REPORT_URL,JUNK_BUG_REPORT_URL,g' /usr/lib/os-release && \
sed -i 's,ROCKY_SUPPORT_PRODUCT,JUNK_ROCKY_SUPPORT_PRODUCT,g' /usr/lib/os-release && \
sed -i 's,REDHAT_SUPPORT_PRODUCT,JUNK_REDHAT_SUPPORT_PRODUCT,g' /usr/lib/os-release && \
# LibreWolf
curl --create-dirs -Lo /pubkey.gpg https://repo.librewolf.net/pubkey.gpg && \
rpm --import /pubkey.gpg && \
rm -vf /pubkey.gpg && \
curl -fsSL https://repo.librewolf.net/librewolf.repo | tee /etc/yum.repos.d/librewolf.repo && \
mkdir -p /usr/etc/yum.repos.d
curl -fsSL https://repo.librewolf.net/librewolf.repo | tee /usr/etc/yum.repos.d/librewolf.repo && \
dnf swap firefox librewolf -y && \
# firewalld (breaks the kickstart if not present)
dnf install firewalld -y && \
# SCAP
dnf install openscap openscap-scanner scap-security-guide -y && \
oscap xccdf generate fix --profile xccdf_org.ssgproject.content_profile_anssi_bp28_minimal --fix-type bash /usr/share/xml/scap/ssg/content/ssg-rl9-ds.xml > /scap.sh && \
(bash /scap.sh || true) && \
rm -vf /scap.sh && \
# Clean
dnf clean all
