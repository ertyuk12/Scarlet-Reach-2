/// DEFINITIONS ///
//#define SUCC_LEVEL_ONE 5
//#define SUCC_LEVEL_TWO 10
//#define SUCC_LEVEL_THREE 15
//#define SUCC_LEVEL_FOUR 25
//#define SUCC_LEVEL_FIVE 50 //functionally, ascension. If you have this many people relying on one rear, you probably have bigger issues

//used VL as a base, so I wouldn't have to manually set up a antag datum
//all of this is copy and pasted from my ratwood fork
GLOBAL_LIST_EMPTY(succubus_objects)

/datum/antagonist/succubus
	name = "Succubus"
	roundend_category = "Succubi"
	antagpanel_category = "Succubus"
	job_rank = ROLE_SUCCUBUS
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "Succubus"
	confess_lines = list(
		"I FEED, THEY MOAN, I STARVE, THEY CRY!",
		"THEIR DESIRE SATES MY HUNGER!",
		"I LOVE ALL, AND ALL WILL LOVE ME!",
	)
	rogue_enabled = TRUE
//	var/isspawn = FALSE
//	var/disguised = FALSE
//	var/ascended = FALSE
	var/starved = FALSE
//	var/sired = FALSE
	var/totalensnared = 0
	var/totalessence = 0
	var/succlevel = 1
	var/strexp = 0
	var/passiveregen = 0
	var/ignore_psycross = FALSE
	var/needexp = 24
	var/vitae = 500
	var/vmax = 1000
//	var/obj/structure/vampire/bloodpool/mypool
	var/last_transform
	//var/cache_skin
	var/obj/item/organ/eyes/cache_eyes
	var/cache_eye_color
//	var/cache_hair
//	var/staked = FALSE
	var/message ="I am a beautiful creature, driven away and forgotten by the Reach. Long ago, willing victims would come to this brothel, and permit me to feed, but the cave-in has stopped the mortals from coming any more, leaving me to starve. I must find fresh essence to sate my hunger!"


/datum/antagonist/succubus/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
//	if(istype(examined_datum, /datum/antagonist/enchanted))
//		return span_boldnotice("A charmed creature.")
	if(istype(examined_datum, /datum/antagonist/succubus))
		return span_boldnotice("Creation of Baotha, My sister!")

	if(istype(examined_datum, /datum/antagonist/succubuslesser))
		return span_boldnotice("A failed creation..Nevertheless, my sister!")

/datum/antagonist/succubus/infil
	name = "Town Succubus"
	roundend_category = "Succubi"
	antagpanel_category = "Succubus"
	job_rank = ROLE_SUCCUBUS
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "Succubus"
	confess_lines = list(
		"I FEED, THEY MOAN, I STARVE, THEY CRY!",
		"THEIR DESIRE SATES MY HUNGER!",
		"I LOVE ALL, AND ALL WILL LOVE ME!",
	)
	rogue_enabled = TRUE
//	var/isspawn = FALSE
//	var/disguised = FALSE
//	var/ascended = FALSE
//	var/sired = FALSE
//	var/ignore_psycross = FALSE
	needexp = 30

	vmax = 750
//	var/obj/structure/vampire/bloodpool/mypool
	//var/cache_skin
//	var/cache_hair
//	var/staked = FALSE


///datum/antagonist/succubus/apply_innate_effects(mob/living/mob_override)
//	var/mob/living/M = mob_override || owner.current
//	add_antag_hud(antag_hud_type, antag_hud_name, M)

///datum/antagonist/succubus/remove_innate_effects(mob/living/mob_override)
//	var/mob/living/M = mob_override || owner.current
//	remove_antag_hud(antag_hud_type, M)

//version used for lesser succubus virtue
/datum/antagonist/succubuslesser
	name = "Succubus"
	roundend_category = "Succubi"
	antagpanel_category = "Succubus"
	job_rank = ROLE_SUCCUBUS
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "Succubus"
	confess_lines = list(
		"BAOTHA SHAPES MY BODY!",
		"BAOTHA GRANTS THE DESIRES OF OTHERS!",
		"LIKE MY STRONGER SISTERS, I FEED ON LOVE!",
	)
	rogue_enabled = TRUE
//	var/isspawn = FALSE
//	var/disguised = FALSE
//	var/ascended = FALSE
	var/starved = FALSE
//	var/sired = FALSE
	var/totalensnared = 0
	var/totalessence = 0
	var/succlevel = 0
	var/vitae = 200
	var/vmax = 500
//	var/obj/structure/vampire/bloodpool/mypool
	var/last_transform
	//var/cache_skin
	var/obj/item/organ/eyes/cache_eyes
	var/cache_eye_color
//	var/cache_hair
//	var/staked = FALSE

/datum/antagonist/succubuslesser/on_gain()
	//var/datum/game_mode/C = SSticker.mode
//	C.succubi |= owner
	. = ..()
	owner.special_role = name
//	ADD_TRAIT(owner.current, TRAIT_NOSTAMINA, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(owner.current, TRAIT_TOXIMMUNE, "[type]")
	ADD_TRAIT(owner.current, TRAIT_BEAUTIFUL, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_EMPATH, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_DEATHBYSNUSNU, "[type]")
	ADD_TRAIT(owner.current, TRAIT_LESSERSUCCUBUS, "[type]")
	ADD_TRAIT(owner.current, TRAIT_ZOMBIE_IMMUNE, "[type]")

