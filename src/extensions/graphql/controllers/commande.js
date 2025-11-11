'use strict';
const { v4: uuidv4 } = require('uuid');
const { z } = require('zod');

module.exports = {
  async createCommande(_, { input }, { strapi }) {
    // 1. Valide les inputs
    const schema = z.object({
      nom_client: z.string().min(1),
      email_client: z.string().email(),
      horaire_retrait: z.string().regex(/^([01]\d|2[0-3]):([0-5]\d)$/),
      lignes: z.array(z.object({
        produitId: z.string(),
        quantite: z.number().int().min(1),
        options: z.any().optional(),
      })).min(1),
    });
    const { nom_client, email_client, horaire_retrait, lignes } = schema.parse(input);

    // 2. Récupère les prix
    const produits = await Promise.all(
      lignes.map(l =>
        strapi.entityService.findOne('api::produit.produit', l.produitId, { fields: ['prix'] })
      )
    );

    // 3. Calcule total et prépare les lignes
    let total = 0;
    const lignesData = lignes.map((l, i) => {
      const prix = produits[i].prix;
      total += prix * l.quantite;
      return {
        quantite: l.quantite,
        prix_unitaire: prix,
        produit: l.produitId,
        options: l.options || null,
      };
    });

    // 4. Génère code de retrait
    const code_retrait = uuidv4().split('-')[0].toUpperCase();

    // 5. Crée la commande et ses lignes
    const created = await strapi.entityService.create('api::commande.commande', {
      data: {
        nom_client,
        email_client,
        horaire_retrait,
        total,
        code_retrait,
        lignes_de_commandes: { create: lignesData },
      },
      populate: { lignes_de_commandes: { populate: ['produit'] } },
    });

    return { data: created };
  },
};
   