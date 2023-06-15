Profile: AsOrganizationProfile
Parent: FrOrganization
Id: as-organization
Title: "AS Organization Profile"
Description: "Profil créé à partir de FrOrganization dans le contexte de l'Annuaire Santé pour décrire les organismes du domaine sanitaire, médico-social et social immatriculés dans le fichier national des établissements sanitaires et sociaux (FINESS) ou dans le Système Informatique pour le Répertoire des Entreprises et de leurs Établissements (SIRENE) dédié aux entreprises, associations et organismes du secteur public."

/* profils references */
* partOf only Reference(FrOrganization or AsOrganizationProfile)

// Data trace
* meta.extension ^slicing.discriminator.type = #value
* meta.extension ^slicing.discriminator.path = "url"
* meta.extension ^slicing.rules = #open
* meta.extension contains as-ext-data-trace named as-ext-data-trace 0..1 MS


/* donnees metiers */
// Organization.identifier
* identifier MS 
* identifier ^short = "Une instance par identifiant (FINESS, SIREN, SIRET, idNat_Struct…)."
* identifier.use = #official (exactly)
* identifier.type ^short = "Les codes FINEJ, FINEG, SIREN, SIRET, IDNST, INTRN proviennent de la terminologie  http://interopsante.org/CodeSystem/fr-v2-0203 \r\n Les codes 0,4 proviennent de la terminologie TRE-G07-TypeIdentifiantStructure."
* identifier.type obeys constr-bind-type
* identifier.system ^short = "« urn:oid:1.2.250.1.71.4.2.2 » si l’instance correspond à l’identification nationale des structures (idNat_Struct)\r\n « http://sirene.fr» si l’instance correspond à un identifiant SIREN ou SIRET \r\n « http://finess.sante.gouv.fr» si l’instance correspond à un identifiant FINESS EG ou EJ \r\n « urn:oid:1.2.250.1.213.1.6.4.3 » si l’instance correspond à un identifiant ADELI rang ou RPPS rang\r\n« https://annuaire.sante.fr » si l’instance correspond à l’identifiant technique de la structure."
* identifier.value ^short = "Identification nationale de la structure, Numéro SIRET, Numéro SIREN, Numéro FINESS Etablissement, Numéro FINESS EJ, RPPS rang, ADELI rang, Identifiant technique de la structure."

// Organization.active
* active MS
* active ^short = "La ressource est-elle active? (active | inactive)"
* active ^comment = "true par défaut; false pour les structures supprimées."

// Organization.name
* name MS
* name ^comment = "Synonyme : raisonSociale, dénomination"
* name ^short = "Raison sociale de la structure."

// Organization.alias
* alias MS
* alias ^comment = "Synonyme : complementRaisonSociale"
* alias ^short = "Enseigne commerciale de la structure."

/* champ d'activite de la structure */
// Slice deja defini dans FrOrganization
* type MS
* type contains
    activiteINSEE 0..* and
    statutJuridiqueINSEE 0..* and 
    sphParticipation 0..* 

// organizationType - slice deja existant 
* type[organizationType] ^sliceName = "organizationType"
* type[organizationType] ^comment = "typeStructure"
* type[organizationType] ^short = "Type de structure \r\nEntité Juridique : LEGAL-ENTITY; \r\nEntité Géographique : GEOGRAPHICAL-ENTITY"

// activiteINSEE
* type[activiteINSEE] from $JDV-J99-InseeNAFrav2Niveau5-RASS (required)
* type[activiteINSEE] ^short = "Toute entité juridique et chacun de ses établissements (EG) se voit attribuer par l'Insee, lors de son inscription au répertoire SIRENE, un code caractérisant son activité principale par référence à la nomenclature d'activités française (NAF rév. 2).\r\nPlus précisément, on distingue le code APET pour les EG."
* type[activiteINSEE] ^comment = "Synonyme : codeAPEN"

// statutJuridiqueINSEE
* type[statutJuridiqueINSEE] from $JDV-J100-FinessStatutJuridique-RASS (required)
* type[statutJuridiqueINSEE] ^short = "Statut juridique FINESS qui caractérise la situation juridique de la personne morale."
* type[statutJuridiqueINSEE] ^comment = "Synonyme : statutJuridiqueINSEE"

