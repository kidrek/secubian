#!/usr/bin/env bash
# =====================================================================
# SECUBIAN : lance toute l'installation d'un coup, sans rien demander.
#
# Utilisation (depuis le dossier ansible/) :
#   sudo ./install.sh
#
# - Taper le mdp sudo 1 fois, et après c'est automatique.
# - Tout est enregistré dans /var/log/secubian-install.log
# - Pour pouvoir fermer le terminal pendant l'install, lance-le dans tmux :
#     tmux new -s secubian 'sudo ./install.sh'
#   (pour revenir voir où ça en est : tmux attach -t secubian)
# =====================================================================
set -uo pipefail

# On se place dans le dossier du script (là où il y a secubian.yml)
cd "$(dirname "$(readlink -f "$0")")"

LOG=/var/log/secubian-install.log

# Il faut être root (avec sudo), comme ça Ansible demande plus de mot de passe
if [ "$(id -u)" -ne 0 ]; then
  echo "Lance-moi avec sudo :  sudo ./install.sh"
  exit 1
fi

# apt ne pose jamais de question (il garde les réponses par défaut)
export DEBIAN_FRONTEND=noninteractive

{
  echo "===== Install Secubian : $(date) ====="

  # Si une install apt a été coupée avant, on la termine (sinon apt refuse tout)
  dpkg --configure -a
  apt-get update

  # Ansible + git, seulement s'ils sont pas déjà là
  command -v ansible-playbook >/dev/null || apt-get install -y ansible
  command -v git >/dev/null || apt-get install -y git

  # Les modules Ansible en plus dont le playbook a besoin
  ansible-galaxy collection install community.general community.docker ansible.posix
} 2>&1 | tee -a "$LOG"

# Si ton inventaire a des mots de passe chiffrés avec Ansible Vault,
# mets le mot de passe du vault dans /root/.secubian_vault_pass (droits 600) :
# le playbook le lira tout seul au lieu de te le demander.
VAULT_ARGS=()
if [ -f /root/.secubian_vault_pass ]; then
  VAULT_ARGS=(--vault-password-file /root/.secubian_vault_pass)
fi

# Lancement du playbook. Pas de "-K" : on est déjà root, donc rien à demander.
ansible-playbook secubian.yml "${VAULT_ARGS[@]}" 2>&1 | tee -a "$LOG"
RESULT=${PIPESTATUS[0]}

echo
if [ "$RESULT" -eq 0 ]; then
  echo "Installation terminée sans erreur | tee -a "$LOG"
else
  echo "Il y a eu au moins une erreur. Regarde la fin de $LOG" | tee -a "$LOG"
fi
exit "$RESULT"