//	ADD_TRAIT(owner.current, TRAIT_DEATHBYSNUSNU, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_DECEIVING_MEEKNESS, "[type]")

//	for(var/obj/structure/fluff/traveltile/succubus/tile in GLOB.traveltiles)
//		tile.show_travel_tile(owner.current)
//	owner.current.cmode_music = 'sound/music/combat_baotha.ogg'
	succ_look()
	///owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfixsucc) (this spell will be made when i don't feel lazy, it's awful to get it working
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/succ_rejuv)
//	owner.current.verbs |= /mob/living/carbon/human/proc/succubus_telepathy
//	if(isspawn)
	//	owner.current.verbs |= /mob/living/carbon/human/proc/alter_button
//		owner.current.verbs |= /mob/living/carbon/human/proc/disguise_button
	//	add_objective(/datum/objective/vlordserve)
//		finalize_vampire_lesser()
	//	for(var/obj/structure/vampire/bloodpool/mansion in GLOB.vampire_objects)
//			mypool = mansion
//		equip_spawn()
//		greet()
	//	if(!sired)
		//	addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, spawn_pick_class), "VAMPIRE SPAWN"), 5 SECONDS)
		// All vampyre spawn consider the vampyre lord special
//	for(var/datum/mind/succubus in C.succubi)
//		if (succubus.special_role == "Succubus")
//			owner.add_special_person(succubus.current, "#DC143C")
				// Don't break - an admin may need to create a second vampyre lord
//	forge_succubus_objectives()
//	finalize_succubus()
	//	owner.current.verbs |= /mob/living/carbon/human/proc/demand_submission
	//	owner.current.verbs |= /mob/living/carbon/human/proc/punish_spawn
	//	for(var/obj/structure/vampire/bloodpool/mansion in GLOB.vampire_objects)
	//		mypool = mansion
//	equip_lord()
//	addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "SUCCUBUS"), 5 SECONDS)
//	greet()
		// Vampyre Lord is special to all vampyre spawn
//		for(var/datum/mind/thrall in C.succubi)
//			if (thrall.special_role == "Enchanted")
//				thrall.add_special_person(owner.current, "#DC143C")
//		// And to all death knights

	return ..()



/datum/antagonist/succubus/proc/handle_exp(var/amount = 0)
	var/mob/living/carbon/human/V = owner.current
	strexp += amount
	if (strexp >= needexp)
		succlevel +=1
		needexp += (6 * succlevel)
		strexp = 0
		V.change_stat("endurance", 1)
		V.change_stat("intelligence", 1)
		V.change_stat("strength", 1)
		V.change_stat("constitution", 1)
		vmax += 50
		to_chat(V, "<font color='white'>I feel a little stronger..</font>")
		switch(succlevel)
			if (3)
				ADD_TRAIT(V, TRAIT_INFINITE_STAMINA, "[type]")
			if (5)
				passiveregen += 1
			if (7)
				passiveregen += 1





/datum/antagonist/succubuslesser/proc/succ_look()
	var/mob/living/carbon/human/V = owner.current
//	cache_skin = V.skin_tone
	var/obj/item/organ/eyes/eyes = V.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		cache_eyes = V.dna?.species.organs[ORGAN_SLOT_EYES]
		cache_eye_color = eyes.eye_color
		eyes.Remove(V)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(V)
	set_eye_color(V, cache_eye_color, cache_eye_color)
	eyes.update_accessory_colors()
	V.update_body()
	V.update_hair()
	V.update_body_parts(redraw = TRUE)
	V.faction = list("succubus")


/datum/antagonist/succubuslesser/proc/equip_lord()
	//owner.adjust_skillrank(/datum/skill/magic/blood, 3, TRUE)
//	owner.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
//	owner.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
//	owner.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
//	owner.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
//	pants = /obj/item/clothing/under/roguetown/tights/black
//	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
//	belt = /obj/item/storage/belt/rogue/leather/plaquegold
//	head  = /obj/item/clothing/head/roguetown/vampire
//	beltl = /obj/item/key/vampire
//	cloak = /obj/item/clothing/cloak/cape/puritan
//	shoes = /obj/item/clothing/shoes/roguetown/armor
//	backl = /obj/item/storage/backpack/rogue/satchel

//	owner.current.ambushable = FALSE
	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds("Succubi"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

//	var/mob/living/carbon/human/H = owner.current
//	var/obj/item/organ/eyes/eyes = owner.current.getorganslot(ORGAN_SLOT_EYES)
//	if(eyes)
//		eyes.Remove(owner.current,1)
//		QDEL_NULL(eyes)
//	eyes = new /obj/item/organ/eyes/night_vision/zombie
//	eyes.Insert(owner.current)
	//succ_look()
	//H.equipOutfit(/datum/outfit/job/roguetown/succubus)
	//H.set_patron(/datum/patron/inhumen/baotha)

/datum/antagonist/succubus/on_gain()
	//var/datum/game_mode/C = SSticker.mode
	SSmapping.retainer.succubi |= owner
	. = ..()
	owner.special_role = name
	ADD_TRAIT(owner.current, TRAIT_INFINITE_ENERGY, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_INFINITE_STAMINA, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(owner.current, TRAIT_TOXIMMUNE, "[type]")
	ADD_TRAIT(owner.current, TRAIT_BEAUTIFUL, "[type]")
	ADD_TRAIT(owner.current, TRAIT_EMPATH, "[type]")
	ADD_TRAIT(owner.current, TRAIT_BHBROTHEL, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_DEATHBYSNUSNU, "[type]")
	ADD_TRAIT(owner.current, TRAIT_SUCCUBUS, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_DEATHBYSNUSNU, "[type]")
	ADD_TRAIT(owner.current, TRAIT_DECEIVING_MEEKNESS, "[type]")
	ADD_TRAIT(owner.current, TRAIT_ZOMBIE_IMMUNE, "[type]")

//	for(var/obj/structure/fluff/traveltile/succubus/tile in GLOB.traveltiles)
	//	tile.show_travel_tile(owner.current)
//	owner.current.cmode_music = 'sound/music/combat_baotha.ogg'
	succ_look()
	///owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfixsucc) (if one of you guys can get it working, sure! For now, though...we charm through touch (see sex_action.dm)
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/succ_rejuv)
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/succcharm)
	owner.current.verbs |= /mob/living/carbon/human/proc/succubus_telepathy
