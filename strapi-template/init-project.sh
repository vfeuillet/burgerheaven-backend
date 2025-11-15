#!/bin/bash

# 🚀 Script d'initialisation de projet Strapi
# Usage: ./init-project.sh <nom-du-projet>

set -e

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher les messages
info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# Vérifier les arguments
if [ -z "$1" ]; then
    error "Usage: ./init-project.sh <nom-du-projet>"
    exit 1
fi

PROJECT_NAME=$1
TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Vérifier que le dossier n'existe pas déjà
if [ -d "$PROJECT_NAME" ]; then
    error "Le dossier '$PROJECT_NAME' existe déjà !"
    exit 1
fi

info "🎨 Création du projet '$PROJECT_NAME' à partir du template Strapi..."
echo ""

# Créer le dossier du projet
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Copier tous les fichiers du template
info "📦 Copie des fichiers du template..."
cp -r "$TEMPLATE_DIR"/* .
cp -r "$TEMPLATE_DIR"/.gitignore .
cp -r "$TEMPLATE_DIR"/.env.example .

# Supprimer le script d'init du nouveau projet
rm -f init-project.sh

success "Fichiers copiés"

# Initialiser git
info "🔧 Initialisation de Git..."
git init
git add .
git commit -m "Initial commit from Strapi GraphQL template"
success "Repository Git initialisé"

# Générer les secrets
info "🔐 Génération des secrets de sécurité..."

generate_secret() {
    node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"
}

APP_KEY_1=$(generate_secret)
APP_KEY_2=$(generate_secret)
API_TOKEN_SALT=$(generate_secret)
ADMIN_JWT_SECRET=$(generate_secret)
TRANSFER_TOKEN_SALT=$(generate_secret)
JWT_SECRET=$(generate_secret)
ENCRYPTION_KEY=$(generate_secret)

# Créer le fichier .env avec les secrets générés
cat > .env << EOF
HOST=0.0.0.0
PORT=1337
APP_KEYS="$APP_KEY_1,$APP_KEY_2"
API_TOKEN_SALT=$API_TOKEN_SALT
ADMIN_JWT_SECRET=$ADMIN_JWT_SECRET
TRANSFER_TOKEN_SALT=$TRANSFER_TOKEN_SALT
JWT_SECRET=$JWT_SECRET
ENCRYPTION_KEY=$ENCRYPTION_KEY

# Database configuration (SQLite par défaut)
DATABASE_CLIENT=sqlite
DATABASE_FILENAME=.tmp/data.db

# Pour PostgreSQL, décommentez et configurez :
# DATABASE_CLIENT=postgres
# DATABASE_HOST=localhost
# DATABASE_PORT=5432
# DATABASE_NAME=strapi
# DATABASE_USERNAME=strapi
# DATABASE_PASSWORD=strapi
# DATABASE_SSL=false

# Pour MySQL, décommentez et configurez :
# DATABASE_CLIENT=mysql
# DATABASE_HOST=localhost
# DATABASE_PORT=3306
# DATABASE_NAME=strapi
# DATABASE_USERNAME=strapi
# DATABASE_PASSWORD=strapi
# DATABASE_SSL=false
EOF

success "Fichier .env créé avec des secrets sécurisés"

# Installer les dépendances
info "📥 Installation des dépendances (cela peut prendre quelques minutes)..."
npm install

success "Dépendances installées"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  ✨ Projet '$PROJECT_NAME' créé avec succès ! ✨${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}📝 Prochaines étapes :${NC}"
echo ""
echo "  1. Accédez au projet :"
echo -e "     ${YELLOW}cd $PROJECT_NAME${NC}"
echo ""
echo "  2. Démarrez le serveur de développement :"
echo -e "     ${YELLOW}npm run dev${NC}"
echo ""
echo "  3. Créez votre compte admin :"
echo -e "     ${YELLOW}http://localhost:1337/admin${NC}"
echo ""
echo "  4. Accédez au playground GraphQL :"
echo -e "     ${YELLOW}http://localhost:1337/graphql${NC}"
echo ""
echo -e "${BLUE}📚 Documentation :${NC}"
echo "  - Strapi : https://docs.strapi.io"
echo "  - GraphQL Plugin : https://docs.strapi.io/dev-docs/plugins/graphql"
echo ""
echo -e "${GREEN}Bon développement ! 🚀${NC}"
echo ""
