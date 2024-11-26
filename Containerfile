# Based on Calcite
FROM ghcr.io/charles8191/calcite/9
# Adding configuration files
ADD net-privacy.conf /usr/lib/NetworkManager/conf.d/30-net-privacy.conf
ADD chrony.conf /etc/chrony.conf
ADD chrony.conf /usr/etc/chrony.conf
ADD tunables.conf /usr/lib/sysctl.d/tunables.conf
RUN \
set -x && \
# Memory allocator
curl --create-dirs -Lo /usr/lib64/libscudo.so https://github.com/charles8191/scudo/raw/refs/heads/main/libscudo.so && \
chmod +x /usr/lib64/libscudo.so && \
echo "/usr/lib64/libscudo.so" > /etc/ld.so.preload && \
echo "/usr/lib64/libscudo.so" > /usr/etc/ld.so.preload && \
# Branding
sed -i 's,centos.org,github.com/charles8191/netherite,g' /usr/lib/os-release && \
sed -i 's,CentOS Stream,Netherite,g' /usr/lib/os-release && \
sed -i 's,CentOS,Netherite,g' /usr/lib/os-release && \
sed -i 's,centos-stream,netherite,g' /usr/lib/os-release && \
sed -i 's,centosstream,netherite,g' /usr/lib/os-release && \
sed -i 's,centos,netherite,g' /usr/lib/os-release && \
sed -i 's,ID_LIKE="rhel fedora",ID_LIKE="rhel centos fedora",g' /usr/lib/os-release && \
sed -i 's,issues.redhat.com,github.com/charles8191/netherite/issues,g' /usr/lib/os-release && \
sed -i 's,REDHAT_SUPPORT_PRODUCT,JUNK_REDHAT_SUPPORT_PRODUCT,g' /usr/lib/os-release && \
# BadWolf
dnf swap -y --nogpgcheck firefox https://dl.fedoraproject.org/pub/archive/fedora/linux/releases/34/Everything/x86_64/os/Packages/b/badwolf-1.0.3-2.fc34.x86_64.rpm && \
# firewalld (breaks the kickstart if not present)
dnf install firewalld -y && \
# SCAP
dnf install openscap openscap-scanner scap-security-guide -y && \
oscap xccdf generate fix --profile xccdf_org.ssgproject.content_profile_anssi_bp28_minimal --fix-type bash /usr/share/xml/scap/ssg/content/ssg-cs9-ds.xml > /scap.sh && \
(bash /scap.sh || true) && \
rm -vf /scap.sh && \
# Clean
dnf clean all
