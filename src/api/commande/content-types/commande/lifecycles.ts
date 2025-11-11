import crypto from 'crypto';

const UID_CMD = 'api::commande.commande';

export default {
  async beforeCreate(event) {
    const data = event.params.data;

    // Statut par défaut
    if (!data.statut) {
      data.statut = 'en_attente';
    }

    // Code de retrait unique si absent
    if (!data.code_retrait) {
      let code: string;
      while (true) {
        code = crypto.randomBytes(3).toString('hex').toUpperCase(); // ex: A4F9C1
        const exists = await strapi.entityService.count(UID_CMD, {
          filters: { code_retrait: code },
        });
        if (exists === 0) break;
      }
      data.code_retrait = code;
    }
  },
};