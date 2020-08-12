# vim: set ft=ansible_hosts:
[jumpbox]
bastion ansible_host=${jump_host_ip} env=localhost

[www]
${web_hosts_inventory}

[db]
${db_hosts_inventory}

[lb]
nginx-balancer ansible_host=${lb_host_ip} ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q root@${jump_host_ip}"' env=aux public_ip=${lb_public_ip}

[nginx:children]
lb
www

[runners:children]
jumpbox
www
