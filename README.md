Automation of Kubernetes cluster provisioning with Ansible

Local lab - Intel Core i7 2600 (8 cores with HT), 16G, Ubuntu 16.04

Internet---192.168.1.108 eno1-jumphost-vboxnet0 192.168.35.1---k8s_cluster VMs

Will spin up 6 VMs and provision k8s cluster of 3 master nodes and 3 worker nodes

Requirements - Ansible, Vagrant, VirtualBox
1. Tweak bootstrap scripts for Vagrant, jumphost_provisioning script, dnsmasq and haproxy cfg,
and main.yaml file in ansible/roles/kubernetes/vars to match your address plan, ssh key, and username/password.
2. Move Ansible hosts file to /etc/ansible, and kubernetes folder to /etc/ansible/roles.
3. Create VirtualBox host-only network (in my case - 192.168.35.0/24).
4. Run jumphost provisioning script.
5. Run vagrant up to provision VMs.
6. Run ansible-playbook k8s_cluster_install.yaml --ask-become-pass
7. Run ansible-playbook k8s_report_cluster_state.yaml
8. Perform Smoke test from Kubernetes The Hard Way, and beyond.
