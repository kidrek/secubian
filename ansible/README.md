# SECUBIAN - Initialisation

SECUBIAN se déploie aisément sur une installation récente d'un système Linux Debian, via la solution Ansible.

```
ansible-playbook -i inventory secubian.yml
```

Les variables attendues dans le fichier ```inventory``` sont les suivantes : 
- ansible_user : login du compte utilisateur dont la session sera enrichie par les outils et la documentation
- ansible_sudo_pass : le mot de passe de l'utilisateur
- ansible_architecture

