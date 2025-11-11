// src/api/ligne-de-commande/content-types/ligne-de-commande/lifecycles.ts

const UID_LCD = 'api::ligne-de-commande.ligne-de-commande';
const UID_CMD = 'api::commande.commande';

export default {
  // Option : auto-remplir le prix unitaire depuis le produit si absent
  async beforeCreate(event) {
    const d = event.params.data;
    if (!d?.prix_unitaire && d?.produit) {
      const prod = await strapi.entityService.findOne('api::produit.produit', d.produit, {
        fields: ['prix'],
      });
      d.prix_unitaire = prod?.prix ?? 0;
    }
  },

  async afterCreate(event) { await recomputeTotal(event); },
  async afterUpdate(event) { await recomputeTotal(event); },
  async afterDelete(event) { await recomputeTotal(event); },
};

async function recomputeTotal(event: any) {
  const ligne = event.result || {};

  // documentId OU id interne de la commande selon ce que renvoie l’évènement
  const cmdDocId =
    typeof ligne.commande === 'object'
      ? (ligne.commande?.documentId ?? ligne.commande?.id ?? ligne.commande)
      : ligne.commande;

  if (!cmdDocId) return;

  // 1) Résoudre l'ID interne (numérique) via le Document Service
  const cmd = await strapi.documents(UID_CMD).findOne({ documentId: cmdDocId });
  const cmdId = cmd?.id;
  if (!cmdId) return;

  // 2) Récupérer toutes les lignes rattachées à cette commande (par ID interne)
  const lignes = await strapi.entityService.findMany(UID_LCD, {
    filters: { commande: { id: { $eq: cmdId } } },
    fields: ['quantite', 'prix_unitaire'],
    limit: -1,
  });

  // 3) Somme quantite * prix_unitaire
  const total = (lignes ?? []).reduce((sum: number, l: any) => {
    const q = Number(l?.quantite || 0);
    const p = Number(l?.prix_unitaire || 0);
    return sum + q * p;
  }, 0);

  // 4) Mise à jour de la commande par documentId via le Document Service
  await strapi.documents(UID_CMD).update({
    documentId: cmdDocId,
    data: { total },
  });
}