//	if(isspawn)
	//	owner.current.verbs |= /mob/living/carbon/human/proc/alter_button
//		owner.current.verbs |= /mob/living/carbon/human/proc/disguise_button
	//	add_objective(/datum/objective/vlordserve)
//		finalize_vampire_lesser()
	//	for(var/obj/structure/vampire/bloodpool/mansion in GLOB.vampire_objects)
//			mypool = mansion
//	equip_spawn()
//	greet()
	//	if(!sired)
		//	addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, spawn_pick_class), "VAMPIRE SPAWN"), 5 SECONDS)
		// All vampyre spawn consider the vampyre lord special
	for(var/datum/mind/succubus in SSmapping.retainer.succubi)
		if (succubus.special_role == "Succubus")
			owner.add_special_person(succubus.current, "#DC143C")
				// Don't break - an admin may need to create a second vampyre lord
//	forge_succubus_objectives()
	finalize_succubus()
	//	owner.current.verbs |= /mob/living/carbon/human/proc/demand_submission
	//	owner.current.verbs |= /mob/living/carbon/human/proc/punish_spawn
	//	for(var/obj/structure/vampire/bloodpool/mansion in GLOB.vampire_objects)
	//		mypool = mansion
	equip_lord()
//	addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "SUCCUBUS"), 5 SECONDS)
	greet()
//		// Vampyre Lord is special to all vampyre spawn
//		for(var/datum/mind/thrall in C.succubi)
//			if (thrall.special_role == "Enchanted")
//				thrall.add_special_person(owner.current, "#DC143C")
//		// And to all death knights

	return ..()



/datum/antagonist/succubus/infil/on_gain()
	message = "I am a beautiful creature, that's managed to slip in, by luck. I still maintain the connection to the ones in the mountain, and I must find a way to permit them to join us, without letting the horrid Tennite heretics harm them. More importamntly, I must find fresh essence to sate my hunger!"
	//var/datum/game_mode/C = SSticker.mode
//	SSmapping.retainer.succubi |= owner
	. = ..()
//	owner.special_role = name
//	ADD_TRAIT(owner.current, TRAIT_INFINITE_ENERGY, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_INFINITE_STAMINA, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_NOHUNGER, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_TOXIMMUNE, "[type]")
//	REMOVE_TRAIT(owner.current, TRAIT_BEAUTIFUL, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_EMPATH, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_BHBROTHEL, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_DEATHBYSNUSNU, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_SUCCUBUS, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_DEATHBYSNUSNU, "[type]")
//	REMOVE_TRAIT(owner.current, TRAIT_DECEIVING_MEEKNESS, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_ZOMBIE_IMMUNE, "[type]")
//	owner.current.change_stat("constitution", -2)
//	owner.current.change_stat("endurance", -2)
//	owner.current.change_stat("perception", -2)
//	owner.current.change_stat("speed", -2)
//	owner.current.change_stat("fortune", 2)

//	for(var/obj/structure/fluff/traveltile/succubus/tile in GLOB.traveltiles)
	//	tile.show_travel_tile(owner.current)
//	owner.current.cmode_music = 'sound/music/combat_baotha.ogg'
//	succ_look()
	///owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfixsucc) (if one of you guys can get it working, sure! For now, though...we charm through touch (see sex_action.dm)
//	owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/succ_rejuv)
//	owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/succcharm)
//	owner.current.verbs |= /mob/living/carbon/human/proc/succubus_telepathy
//	if(isspawn)
	//	owner.current.verbs |= /mob/living/carbon/human/proc/alter_button
//		owner.current.verbs |= /mob/living/carbon/human/proc/disguise_button
	//	add_objective(/datum/objective/vlordserve)
//		finalize_vampire_lesser()
	//	for(var/obj/structure/vampire/bloodpool/mansion in GLOB.vampire_objects)
//			mypool = mansion
//	equip_spawn()
//	greet()
	//	if(!sired)
		//	addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, spawn_pick_class), "VAMPIRE SPAWN"), 5 SECONDS)
		// All vampyre spawn consider the vampyre lord special
//	for(var/datum/mind/succubus in SSmapping.retainer.succubi)
//		if (succubus.special_role == "Succubus")
//			owner.add_special_person(succubus.current, "#DC143C")
				// Don't break - an admin may need to create a second vampyre lord
//	forge_succubus_objectives()
//	finalize_succubus()
	//	owner.current.verbs |= /mob/living/carbon/human/proc/demand_submission
	//	owner.current.verbs |= /mob/living/carbon/human/proc/punish_spawn
	//	for(var/obj/structure/vampire/bloodpool/mansion in GLOB.vampire_objects)
	//		mypool = mansion
