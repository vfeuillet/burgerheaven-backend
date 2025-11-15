# 📖 Guide d'utilisation du Template

## 🎯 Méthodes d'utilisation

### Méthode 1 : Utiliser le script d'initialisation (Recommandé)

```bash
# Depuis le dossier contenant le template
./init-project.sh mon-nouveau-projet

# Le script va automatiquement :
# ✓ Créer le dossier du projet
# ✓ Copier tous les fichiers
# ✓ Initialiser Git
# ✓ Générer des secrets sécurisés
# ✓ Créer le fichier .env
# ✓ Installer les dépendances
```

### Méthode 2 : Clone manuel

```bash
# Cloner le template
git clone <url-du-template> mon-projet
cd mon-projet

# Supprimer l'historique git du template
rm -rf .git
git init

# Copier et configurer .env
cp .env.example .env
# Éditez .env et remplacez tous les "tobemodified"

# Installer les dépendances
npm install

# Démarrer
npm run dev
```

### Méthode 3 : Utiliser comme template GitHub

1. Sur GitHub, cliquez sur "Use this template"
2. Créez votre nouveau repository
3. Clonez votre nouveau repo
4. Suivez les étapes de configuration

## 🔐 Génération des secrets

**IMPORTANT** : Ne jamais utiliser les valeurs par défaut en production !

### Générer un secret unique

```bash
node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"
```

### Script pour générer tous les secrets

```bash
#!/bin/bash
echo "APP_KEYS=\"$(node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"),$(node -e "console.log(require('crypto').randomBytes(32).toString('base64'))")\""
echo "API_TOKEN_SALT=$(node -e "console.log(require('crypto').randomBytes(32).toString('base64'))")"
echo "ADMIN_JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('base64'))")"
echo "TRANSFER_TOKEN_SALT=$(node -e "console.log(require('crypto').randomBytes(32).toString('base64'))")"
echo "JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('base64'))")"
echo "ENCRYPTION_KEY=$(node -e "console.log(require('crypto').randomBytes(32).toString('base64'))")"
```

## 🗄️ Configuration de la base de données

### SQLite (développement)

Parfait pour débuter, aucune installation requise :

```env
DATABASE_CLIENT=sqlite
DATABASE_FILENAME=.tmp/data.db
```

### PostgreSQL (production recommandée)

```env
DATABASE_CLIENT=postgres
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=mon_app
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=motdepasse
DATABASE_SSL=false
```

**Avec URL de connexion** (Railway, Render, etc.) :

```env
DATABASE_CLIENT=postgres
DATABASE_URL=postgresql://user:password@host:5432/database
```

### MySQL

```env
DATABASE_CLIENT=mysql
DATABASE_HOST=localhost
DATABASE_PORT=3306
DATABASE_NAME=mon_app
DATABASE_USERNAME=root
DATABASE_PASSWORD=motdepasse
DATABASE_SSL=false
```

## 🎨 Exemples de Content Types

### 1. Blog simple

```bash
# Démarrez le serveur
npm run dev

# Dans l'admin (http://localhost:1337/admin)
# Créez un Content Type "Article" avec :
# - titre (Text)
# - contenu (Rich Text)
# - image (Media - Single)
# - auteur (Text)
# - date_publication (Date)
# - publie (Boolean)
```

**Requête GraphQL** :

```graphql
query {
  articles {
    data {
      id
      attributes {
        titre
        contenu
        auteur
        date_publication
        image {
          data {
            attributes {
              url
            }
          }
        }
      }
    }
  }
}
```

### 2. E-commerce basique

```bash
# Content Type "Produit" :
# - nom (Text)
# - description (Text)
# - prix (Decimal)
# - stock (Integer)
# - image (Media - Single)
# - categorie (Enumeration: electronique, vetement, maison)
# - en_vente (Boolean)
```

**Requête GraphQL avec filtre** :

```graphql
query {
  produits(filters: { en_vente: { eq: true } }) {
    data {
      id
      attributes {
        nom
        prix
        stock
        categorie
      }
    }
  }
}
```

### 3. Relations entre Content Types

