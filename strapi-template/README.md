# 🚀 Strapi GraphQL Starter Template

Un template Strapi complet avec support GraphQL et configuration multi-base de données (PostgreSQL, MySQL, SQLite).

## ✨ Fonctionnalités

- ✅ **Strapi 5.19.0** - Dernière version stable
- ✅ **GraphQL** - Plugin GraphQL pré-configuré avec playground
- ✅ **Multi-Database** - Support PostgreSQL, MySQL et SQLite
- ✅ **TypeScript** - Configuration TypeScript complète
- ✅ **Production Ready** - Configuration optimisée pour le déploiement
- ✅ **Users & Permissions** - Plugin d'authentification inclus

## 📋 Prérequis

- Node.js >= 18.0.0 <= 22.x.x
- npm >= 6.0.0
- Une base de données (PostgreSQL, MySQL ou SQLite)

## 🎯 Démarrage rapide

### 1. Créer un nouveau projet

```bash
# Cloner le template
git clone <url-de-ce-repo> mon-projet
cd mon-projet

# Supprimer l'historique git du template
rm -rf .git
git init
```

### 2. Installation des dépendances

```bash
npm install
```

### 3. Configuration de l'environnement

```bash
# Copier le fichier d'exemple
cp .env.example .env

# Générer les secrets (IMPORTANT !)
# Vous devez remplacer tous les "tobemodified" par des valeurs aléatoires sécurisées
```

**Générer des secrets sécurisés :**

```bash
# Sur Linux/macOS
node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"

# Répétez cette commande pour chaque variable :
# - APP_KEYS (générez 2 clés séparées par une virgule)
# - API_TOKEN_SALT
# - ADMIN_JWT_SECRET
# - TRANSFER_TOKEN_SALT
# - JWT_SECRET
# - ENCRYPTION_KEY
```

### 4. Configuration de la base de données

#### Option A : SQLite (par défaut - idéal pour le développement)

```env
DATABASE_CLIENT=sqlite
DATABASE_FILENAME=.tmp/data.db
```

#### Option B : PostgreSQL

```env
DATABASE_CLIENT=postgres
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=strapi
DATABASE_USERNAME=strapi
DATABASE_PASSWORD=strapi
DATABASE_SSL=false
```

#### Option C : MySQL

```env
DATABASE_CLIENT=mysql
DATABASE_HOST=localhost
DATABASE_PORT=3306
DATABASE_NAME=strapi
DATABASE_USERNAME=strapi
DATABASE_PASSWORD=strapi
DATABASE_SSL=false
```

### 5. Démarrer l'application

```bash
# Mode développement (avec auto-reload)
npm run dev

# Mode production
npm run build
npm run start
```

### 6. Accéder à l'application

- **Admin Panel** : http://localhost:1337/admin
- **GraphQL Playground** : http://localhost:1337/graphql
- **API REST** : http://localhost:1337/api

## 📁 Structure du projet

```
.
├── config/                 # Configuration de l'application
│   ├── admin.ts           # Configuration du panel admin
│   ├── api.ts             # Configuration de l'API REST
│   ├── database.ts        # Configuration multi-database
│   ├── middlewares.ts     # Middlewares Strapi
│   ├── plugins.ts         # Configuration des plugins (GraphQL)
│   └── server.ts          # Configuration du serveur
├── database/
│   └── migrations/        # Migrations de base de données
├── public/                # Fichiers publics
│   └── uploads/           # Uploads de médias
├── src/
│   ├── admin/             # Personnalisation de l'admin
│   ├── api/               # Vos APIs personnalisées
│   ├── extensions/        # Extensions de plugins
│   └── index.ts           # Point d'entrée de l'application
├── types/                 # Types TypeScript générés
├── .env.example           # Template des variables d'environnement
├── .gitignore            # Fichiers à ignorer par Git
├── package.json          # Dépendances et scripts
└── tsconfig.json         # Configuration TypeScript
```

## 🔧 Configuration GraphQL

Le plugin GraphQL est pré-configuré avec les paramètres suivants :

- **Endpoint** : `/graphql`
- **Playground** : Toujours activé
- **Shadow CRUD** : Activé (génération automatique des requêtes)
- **Depth Limit** : 10
- **Amount Limit** : 100

Modifiez ces paramètres dans `config/plugins.ts` selon vos besoins.

## 📝 Créer votre premier Content Type

### Via l'interface admin

1. Démarrez l'application : `npm run dev`
2. Créez un compte admin : http://localhost:1337/admin
3. Allez dans **Content-Type Builder**
4. Créez votre premier Content Type
5. Le schéma GraphQL sera généré automatiquement !

### Via le CLI

```bash
npm run strapi generate
```

## 🚀 Déploiement

### Railway / Heroku / Render

1. Configurez les variables d'environnement de production
2. Assurez-vous d'utiliser PostgreSQL en production
3. Buildez l'application : `npm run build`
4. Démarrez : `npm start`

### Variables d'environnement de production

```env
NODE_ENV=production
DATABASE_CLIENT=postgres
DATABASE_URL=postgresql://user:password@host:5432/database
HOST=0.0.0.0
PORT=1337
```

## 📚 Documentation

- [Strapi Documentation](https://docs.strapi.io)
- [GraphQL Plugin](https://docs.strapi.io/dev-docs/plugins/graphql)
- [Deployment Guide](https://docs.strapi.io/dev-docs/deployment)

## 🛠️ Scripts disponibles

| Script | Description |
|--------|-------------|
| `npm run dev` | Démarre en mode développement avec auto-reload |
| `npm run build` | Build l'admin panel pour la production |
| `npm start` | Démarre en mode production |
| `npm run strapi` | Accès au CLI Strapi |
| `npm run upgrade` | Met à jour Strapi vers la dernière version |

## 🤝 Contribuer

Si vous trouvez des améliorations à apporter à ce template, n'hésitez pas à créer une issue ou une pull request !

## 📄 Licence

MIT

---

**Template créé avec ❤️ pour accélérer vos projets Strapi**