//	addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "SUCCUBUS"), 5 SECONDS)
//		// Vampyre Lord is special to all vampyre spawn
//		for(var/datum/mind/thrall in C.succubi)
//			if (thrall.special_role == "Enchanted")
//				thrall.add_special_person(owner.current, "#DC143C")
//		// And to all death knights


// OLD AND EDITED
/datum/antagonist/succubus/proc/equip_lord()
	//owner.adjust_skillrank(/datum/skill/magic/blood, 3, TRUE)
//	owner.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
//	owner.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
//	owner.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
//	owner.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
//	pants = /obj/item/clothing/under/roguetown/tights/black
//	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
//	belt = /obj/item/storage/belt/rogue/leather/plaquegold
//	head  = /obj/item/clothing/head/roguetown/vampire
//	beltl = /obj/item/key/vampire
//	cloak = /obj/item/clothing/cloak/cape/puritan
//	shoes = /obj/item/clothing/shoes/roguetown/armor
//	backl = /obj/item/storage/backpack/rogue/satchel

//	owner.current.ambushable = FALSE
	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds("Succubi"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	var/mob/living/carbon/human/H = owner.current
//	var/obj/item/organ/eyes/eyes = owner.current.getorganslot(ORGAN_SLOT_EYES)
//	if(eyes)
//		eyes.Remove(owner.current,1)
//		QDEL_NULL(eyes)
//	eyes = new /obj/item/organ/eyes/night_vision/zombie
//	eyes.Insert(owner.current)
	//succ_look()
	//H.equipOutfit(/datum/outfit/job/roguetown/succubus)
	H.set_patron(/datum/patron/inhumen/baotha)

	return TRUE
// for enchanted, when i make them
/datum/antagonist/succubus/infil/equip_lord()
	REMOVE_TRAIT(owner.current, TRAIT_BEAUTIFUL, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_EMPATH, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_BHBROTHEL, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_DEATHBYSNUSNU, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_SUCCUBUS, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_DEATHBYSNUSNU, "[type]")
	REMOVE_TRAIT(owner.current, TRAIT_DECEIVING_MEEKNESS, "[type]")
//	ADD_TRAIT(owner.current, TRAIT_ZOMBIE_IMMUNE, "[type]")
	owner.current.change_stat("strength", -2)
	owner.current.change_stat("constitution", -2)
	owner.current.change_stat("endurance", -2)
	owner.current.change_stat("perception", -2)
	owner.current.change_stat("speed", -2)
	owner.current.change_stat("fortune", 2)
	return ..()

/datum/antagonist/succubus/proc/equip_spawn()
	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Succubi"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	owner.current.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
	owner.current.ambushable = FALSE

//leaving this here until i get around to adding gear
//mob/living/carbon/human/proc/spawn_pick_class()
//	var/list/classoptions = list(
//		/datum/subclass/hunter,
//		/datum/subclass/miner,
//		/datum/subclass/healer,
//		/datum/subclass/woodcutter,
//		/datum/subclass/blacksmith,
//		/datum/subclass/vampirerogue,
//		/datum/subclass/vampiremagos)
//	var/list/visoptions = list()
//
//	for(var/datum/subclass/A in SSrole_class_handler.sorted_class_categories[CTAG_ALLCLASS])
//		if(A.type in classoptions)
//			classoptions += A.name
//			classoptions -= A.type

//	for(var/T in 1 to 5) // leave as length(classoptions) for testing if you want all classes to show up.
//		if(length(classoptions))
	//		visoptions += pick_n_take(classoptions)

//	var/selected = input(src, "Which class was I?", "VAMPIRE SPAWN") as anything in visoptions

//	for(var/datum/subclass/A in SSrole_class_handler.sorted_class_categories[CTAG_ALLCLASS])
	//	if(A.name == selected)
	//		if(!A.outfit)
	//			to_chat(src, span_clown("Failed to equip chosen class, choose a new one."))
	//			log_message("ERROR: Unable to pick [A.name] as a subclass for [src].", LOG_GAME)
	//			spawn_pick_class()
	//			return

	//		if(equipOutfit(A.outfit))
	//			return
/datum/advclass/succubusworker
	name = "Loveworker"
	tutorial = "Regardless of when you joined, you've worked for this brothel for many..many years, pleasing all who come in, feeding on them, and, of course, sharing them. Long ago, the cave collapsed, trapping you, and your 'sisters'..inside. However, by some stroke of luck, the cave's entrance has opened slightly, allowing you to finally visit the outside! Perhaps you may entice the many types of meals outside, into the Brothel, granting food for your sisters, and pleasure to the outside."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/succubus/basic
	category_tags = list(CTAG_SUCCUBUS)
	cmode_music = 'sound/music/combat_baotha.ogg'


/datum/outfit/job/roguetown/succubus/basic/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, "[type]")
	H.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.change_stat("strength", -3)
	H.change_stat("constitution", -2)
	H.change_stat("endurance", -2)
	H.change_stat("perception", -2)
	H.change_stat("speed", 1)
	H.change_stat("fortune", 2)

//	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	belt = /obj/item/storage/belt/rogue/leather/cloth
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
//	head  = /obj/item/clothing/head/roguetown/vampire
//	beltl = /obj/item/key/vampire
//	cloak = /obj/item/clothing/cloak/cape/puritan
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backl = /obj/item/storage/backpack/rogue/satchel
//	H.ambushable = FALSE

