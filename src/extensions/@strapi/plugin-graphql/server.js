console.log('✅ Extension GraphQL : server.js exécuté');

module.exports = {
  register() {
    console.log('📌 Extension GraphQL : register() appelé');
  },
  bootstrap() {
    console.log('🚀 Extension GraphQL : bootstrap() appelé');
  },
};