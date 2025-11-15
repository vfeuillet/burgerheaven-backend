# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-15

### Added
- Initial release of Strapi GraphQL Starter Template
- Strapi 5.19.0 with TypeScript support
- GraphQL plugin pre-configured with playground
- Multi-database support (PostgreSQL, MySQL, SQLite)
- Auto-initialization script (`init-project.sh`)
- Comprehensive documentation (README, TEMPLATE_USAGE, PUBLISH)
- GitHub Actions CI workflow
- MIT License
- Production-ready configuration
- Admin panel configuration
- API REST configuration with sensible defaults
- Environment variables template
- Complete .gitignore file
- TypeScript configuration for both server and admin
- Vite configuration example for admin customization

### Configuration
- Database: Multi-DB support with connection pooling
- Server: Host, port, and app keys configuration
- Admin: JWT secrets and security tokens
- API: Default limits and pagination settings
- Middlewares: All Strapi standard middlewares enabled
- Plugins: GraphQL with shadowCRUD, depth and amount limits

### Documentation
- 215 lines in README.md
- 394 lines in TEMPLATE_USAGE.md with examples
- 232 lines in PUBLISH.md with publication guide
- Detailed setup instructions
- Database configuration examples
- Deployment guides (Railway, Render, Heroku)
- GraphQL usage examples
- Content Type creation examples

### Scripts
- `npm run dev` - Development mode with auto-reload
- `npm run build` - Build admin panel
- `npm run start` - Production mode
- `npm run strapi` - Strapi CLI access
- `npm run upgrade` - Update Strapi to latest version
- `./init-project.sh` - Automated project initialization

### Features
- Automatic secret generation in init script
- Git initialization in init script
- NPM dependencies auto-installation
- Clean project structure
- Ready for deployment
- GitHub template repository compatible
- CI/CD ready with GitHub Actions

## [Unreleased]

### Planned
- Additional database examples (MongoDB support)
- Docker configuration
- More middleware examples
- Advanced GraphQL resolver examples
- Testing setup with Jest
- ESLint and Prettier configuration
- Husky pre-commit hooks
- Environment-specific configurations
- Performance optimization tips

---

For more details, see the [README](README.md) and [TEMPLATE_USAGE](TEMPLATE_USAGE.md).