/datum/advclass/succubusmaster
	name = "Brothel Master"
	tutorial = "The last master of the Blackheart Brothel starved to death when the cave collapsed, and in her dying words, they gave it to you. It's your responsibility to  carry their legacy, now, as well as making sure those who wander in pay their due...Whether it be feeding you and your 'sisters', or cold, hard, mammon."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/succubus/master
	category_tags = list(CTAG_SUCCUBUS)
	maximum_possible_slots = 1
	cmode_music = 'sound/music/combat_baotha.ogg'



/datum/outfit/job/roguetown/succubus/master/pre_equip(mob/living/carbon/human/H)
	..()
//	ADD_TRAIT(h.mind.current, TRAIT_DODGEEXPERT, "[type]")
	H.adjust_skillrank(/datum/skill/magic/blood, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
//	H.AddSpell(new /obj/effect/proc_holder/spell/invoked/succcharm)
	H.change_stat("strength", -1)
	H.change_stat("constitution", -2)
	H.change_stat("endurance", -2)
	H.change_stat("perception", -2)
	H.change_stat("speed", 1)
	H.change_stat("fortune", 2)
//	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	belt =  /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins
	armor = /obj/item/clothing/suit/roguetown/armor/armordress
//	head  = /obj/item/clothing/head/roguetown/vampire
//	beltl = /obj/item/key/vampire
//	cloak = /obj/item/clothing/cloak/cape/puritan
	shoes =  /obj/item/clothing/shoes/roguetown/simpleshoes
	backl =  /obj/item/storage/backpack/rogue/satchel
//	H.ambushable = FALSE

/datum/advclass/succubusguard
	name = "Brothel Guard"
	tutorial = "Either a retired veteran, or a simply failing to get a job elsewhere, you've found your place here. The hiring requirements were strange-- Strictly Baothans. So was the odd ritual, you had to do, before they accepted you. You're the little muscle this place has, protection for your new-found 'family', that you've been stuck with, ever since the place collapsed, though you may be sometimes be ordered to handle 'encouraging' customers to pay, willingly or not. Death is bad for business, and corpses can't produce essence, so it's in your interest to make sure that whoever you beat down at least, remains alive, before your sisters have had their fill."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/succubus/guard
	category_tags = list(CTAG_SUCCUBUS)
	maximum_possible_slots = 4
	cmode_music = 'sound/music/combat_baotha.ogg'




/datum/outfit/job/roguetown/succubus/guard/pre_equip(mob/living/carbon/human/H)
	..()
//	ADD_TRAIT(h.mind.current, TRAIT_DODGEEXPERT, "[type]")
	H.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.change_stat("strength", -1)
	H.change_stat("constitution", -1)
	H.change_stat("endurance", -1)
	H.change_stat("perception", -3)
	H.change_stat("speed", -1)
	H.change_stat("fortune", 2)

	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	head  = /obj/item/clothing/head/roguetown/paddedcap
//	beltl = /obj/item/key/vampire
//	cloak = /obj/item/clothing/cloak/cape/puritan
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backl = /obj/item/storage/backpack/rogue/satchel
//	H.ambushable = FALSE

/datum/advclass/succubusmaid
	name = "Brothel Maid"
	tutorial = "You used to clean messes made by customers, and, sometimes, you would clean the customers themselves. However, when the cave collapsed, the only thing you could clean was the dirt off the ground...Luckily, the cave has opened, once more, and perhaps you can return to your former glory as a maid.."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/succubus/maid
	category_tags = list(CTAG_SUCCUBUS)
	cmode_music = 'sound/music/combat_baotha.ogg'


/datum/outfit/job/roguetown/succubus/maid/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, "[type]")
	H.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
//	H.mindadjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
//	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.change_stat("strength", -3)
	H.change_stat("constitution", -2)
	H.change_stat("endurance", -2)
	H.change_stat("perception", -2)
	H.change_stat("speed", 1)
	H.change_stat("fortune", 2)

//	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	belt = /obj/item/storage/belt/rogue/leather/cloth
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
//	head  = /obj/item/clothing/head/roguetown/vampire
	beltl = /obj/item/natural/cloth
//	cloak = /obj/item/clothing/cloak/cape/puritan
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backl = /obj/item/storage/backpack/rogue/satchel
//	H.ambushable = FALSE

////////Outfits////////
// not done yet!

/datum/antagonist/succubus/on_removal()
	if(!silent && owner.current)
		to_chat(owner.current,span_danger("I am no longer a [job_rank]!"))
	owner.special_role = null
	owner.current.possible_rmb_intents = initial(owner.current.possible_rmb_intents)
//	if(!isnull(batform))
	//	owner.current.RemoveSpell(batform)
	//	QDEL_NULL(batform)
	return ..()

datum/antagonist/succubus/proc/add_objective(datum/objective/O)
	var/datum/objective/V = new O
	objectives += V

datum/antagonist/succubus/proc/remove_objective(datum/objective/O)
	objectives -= O

datum/antagonist/succubus/proc/forge_succubus_objectives()
	//var/list/primary = pick(list("1", "2"))
	//var/list/secondary = pick(list("1", "2", "3"))

	return

/datum/antagonist/succubus/greet()
	to_chat(owner.current, span_userdanger(message))
	owner.announce_objectives()
	..()