**Content Type "Auteur"** :
- nom (Text)
- email (Email)
- bio (Text)

**Content Type "Article"** :
- titre (Text)
- contenu (Rich Text)
- auteur (Relation - Many to One avec Auteur)

**Requête avec relation** :

```graphql
query {
  articles {
    data {
      attributes {
        titre
        auteur {
          data {
            attributes {
              nom
              email
            }
          }
        }
      }
    }
  }
}
```

## 🚀 Déploiement

### Railway

```bash
# 1. Installer le CLI Railway
npm i -g @railway/cli

# 2. Login
railway login

# 3. Créer un nouveau projet
railway init

# 4. Ajouter PostgreSQL
railway add

# 5. Configurer les variables d'environnement
railway variables set NODE_ENV=production

# 6. Déployer
railway up
```

### Render

1. Créez un nouveau "Web Service"
2. Connectez votre repo GitHub
3. Configurez :
   - Build Command : `npm install && npm run build`
   - Start Command : `npm start`
4. Ajoutez une base de données PostgreSQL
5. Configurez les variables d'environnement

### Heroku

```bash
# 1. Créer l'app
heroku create mon-app

# 2. Ajouter PostgreSQL
heroku addons:create heroku-postgresql:mini

# 3. Configurer les variables
heroku config:set NODE_ENV=production
heroku config:set APP_KEYS="key1,key2"
# ... autres variables

# 4. Déployer
git push heroku main
```

## 🔧 Personnalisation avancée

### Ajouter des middlewares personnalisés

Créez `src/middlewares/custom.ts` :

```typescript
export default (config, { strapi }) => {
  return async (ctx, next) => {
    console.log('Custom middleware');
    await next();
  };
};
```

Puis dans `config/middlewares.ts` :

```typescript
export default [
  'strapi::errors',
  'strapi::security',
  {
    name: 'global::custom',
    config: {},
  },
  // ... autres middlewares
];
```

### Personnaliser le panel admin

Créez `src/admin/app.tsx` :

```typescript
export default {
  config: {
    locales: ['fr'],
    translations: {
      fr: {
        'app.components.HomePage.welcome': 'Bienvenue sur mon app !',
      },
    },
  },
  bootstrap() {},
};
```

## 📊 Monitoring et logs

### Activer les logs détaillés

Dans `.env` :

```env
# Logs
STRAPI_LOG_LEVEL=debug
STRAPI_LOG_TIMESTAMP=true
STRAPI_LOG_FORCE_COLOR=true
```

### Intégration avec des services externes

- **Sentry** : Pour le monitoring d'erreurs
- **LogRocket** : Pour l'enregistrement de sessions
- **DataDog** : Pour les métriques et logs

## 🧪 Tests

### Installer les dépendances de test

```bash
npm install --save-dev jest @types/jest supertest @types/supertest
```

### Exemple de test

Créez `tests/app.test.js` :

```javascript
const request = require('supertest');

describe('Strapi', () => {
  it('should return 200 on health check', async () => {
    await request(strapi.server.httpServer)
      .get('/_health')
      .expect(200);
  });
});
```

## 🎓 Ressources utiles

- [Documentation Strapi](https://docs.strapi.io)
- [GraphQL Plugin](https://docs.strapi.io/dev-docs/plugins/graphql)
- [Strapi Blog](https://strapi.io/blog)
- [Strapi Forum](https://forum.strapi.io)
- [Awesome Strapi](https://github.com/strapi/awesome-strapi)

## ❓ FAQ

### Comment changer le port ?

Dans `.env` :
```env
PORT=3000
```

### Comment activer HTTPS en développement ?

Créez des certificats SSL et configurez dans `config/server.ts`.

### Comment limiter l'accès à l'API ?

Utilisez le plugin Users & Permissions inclus pour gérer les rôles et permissions.

### Comment personnaliser les routes GraphQL ?

Créez des resolvers personnalisés dans `src/extensions/graphql/`.

---

**Besoin d'aide ?** Créez une issue sur GitHub ou consultez la documentation officielle Strapi.
