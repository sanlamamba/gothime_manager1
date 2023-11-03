# Utilisez une image node pour le frontend
FROM node:16

# Définissez le répertoire de travail
WORKDIR /app

# Copiez les fichiers du projet
COPY . .

# Installez les dépendances
RUN npm install

# Exposez le port (par exemple, 3000 pour une application React ou Vue)
EXPOSE 3000

# Commande pour démarrer l'application
# Execute commands mentioned under run.sh file
CMD ["./run_front.sh"]
