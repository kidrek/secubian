# SECUBIAN - Initialisation

SECUBIAN se déploie aisément sur une installation récente d'un système Linux Debian (actuellemnet v12) ou Ubuntu (actuellement v24.04), via la solution Ansible.


## Déploiement

Les variables attendues dans le fichier ```inventory``` sont les suivantes : 
- ansible_user : login du compte utilisateur dont la session sera enrichie par les outils et la documentation
- ansible_ssh_pass : le mot de passe de l'utilisateur permettant l'authentification SSH
- ansible_sudo_pass : le mot de passe de l'utilisateur
- arch : cette variable permet de définir l'architecture cible ex: ```amd64```, ```arm64``` // Elle sera à terme remplacée par la variable globale d'Ansible.

Voici des exemples de fichier inventory :

* pour une machine accessible via SSH. Le paquet ```sshpass``` sera donc un pré-requis

```
127.0.0.1 ansible_user=xx ansible_ssh_pass=xx arch=xx
```

* pour appliquer le playbook sur la machine en local : 

```
127.0.0.1 ansible_connection=local ansible_user=xx arch=xx
```


Une fois les données fournies, voici la commande à exécuter (potentiellement au sein d'une instance tmux/screen): 

```
ansible-playbook -i inventory -K secubian.yml
```

Un redémarrage est conseillé, une fois le système installé.
