firewall --enabled
selinux --enforcing

%addon com_redhat_kdump --disable
%end

ostreecontainer --url ghcr.io/charles8191/netherite/9
