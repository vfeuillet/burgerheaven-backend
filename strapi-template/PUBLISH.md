# 📤 Guide de publication du template

Ce guide explique comment publier ce template sur GitHub pour le rendre réutilisable.

## 🎯 Étapes de publication

### 1. Initialiser Git et créer le premier commit

```bash
cd /home/user/strapi-template

# Initialiser Git
git init

# Ajouter tous les fichiers
git add .

# Créer le commit initial
git commit -m "Initial commit: Strapi GraphQL Starter Template

- Strapi 5.19.0 with TypeScript
- GraphQL plugin pre-configured
- Multi-database support (PostgreSQL, MySQL, SQLite)
- Production-ready configuration
- Auto-initialization script
- Comprehensive documentation"
```

### 2. Créer un repository sur GitHub

#### Option A : Via l'interface GitHub

1. Allez sur https://github.com/new
2. Nommez le repo : `strapi-graphql-starter` ou `strapi-template`
3. Description : "A production-ready Strapi template with GraphQL and multi-database support"
4. Choisissez "Public" pour le partager
5. **NE PAS** initialiser avec README, .gitignore ou licence (vous les avez déjà)
6. Cliquez sur "Create repository"

#### Option B : Via le CLI GitHub (gh)

```bash
# Si vous avez gh CLI installé
gh repo create strapi-graphql-starter \
  --public \
  --description "A production-ready Strapi template with GraphQL and multi-database support" \
  --source=. \
  --remote=origin \
  --push
```

### 3. Lier le repository local au repository distant

```bash
# Ajouter le remote (remplacez USERNAME par votre nom d'utilisateur GitHub)
git remote add origin https://github.com/USERNAME/strapi-graphql-starter.git

# Ou avec SSH
git remote add origin git@github.com:USERNAME/strapi-graphql-starter.git

# Vérifier
git remote -v
```

### 4. Pousser le code

```bash
# Créer la branche main et pousser
git branch -M main
git push -u origin main
```

### 5. Configurer le repository comme template

1. Allez sur votre repository GitHub
2. Cliquez sur "Settings" (⚙️)
3. Dans la section "General", cochez "Template repository"
4. Sauvegardez

**Maintenant, les utilisateurs pourront cliquer sur "Use this template" pour créer leurs projets !**

### 6. Ajouter des badges au README

Ajoutez ces badges en haut du README.md :

```markdown
# 🚀 Strapi GraphQL Starter Template

[![GitHub stars](https://img.shields.io/github/stars/USERNAME/strapi-graphql-starter?style=social)](https://github.com/USERNAME/strapi-graphql-starter/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/USERNAME/strapi-graphql-starter?style=social)](https://github.com/USERNAME/strapi-graphql-starter/network/members)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Node Version](https://img.shields.io/badge/node-%3E%3D18.0.0-brightgreen)](https://nodejs.org)
[![Strapi Version](https://img.shields.io/badge/strapi-5.19.0-blue)](https://strapi.io)
```

### 7. Créer des releases (optionnel mais recommandé)

```bash
# Créer un tag pour la première version
git tag -a v1.0.0 -m "Release v1.0.0

Features:
- Initial Strapi 5.19.0 template
- GraphQL support
- Multi-database configuration
- Auto-initialization script
- Comprehensive documentation"

# Pousser le tag
git push origin v1.0.0
```

Puis sur GitHub :
1. Allez dans "Releases"
2. Cliquez "Draft a new release"
3. Sélectionnez le tag v1.0.0
4. Titre : "v1.0.0 - Initial Release"
5. Décrivez les fonctionnalités
6. Publiez

### 8. Ajouter des topics GitHub

Sur GitHub, ajoutez ces topics à votre repo :
- `strapi`
- `strapi-template`
- `graphql`
- `typescript`
- `nodejs`
- `cms`
- `starter-template`
- `postgresql`
- `mysql`
- `sqlite`

### 9. Créer un fichier CONTRIBUTING.md (optionnel)

```markdown
# Contributing to Strapi GraphQL Starter

## How to contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Code Style

- Use TypeScript
- Follow ESLint rules
- Write clear commit messages

## Reporting Issues

Please use GitHub Issues to report bugs or request features.
```

## 🌟 Promouvoir le template

### 1. Partager sur les réseaux sociaux

- Twitter/X : Mentionnez @strapijs
- LinkedIn
- Reddit : r/node, r/webdev, r/Strapi
- Dev.to : Écrivez un article de présentation

### 2. Soumettre à des listes

- [Awesome Strapi](https://github.com/strapi/awesome-strapi)
- [Awesome Node.js](https://github.com/sindresorhus/awesome-nodejs)

### 3. Créer un article de blog

Exemple de structure :
1. Introduction : Pourquoi ce template ?
2. Fonctionnalités principales
3. Guide d'installation
4. Exemples d'utilisation
5. Cas d'usage
6. Conclusion

## 📊 Maintenance

### Mettre à jour Strapi régulièrement

```bash
# Vérifier les mises à jour
npm run upgrade:dry

# Mettre à jour
npm run upgrade

# Tester que tout fonctionne
npm run build

# Commiter et pousser
git commit -am "Update to Strapi X.X.X"
git push
```

### Créer une nouvelle release après chaque mise à jour majeure

```bash
git tag -a v1.1.0 -m "Update to Strapi 5.20.0"
git push origin v1.1.0
```

## 🎯 Checklist avant publication

- [ ] Tous les fichiers de configuration sont génériques (pas de données spécifiques)
- [ ] Le README est clair et complet
- [ ] Les secrets dans .env.example sont des placeholders
- [ ] Le script d'initialisation fonctionne
- [ ] La licence est appropriée (MIT)
- [ ] Les dépendances sont à jour
- [ ] Le .gitignore est complet
- [ ] La documentation est complète
- [ ] Les exemples fonctionnent
- [ ] Le repository est configuré comme template sur GitHub

## 🆘 Support

Une fois publié, assurez-vous de :
- Répondre aux issues rapidement
- Accepter les pull requests utiles
- Maintenir le template à jour
- Documenter les breaking changes

---

**Bon courage pour la publication ! 🚀**
