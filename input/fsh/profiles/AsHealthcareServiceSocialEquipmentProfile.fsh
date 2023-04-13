Profile: AsHealthcareServiceSocialEquipmentProfile
Parent: HealthcareService
Id: as-healthcareservice-social-equipment
Title: "AS HealthcareService Social Equipment Profile"
Description: "Profil créé à partir de la ressource HealthcareService dans le contexte de l'Annuaire Santé pour décrire les équipements sociaux représentant les activités des établissements du domaine social et médico-social enregistrés dans FINESS."

* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open

* extension contains
    $HealthcareService-authorizationDate named authorizationDate 0..1 MS and
    $HealthcareService-implementationPeriod named installationDate 0..1 MS
* extension[installationDate] ^isModifier = false
* identifier ..0
* providedBy ^short = "Référence vers la structure FINESS ET"
* providedBy ^definition = "Reference vers l'id de la ressource de la structure FINESS ET à laquelle est rattaché cet equipement social"
* category ..0
* type from $JDV-J136-DisciplineEquipementSocial-RASS (required)
* type ^binding.description = "La discipline détermine la nature de l’activité"
* specialty ..0
* location ..0
* name ..0
* comment ..0
* extraDetails ..0
* photo ..0
* telecom ..0
* coverageArea ..0
* serviceProvisionCode ..0
* eligibility.code from $JDV-J137-Clientele-RASS (extensible)
* eligibility.code ^binding.description = "Population prise en charge par l’établissement dans le cadre de l’activité associée à la discipline"
* eligibility.comment ..0
* program ..0
* characteristic from $JDV-J138-TypeActivite-RASS (extensible)
* characteristic ^binding.description = "Le mode de fonctionnement précise la modalité d’accueil, d’hébergement et/ou d’ouverture de l’activité associée à la discipline"
* communication ..0
* referralMethod ..0
* appointmentRequired ..0
* availableTime ..0
* notAvailable ..0
* availabilityExceptions ..0
* endpoint ..0
