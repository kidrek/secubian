# SECUBIAN 

"SECUBIAN is a French Linux distribution focused on Incident Response."

SECUBIAN est un projet de distribution Linux permettant de mettre à disposition des équipes de réponse à incident la majorité des outils nécessaires à la collecte, le traitement et l'analyse de données.

![desktop](./img/desktop.png)

Voici une liste non exhaustive des outils présents : 
- Collecte : dd, dc3dd, tcpdump
- Traitement : log2timeline, volatility2, volatility3
- Analyse : Zircolite, Timesketch (amd64 pour le moment), OpenSearch, Capa, wireshark, règles SIGMA & YARA, MVT - Mobile Verification Toolkit
- Suivi d'incident : DFIR IRIS Web

Pour faciliter toutes ces phases, la distribution Linux intègre 2 projets dérivés nommés, [secubian-wiki](https://github.com/kidrek/secubian-wiki) et [secubian-JupyterNotebook](https://github.com/kidrek/secubian-JupyterNotebook). Ces 2 projets, présents dans le répertoire ```Documents``` de votre profil utilisateur, permettent d'apporter de la documentation et de la méthodologie disponibles même OFFLINE.

Un répertoire ```Cases``` est également présent dans le répertoire ```Documents``` de votre profil utilisateur. Les preuves pourront y être déposées pour être analysées. Chacun des documents json, et csv (à terme) provenant de vos analyses et présents dans ce répertoire seront indexés dans l'instance OpenSearch (si celle-ci est démarrée) pour faciliter l'investigation.

PS: D'autres outils dédiés aux domaines du Pentest et de l'OSINT sont également disponibles.