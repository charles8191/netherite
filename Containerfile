# Based on Calcite
FROM ghcr.io/charles8191/calcite/9
# Adding configuration files
ADD net-privacy.conf /usr/lib/NetworkManager/conf.d/30-net-privacy.conf
ADD chrony.conf /etc/chrony.conf
ADD chrony.conf /usr/etc/chrony.conf
ADD tunables.conf /usr/lib/sysctl.d/tunables.conf
ADD browser.json /etc/chromium/policies/managed/browser.json
ADD browser.json /usr/etc/chromium/policies/managed/browser.json
RUN \
set -x && \
# hardened_malloc
curl --create-dirs -Lo /usr/lib64/libhardened_malloc.so https://github.com/charles8191/hardened_malloc/raw/refs/heads/main/libhardened_malloc-debian.so && \
chmod +x /usr/lib64/libhardened_malloc.so && \
echo "/usr/lib64/libhardened_malloc.so" > /etc/ld.so.preload && \
echo "/usr/lib64/libhardened_malloc.so" > /usr/etc/ld.so.preload && \
# Branding
sed -i 's,wiki.almalinux.org,github.com/charles8191/netherite,g' /usr/lib/os-release && \
sed -i 's,ID="almalinux",ID="netherite",g' /usr/lib/os-release && \
sed -i 's,ALMALINUX_MANTISBT_PROJECT,JUNK_ALMALINUX_MANTISBT_PROJECT,g' /usr/lib/os-release && \
sed -i 's,ID_LIKE="rhel centos fedora",ID_LIKE="rhel centos fedora almalinux",g' /usr/lib/os-release && \
sed -i 's,bugs.almalinux.org,github.com/charles8191/netherite/issues,g' /usr/lib/os-release && \
sed -i 's,wiki.almalinux.org/,https://github.com/charles8191/netherite/#faq,g' /usr/lib/os-release && \
sed -i 's,almalinux.org,github.com/charles8191/netherite,g' /usr/lib/os-release && \
sed -i 's,AlmaLinux,Netherite,g' /usr/lib/os-release && \
sed -i 's,almalinux,netherite,g' /usr/lib/os-release && \
# Chromium
dnf install epel-release -y && \
dnf config-manager --set-enabled crb && \
dnf swap -y firefox chromium && \
# firewalld (breaks the kickstart if not present)
dnf install firewalld -y && \
# SCAP
dnf install openscap openscap-scanner scap-security-guide -y && \
oscap xccdf generate fix --profile xccdf_org.ssgproject.content_profile_anssi_bp28_minimal --fix-type bash /usr/share/xml/scap/ssg/content/ssg-cs9-ds.xml > /scap.sh && \
bash /scap.sh ; \
rm -vf /scap.sh && \
# Count Me
sed -i -e s,countme=1,countme=0, /etc/yum.repos.d/*.repo ; \
sed -i -e s,countme=1,countme=0, /usr/etc/yum.repos.d/*.repo ; \
systemctl mask rpm-ostree-countme.timer ; \
# Clean
dnf clean all