//datum/antagonist/succubus/infil/greet()

	//to_chat(owner.current, span_userdanger("I am a beautiful creature, that's managed to slip in, by luck. I still maintain the connection to the ones in the mountain, and I must find a way to permit them to join us, without letting the horrid Tennite heretics harm them. More importamntly, I must find fresh essence to sate my hunger!"))
	//owner.announce_objectives()
//	..()


/datum/antagonist/succubus/proc/finalize_succubus()
	owner.current.forceMove(pick(GLOB.succubus_starts))
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)


/datum/antagonist/succubus/infil/finalize_succubus()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)

/datum/antagonist/succubus/proc/succ_look()
	var/mob/living/carbon/human/V = owner.current
//	cache_skin = V.skin_tone
	var/obj/item/organ/eyes/eyes = V.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		cache_eyes = V.dna?.species.organs[ORGAN_SLOT_EYES]
		cache_eye_color = eyes.eye_color
		eyes.Remove(V)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(V)
	set_eye_color(V, cache_eye_color, cache_eye_color)
	eyes.update_accessory_colors()
	V.update_body()
	V.update_hair()
	V.update_body_parts(redraw = TRUE)
	V.faction = list("succubus")
	// Cycles through disguises to properly get eye color and other factions set.

//datum/antagonist/succubus/on_life(mob/user)

/datum/antagonist/succubus/proc/handle_vitae(change, tribute)
//	mypool.update_pool(change) // Spawn and Vlord now share a blood pool.
///	if(tribute)
//		mypool.update_pool(tribute)
	owner.current.heal_overall_damage(passiveregen, passiveregen)
//	owner.current.adjustToxLoss(-bloodroll * 10) // Purges toxins.
	owner.current.adjustOxyLoss(-passiveregen)
	owner.current.heal_wounds(passiveregen*2)
//	owner.current.blood_volume += passive_rege
	vitae += change
	if (vitae > vmax)
		vitae = vmax
	if(vitae <= 20)
		if(!starved)
			to_chat(owner, span_userdanger("I'm starving..I need essence..."))
			starved = TRUE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, -8)
	else
		if(starved)
			starved = FALSE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 8)
//	vitae = mypool.current

/datum/antagonist/succubuslesser/proc/handle_vitae(change, tribute)
//	mypool.update_pool(change) // Spawn and Vlord now share a blood pool.
///	if(tribute)
//		mypool.update_pool(tribute)
	vitae += change
	if (vitae > vmax)
		vitae = vmax
	if(vitae <= 20)
		if(!starved)
			to_chat(owner, span_userdanger("I'm starving..I need essence..."))
			starved = TRUE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, -10)
	else
		if(starved)
			starved = FALSE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 10)
//	vitae = mypool.current



/datum/antagonist/succubus/on_life(mob/user)
	if(!user)
		return
	var/mob/living/carbon/human/H = user
	if(H.stat == DEAD)
		return
	if(H.advsetup)
		return

	if(vitae > 0) //vitae gradually drains, whether you like it or not
		handle_vitae(-1)



/datum/antagonist/succubus/proc/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.succubus_starts))




// eventually.
//datum/antagonist/enchanted
//	name = "Vampire Spawn"
//	antag_hud_name = "Vspawn"
//	confess_lines = list(
//		"THE CRIMSON CALLS!",
//		"MY MASTER COMMANDS",
//		"THE SUN IS ENEMY!",
//	)
//

// NEW VERBS
//mob/living/carbon/human/proc/demand_heart()
//	set name = "Demand Heart"
//	set category = "SUCCUBUS"
//	var/datum/game_mode/chaosmode/C = SSticker.mode
//	for(var/mob/living/carbon/human/H in oview(1))
//		if(SSticker.rulermob == H)
//			H.receive_heartdemand(src)

///mob/living/carbon/human/proc/receive_heartdemand(mob/living/carbon/human/lord)
//	if(stat)
//		return
//	switch(alert("Submit to [lord.name]'s beauty?",,"Yes","No"))
	//	if("Yes")
//
	//	if("No")
	//		lord << span_boldnotice("They refuse!")
//			src << span_boldnotice("I refuse!")

/mob/living/carbon/human/proc/succubus_telepathy()
	set name = "Telepathy"
	set category = "SUCCUBUS"
//	if(!is_not_staked(usr))
//		return
//	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/msg = input("Send a message.", "Command") as text|null
	if(!msg)
		return
	log_game("[key_name(src)] used succubus telepathy to say \"[msg]\"")
	for(var/datum/mind/V in SSmapping.retainer.succubi)
		to_chat(V, span_boldnotice("[src.real_name] speaks: \"[msg]\""))

//mob/living/carbon/human/proc/punish_spawn()
//	set name = "Punish Servant"
//	set category = "SUCCUBUS"
//	if(!is_not_staked(usr))
//		return
//	var/datum/game_mode/chaosmode/C = SSticker.mode
//	var/list/possible = list()
///	for(var/datum/mind/D in C.enchanted)
//		possible[D.current.real_name] = D.current
//	var/name_choice = input(src, "Who to punish?", "PUNISHMENT") as null|anything in possible
//	if(!name_choice)
//		return
//	var/mob/living/carbon/human/choice = possible[name_choice]
///	if(!choice || QDELETED(choice))
//		return
//	var/punishmentlevels = list("Pause", "Pain", "DESTROY")
//	var/punishment = input(src, "Severity?", "PUNISHMENT") as null|anything in punishmentlevels
//	if(!punishment)
//		return
//	switch(punishment)
//		if("Pain")
//			to_chat(choice, span_boldnotice("You are wracked with pain as your master punishes you!"))
//			choice.apply_damage(30, BRUTE)
//			choice.emote_scream()
	//		playsound(choice, 'sound/misc/obey.ogg', 100, FALSE, pressure_affected = FALSE)