// modaliteParticipationSPH
* type[sphParticipation] from $JDV-J162-ESPIC-RASS (required)
* type[sphParticipation] ^short = "Modalités de participation au service public hospitalier."
* type[sphParticipation] ^comment = "Synonyme : modaliteParticipationSPH"

// adresse
* address MS
* address ^comment = "adresse"
* address ^short = "adresseEJ : Adresse géopostale de l'entité juridique ou adresseEG : Adresse(s) géopostale(s) de l'entité géographique."
* address only AsAddressExtendedProfile

// telecommunication
* telecom MS
* telecom ^short = "Différentes instances pour les téléphones, la télécopie et l’adresse mail."
* telecom.system ^comment = "https://www.hl7.org/fhir/valueset-contact-point-system.html"
* telecom.use ^comment = "« old » si les coordonnées de structure ont une date de fin"

// boiteLettresMSS

// boiteLettreMSS
* telecom ^slicing.rules = #open
* telecom ^slicing.discriminator.type = #pattern
* telecom ^slicing.discriminator.path = "code"
* telecom contains mailbox-mss 0..*
* telecom[mailbox-mss] only as-mailbox-mss
* telecom[mailbox-mss] ^short = "[DR] : Coordonnées téléphoniques spécifiques à l’usage de la BAL MSS."
* telecom[mailbox-mss] ^comment = "mailBoxMSS.phone"


// Organization.contact
* contact MS
* contact ^short = "Point de contact."
* contact ^comment = "Personne ou service agissant comme point de contact auprès d'une autre personne ou d'un autre service."



// lien EG/EJ
* partOf ^short = "Référence vers la structure de rattachement (lien EG/ EJ)."
* partOf ^comment = "Chaque entité geographique et ratachée à une entité juridique. C'est l'id de la ressource de l'entité juridique à laquelle est ratachée la structure qui est remontée dans l'element de référence partOf de l'entité géographique."

// periode d'activite
* extension[usePeriod] ^sliceName = "usePeriod"
* extension[usePeriod].valuePeriod ^sliceName = "valuePeriod"
* extension[usePeriod].valuePeriod.start ^short = "Date d'ouverture de la structure."
* extension[usePeriod].valuePeriod.end ^short = "Date de fermeture de la structure."

// extensions
* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open
* extension contains
    AsDigitalCertificateExtension named as-ext-digital-certificate 0..1 MS and
    AsOrganizationPharmacyLicenceExtension named as-ext-organization-pharmacy-licence 0..* MS
    
// digitalCertificate
* extension[as-ext-digital-certificate] ^isModifier = false
* extension[as-ext-digital-certificate] ^short = "[DR] : certificat."
* extension[as-ext-digital-certificate] ^comment = "Données descriptives du moyen d’identification par certificat."

// numeroLicence pour les officines
* extension[as-ext-organization-pharmacy-licence] ^isModifier = false
* extension[as-ext-organization-pharmacy-licence] ^comment = "Synonyme : numeroLicence"
* extension[as-ext-organization-pharmacy-licence] ^short = "Numéro de la licence d'exploitation d’une officine."

// Organization.endpoint
* endpoint MS


Invariant:   constr-bind-type
Description: "Les valeurs possibles pour cet élément doivent provenir d’une des terminologies de référence suivantes :
\r\n fr-organization-identifier-type , URL : http://interopsante.org/CodeSystem/fr-v2-0203
\r\n TRE_G07-TypeIdentifiantStructure , OID : 1.2.250.1.71.1.2.14 
\r\n JDV_J104-TypeIdentifiantStructure-RASS , OID : 1.2.250.1.213.1.6.1.172
\r\nLes valeurs possibles peuvent être restreintes en fonction du jeu de valeurs correspondant mis à disposition par le projet (exemple : fr-organization-identifier-type ).\r\nEn l’absence de spécifications complémentaires, le jeu de valeurs JDV_J104-TypeIdentifiantStructure-RASS peut être utilisé."
Expression:       "f:type"
Severity:    #error

