kubernetes:
  children:
    master:
      hosts:
%{ for hostname, ip in k3s_masters ~}
        ${hostname}:
          ansible_host: ${ip}
          ansible_user: ubuntu
          ansible_become_pass: ubuntu
          ansible_ssh_private_key_file: ${ansible_ssh_private_key_file}
%{ endfor ~}
    worker:
      hosts:
%{~ for hostname, ip in k3s_workers }
        ${hostname}:
          ansible_host: ${ip}
          ansible_user: ubuntu
          ansible_become_pass: ubuntu
          ansible_ssh_private_key_file: ${ansible_ssh_private_key_file}
%{~ endfor ~}