//		if("Pause")
//			to_chat(choice, span_boldnotice("Your body is frozen in place as your master punishes you!"))
//			choice.Paralyze(300)
//			choice.emote_scream()
	//		playsound(choice, 'sound/misc/obey.ogg', 100, FALSE, pressure_affected = FALSE)
	//	if("DESTROY")
	//		to_chat(choice, span_boldnotice("You feel only darkness. Your master no longer has use of you."))
//			spawn(10 SECONDS)
//	//			choice.emote_scream()
//	visible_message(span_danger("[src] reaches out, gripping [choice]'s soul, inflicting punishment!"))




/datum/antagonist/succubus/roundend_report()
	if(owner?.current)
		var/the_name = owner.name
		if(ishuman(owner.current))
			var/mob/living/carbon/human/H = owner.current
			the_name = H.real_name
		if(!totalessence)
			to_chat(world, "[the_name] was a succubus.")
		else
			to_chat(world, "[the_name] was a succubus. They stole [totalessence] essence from the people of Scarlet Reach, and had [totalensnared] hearts in their grasp!")
	return

	var/traitorwin = TRUE

	var/count = 0
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(!objective.check_completion())
				traitorwin = FALSE
			count += objective.triumph_count

	if(!count)
		count = 1

	if(traitorwin)
		owner.adjust_triumphs(count)
		to_chat(owner.current, span_greentext("I've survived..BAOTHA IS PROUD!"))
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(owner.current, span_redtext("I've failed to sate baotha's will...."))
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

// NEW OBJECTS/STRUCTURES

/obj/effect/landmark/start/succubus
	name = "Succubus"
	icon_state = "arrow"
	delete_after_roundstart = FALSE
	jobspawn_override = list(/datum/job/roguetown/succubus)


/obj/effect/landmark/start/succubus/Initialize()
	. = ..()
	GLOB.succubus_starts += loc


/obj/effect/proc_holder/spell/targeted/succ_rejuv
	name = "Rejuvenate"
	desc = "Regenerates my targeted limb and Replenishes half my stamina. Recharges every 30 seconds. I must stand still."
	overlay_state = "doc"
	action_icon = 'icons/mob/actions/roguespells.dmi'
	releasedrain = 0
	chargedrain = 0
	chargetime = 0
	range = -1
	warnie = "sydwarning"
	movement_interrupt = TRUE
	chargedloop = null
//	invocation_type = "whisper"
	associated_skill = /datum/skill/magic/blood
	antimagic_allowed = FALSE
//	charge_max = 1 MINUTES
	cooldown_min = 30 SECONDS
	include_user = TRUE
	max_targets = 1
	vitaedrain = 100

/obj/effect/proc_holder/spell/targeted/succ_rejuv/cast(list/targets, mob/user = usr)
	if(user && iscarbon(user))
		var/mob/living/carbon/succ = user
		var/datum/antagonist/succubus/VD = user.mind.has_antag_datum(/datum/antagonist/succubus)
		var/bloodskill = succ.get_skill_level(/datum/skill/magic/blood)
		if ((VD.vitae - 150) < 0)
			to_chat(succ, span_redtext("I'm too hungry to recover..."))
			return
	//	var/bloodskill = succ.mind.get_skill_level(/datum/skill/magic/blood)
		VD.handle_vitae(-150)
		// How much the vampire will heal by.
		var/bloodroll = (roll("[bloodskill]d8") + (succ.STACON * 1.5)) * 2
		succ.heal_overall_damage(bloodroll, bloodroll)
		succ.adjustToxLoss(-bloodroll * 10) // Purges toxins.
		succ.adjustOxyLoss(-bloodroll)
		succ.heal_wounds(bloodroll * 30)
		succ.blood_volume += BLOOD_VOLUME_SURVIVE
		succ.update_damage_overlays()
		to_chat(succ, span_greentext("! REJUVENATE AMT: [bloodroll] !"))
		succ.visible_message(span_danger("[succ] glows in a dim, purple aura as their wounds close!"))
		succ.playsound_local(get_turf(succ), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)


/obj/effect/proc_holder/spell/invoked/succcharm
	name = "Enchant"
	desc = "Take over the wits of a victim, forcing them to come to you if you have enough exposed."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 3
	recharge_time = 15 SECONDS
	range = 7
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	gesture_required = TRUE
	associated_skill = /datum/skill/magic/blood
	antimagic_allowed = FALSE
//	glow_color = GLOW_COLOR_ICE
//	glow_intensity = GLOW_INTENSITY_LOW DM (DM code was drunk and kept calling this defined thing a "variable". Yup, DM at it's finest!
	vitaedrain = 150
	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/succcharm/cast(list/targets, mob/living/user)
//	var/userpron
//	var/targetpron
	var/bloodskill = user.get_skill_level(/datum/skill/magic/blood)
	var/bloodroll = roll("[bloodskill]d8")
	var/datum/antagonist/succubus/VD = user.mind.has_antag_datum(/datum/antagonist/succubus)
	if(isliving(targets[1]))
		var/mob/living/carbon/human/target = targets[1]
		var/willpower = round(target.STAINT / 4)
		var/willroll = roll("[willpower]d12")
		if(target.cmode)
			willroll += 5
		var/found_psycross = FALSE
		var/psycross_type = "none"
		for(var/obj/item/clothing/neck/roguetown/psicross/silver/I in target.contents) //Subpath fix.
			found_psycross = TRUE
			if(psycross_type=="none")
				psycross_type = "PSYDON"
			break
		for(var/obj/item/clothing/neck/roguetown/psicross/astrata/I in target.contents) //Subpath fix.
			found_psycross = TRUE
			if(psycross_type=="none")
				psycross_type = "ASTRATA"
			break
		for(var/obj/item/clothing/neck/roguetown/psicross/eora/I in target.contents) //Subpath fix.
			found_psycross = TRUE
			if(psycross_type=="none")
				psycross_type = "EORA"
			break
		if(HAS_TRAIT(target, TRAIT_SUCCUBUS) || HAS_TRAIT(target, TRAIT_LESSERSUCCUBUS) || HAS_TRAIT(target, TRAIT_IMMUNECHARM))
			to_chat(user, span_love("[target]'s heart is too strong, I can't grasp it.."))  //no succubus on succubus violence
			return
		//if(target.mind.has_antag_datum(/datum/antagonist/vampirelord/) && target.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser) && target.mind.has_antag_datum(/datum/antagonist/zombie)) // you're dead, you don't care about sex
		//	return
	///	switch(user.pronouns)
		//	if(SHE_HER)
		//		userpron = "her"
		//	if(HE_HIM)
		//		userpron = "him"
		//	else
		//		userpron = "them"
	//	switch(target.pronouns)
		//	if(SHE_HER)
		//		targetpron = "her"
		//	if(HE_HIM)
		//		targetpron = "his"
		//	else
			//	targetpron = "their"
		if(bloodroll >= willroll)
			if(found_psycross == TRUE && VD.ignore_psycross == FALSE)
				switch(psycross_type)
					if("PSYDON")
						to_chat(target, "<font color='white'>The silver psycross shines, allowing me to ENDURE the love-beast's degenerate song!</font>")
						to_chat(user, span_userdanger("[target] has the amulet of the Dead God! It causes me to fail to ensnare their mind!"))
					if("EORA")
						to_chat(target, "<font color='white'>The eoran psycross shines, recovering my wits from the love-beast's carnal melody!</font>")
						to_chat(user, span_userdanger("[target] has the amulet of the Horrid Lover! It causes me to fail to ensnare their mind!"))
					if("ASTRATA")
						to_chat(target, "<font color='white'>The astratan psycross shines, guiding my heart out of the clutches of the love-beast!</font>")
						to_chat(user, span_userdanger("[target] has the amulet of the Hateful Sun! It causes me to fail to ensnare their mind!"))
			else
				target.sexcon.adjust_arousal(15)

				 //apply debuff
				if (is_human_part_visible(user, HIDECROTCH|HIDEBOOB)) //pov: boob strats
					target.sexcon.adjust_arousal(30)
				switch(target.sexcon.arousal)
					if (0 to 15)
						target.visible_message(span_love("[target] blushes a little.."))
						to_chat(user, span_love("I can hear [target]'s heart sings a subtle song back to me..!"))
						to_chat(target, span_love("<span class='love_mid'>My loins ache a little..</span>"))
					if(16 to 30)
						target.visible_message(span_love("[target] blushes.."))
						to_chat(user, span_love("I can hear [target]'s sings a low song to me.."))
						to_chat(target, span_love("<span class='love_mid'>My loins ache..</span>"))
					if(31 to 45)
						target.visible_message(span_love("[target] shifts uncomfortably in [target.p_their()] clothing..."))
						to_chat(user, span_love("I[target]'s heart is singing quietly, but longingly.."))
						to_chat(target, span_love("<span class='love_high'>Has my clothing always been so warm..?</span>"))
					if(46 to 60)
						target.visible_message(span_love("[target] tugs at [target.p_their()] clothing..."))
						to_chat(user, span_love("[target]'s heart is singing longingly..A bit more.."))
						to_chat(target, span_love("<span class='love_high'>Has my clothing always been so hot?</span>"))
					if(61 to 79)
						target.visible_message(span_love("[target]'s legs grow shaky.."))
						to_chat(user, span_love("[target]'s heart is singing desperately to me! Almost under my grasp!"))
						to_chat(target, span_love("<span class='love_extreme'>I can't take much more..A beautiful song is echoing in my ears..</span>"))

				if (target.sexcon.arousal >= 80)
					target.apply_status_effect(/datum/status_effect/debuff/succucharm)
					target.sexcon.arousal = 80
					to_chat(user, span_love("<span class='love_extreme'>I can hear [target]'s heart pounding, [target.p_their()]'s heart aches for me!</span>"))
					to_chat(target, span_love("<span class='love_extreme'>[user] sings the most beautiful song...It calls to me.... I need [user.p_them()]...I need [user.p_them()]] now...</span>"))
					target.visible_message(span_danger("[user] beckons to  [target], [user.p_their()] eyes beginning to glow a dim pink, as [target] begins to walk toward [user.p_them()] with outstretched arms, [target.p_their()] gaze overwhelmed with lust...."))
					target.enchanted_walk(user) //GOD DAMN DM CODE- (I had to make a whole "walk toward me" function just to make this work because 'walk_to' won't work



/mob/living/carbon/human/proc/enchanted_walk(target)
	Stun(300)
//	apply_status_effect(/datum/status_effect/debuff/succucharm,300)
	drop_all_held_items()
	walk_to(src,get_turf(target),0,8)