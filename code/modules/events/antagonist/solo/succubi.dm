/datum/round_event_control/antagonist/solo/succubus_infil
	name = "Ingrained Succubi"
	tags = list(
		TAG_HAUNTED,
		TAG_VILLIAN,
	)
	roundstart = TRUE
	antag_flag = ROLE_SUCCUBUS
	shared_occurence_type = SHARED_MINOR_THREAT
	denominator = 1

	base_antags = 1
	maximum_antags = 8

	earliest_start = 0 SECONDS

	weight = 20 //succubi for everyone
	max_occurrences = 1

	typepath = /datum/round_event/antagonist/solo/succubus_infil

	var/locked_roles = list(
		"Grand Duke",
		"Grand Duchess",
		"Knight Captain",
		"Consort",
		"Dungeoneer",
		"Sergeant",
		"Men-at-Arms",
		"Woman-at-Arms",
		"Marshal",
		"Merchant",
		"Priest",
		"Priestess",
		"Acolyte",
		"Martyr",
		"Templar",
		"Councillor",
		"Bandit",
		"Prince",
		"Princess",
		"Hand",
		"Steward",
		"Clerk",
		"Magos Thrall",
		"Jester",
		"Servant",
		"Seneschal",
		"Court Physician",
		"Town Elder",
		"Captain",
		"Loudmouth",
		"Knight",
		"Dame",
		"Court Magician",
		"Inquisitor",
		"Orthodoxist",
		"Absolver",
		"Warden",
		"Squire",
		"Veteran",
		"Apothecary",
		"Succubus"
	)
	restricted_roles = list( //oh uh, someone made the M I N O R mistake of voting Baotha or Zizo, and now our duke is a sex-hungry beast
		"Knight Captain",
		"Dungeoneer",
		"Sergeant",
		"Men-at-Arms",
		"Woman-at-Arms",
		"Marshal",
		"Priest",
		"Priestess",
		"Acolyte",
		"Martyr",
		"Templar",
		"Bandit",
		"Court Physician",
		"Town Elder",
		"Captain",
		"Court Magician",
		"Inquisitor",
		"Orthodoxist",
		"Absolver",
		"Veteran",,
		"Succubus"
	)
//	allowed_storytellers = list(/datum/storyteller/astrata, /datum/storyteller/noc,/datum/storyteller/ravox, /datum/storyteller/necra, /datum/storyteller/xylix, /datum/storyteller/pestra, /datum/storyteller/abyssor, /datum/storyteller/dendor, /datum/storyteller/malum, /datum/storyteller/psydon, /datum/storyteller/eora, /datum/storyteller/matthios, /datum/storyteller/graggar)



/datum/round_event/antagonist/solo/succubus_infil
	var/list/other_cands
	var/locked_roles = list(
		"Grand Duke",
		"Grand Duchess",
		"Knight Captain",
		"Consort",
		"Dungeoneer",
		"Sergeant",
		"Men-at-Arms",
		"Woman-at-Arms",
		"Marshal",
		"Merchant",
		"Priest",
		"Priestess",
		"Acolyte",
		"Martyr",
		"Templar",
		"Councillor",
		"Bandit",
		"Prince",
		"Princess",
		"Hand",
		"Steward",
		"Clerk",
		"Magos Thrall",
		"Jester",
		"Servant",
		"Seneschal",
		"Court Physician",
		"Town Elder",
		"Captain",
		"Loudmouth",
		"Knight",
		"Dame",
		"Court Magician",
		"Inquisitor",
		"Orthodoxist",
		"Absolver",
		"Warden",
		"Squire",
		"Veteran",
		"Apothecary",
		"Succubus"
	)

//datum/round_event/antagonist/solo/succubus_infil/setup()
//	var/datum/round_event_control/antagonist/solo/cast_control = /datum/round_event_control/antagonist/solo/succubus_infil
//	antag_count = cast_control.get_antag_amount()
//	message_admins("STORYTELLER:[cast_control.name] spawning [antag_count].")
//	antag_flag = cast_control.antag_flag
//	antag_datum = cast_control.antag_datum
//	restricted_roles = cast_control.restricted_roles
//	prompted_picking = cast_control.prompted_picking
//	var/list/possible_candidates = cast_control.get_candidates()
//	var/list/candidates = list()
//	if(cast_control == SSgamemode.current_roundstart_event && length(SSgamemode.roundstart_antag_minds))
//		log_storyteller("Running roundstart antagonist assignment, event: [src], roundstart_antag_minds: [english_list(SSgamemode.roundstart_antag_minds)]")
//		for(var/datum/mind/antag_mind in SSgamemode.roundstart_antag_minds)
//			if(!antag_mind.current)
//				log_storyteller("Roundstart antagonist setup error: antag_mind([antag_mind]) in roundstart_antag_minds without a set mob")
//				continue
//			candidates += antag_mind.current
//			SSgamemode.roundstart_antag_minds -= antag_mind
//			log_storyteller("Roundstart antag_mind, [antag_mind]")
//
	//guh
//	var/list/cliented_list = list()
//	for(var/mob/living/mob as anything in possible_candidates)
//		cliented_list += mob.client

//	while(length(possible_candidates) && length(candidates) < antag_count) //both of these pick_n_take from weighted_candidates so this should be fine
//		var/mob/picked_ckey = pick_n_take(possible_candidates)
//		var/client/picked_client = picked_ckey.client
//		if(QDELETED(picked_client))
//			continue
//		var/mob/picked_mob = picked_client.mob
	//	picked_mob?.mind?.picking = TRUE
//		log_storyteller("Picked antag event mob: [picked_mob], special role: [picked_mob.mind?.special_role ? picked_mob.mind.special_role : "none"]")
	//	candidates |= picked_mob

/////	var/list/picked_mobs = list()
///	for(var/i in 1 to antag_count)
///		if(!length(candidates))
///	//		message_admins("A roleset event got fewer antags then its antag_count and may not function correctly.")
	//		break
////
	//	var/mob/candidate = pick_n_take(candidates)
	//	log_storyteller("Antag event spawned mob: [candidate], special role: [candidate.mind?.special_role ? candidate.mind.special_role : "none"]")

	//	if(!candidate.mind)
	//		candidate.mind = new /datum/mind(candidate.key)
//
	//	setup_minds += candidate.mind
	//	candidate.mind.special_role = antag_flag
	//	candidate.mind.restricted_roles = restricted_roles
	//	picked_mobs += WEAKREF(candidate.client)

//	setup = TRUE
//	if(LAZYLEN(extra_spawned_events))
//		var/event_type = pickweight(extra_spawned_events)
//		if(!event_type)
	//		return
//		var/datum/round_event_control/triggered_event = locate(event_type) in SSgamemode.control
//		//wait a second to avoid any potential omnitraitor bs
//		addtimer(CALLBACK(triggered_event, TYPE_PROC_REF(/datum/round_event_control, runEvent), FALSE), 1 SECONDS)

//datum/round_event_control/antagonist/solo/succubus_infil/get_candidates()
//	var/list/candidates
//	var/baotha_curse = FALSE
//	var/round_started = SSticker.HasRoundStarted()
//	var/new_players_arg = round_started ? FALSE : TRUE
//	var/living_players_arg = round_started ? TRUE : FALSE
//	var/midround_antag_pref_arg = round_started ? FALSE : TRUE
//	if 	(SSgamemode.current_storyteller == /datum/storyteller/baotha)
//		baotha_curse = TRUE
//	if 	(SSgamemode.current_storyteller == /datum/storyteller/zizo)
//		baotha_curse = TRUE
//	if (baotha_curse)
//		candidates = SSgamemode.get_candidates(antag_flag, antag_flag, FALSE, new_players_arg, living_players_arg, midround_antag_pref = midround_antag_pref_arg, \
													restricted_roles = curse_restricted_roles, required_roles = exclusive_roles)
//	else
//		candidates = SSgamemode.get_candidates(antag_flag, antag_flag, FALSE, new_players_arg, living_players_arg, midround_antag_pref = midround_antag_pref_arg, \
													restricted_roles = restricted_roles, required_roles = exclusive_roles)
///	candidates = trim_candidates(candidates)
//	return candidates



/datum/round_event/antagonist/solo/succubus_infil/start()

	for(var/datum/mind/antag_mind as anything in setup_minds)
		antag_mind.add_antag_datum(/datum/antagonist/succubus/infil)

/datum/round_event/antagonist/solo/succubus_infil/setup()
	var/baotha_curse = FALSE
	var/datum/round_event_control/antagonist/solo/cast_control = control
	antag_count = cast_control.get_antag_amount()
	message_admins("STORYTELLER:[cast_control.name] spawning [antag_count].")
	antag_flag = cast_control.antag_flag
	antag_datum = cast_control.antag_datum
	restricted_roles = cast_control.restricted_roles
	prompted_picking = cast_control.prompted_picking
	var/list/possible_candidates = cast_control.get_candidates()
	var/list/candidates = list()
	if(cast_control == SSgamemode.current_roundstart_event && length(SSgamemode.roundstart_antag_minds))
		if 	(SSgamemode.current_storyteller == /datum/storyteller/baotha || SSgamemode.current_storyteller == /datum/storyteller/zizo)
			baotha_curse = TRUE

		log_storyteller("Running roundstart antagonist assignment, event: [src], roundstart_antag_minds: [english_list(SSgamemode.roundstart_antag_minds)]")
		for(var/datum/mind/antag_mind in SSgamemode.roundstart_antag_minds)
			if(!antag_mind.current)
				log_storyteller("Roundstart antagonist setup error: antag_mind([antag_mind]) in roundstart_antag_minds without a set mob")
				continue
			if (baotha_curse || !(antag_mind.assigned_role in locked_roles))
				candidates += antag_mind.current
			else
				log_storyteller("Roundstart antag_mind, [antag_mind] was denied (Storyteller not Baotha/Zizo, or somehow got in candidates despite being truly restricted)")
			SSgamemode.roundstart_antag_minds -= antag_mind
			log_storyteller("Roundstart antag_mind, [antag_mind]")

	//guh
	var/list/cliented_list = list()
	for(var/mob/living/mob as anything in possible_candidates)
		cliented_list += mob.client

	while(length(possible_candidates) && length(candidates) < antag_count) //both of these pick_n_take from weighted_candidates so this should be fine
		var/mob/picked_ckey = pick_n_take(possible_candidates)
		var/client/picked_client = picked_ckey.client
		if(QDELETED(picked_client))
			continue
		var/mob/picked_mob = picked_client.mob
		picked_mob?.mind?.picking = TRUE
		log_storyteller("Picked antag event mob: [picked_mob], special role: [picked_mob.mind?.special_role ? picked_mob.mind.special_role : "none"]")
		candidates |= picked_mob

	var/list/picked_mobs = list()
	for(var/i in 1 to antag_count)
		if(!length(candidates))
			message_admins("A roleset event got fewer antags then its antag_count and may not function correctly.")
			break

		var/mob/candidate = pick_n_take(candidates)
		log_storyteller("Antag event spawned mob: [candidate], special role: [candidate.mind?.special_role ? candidate.mind.special_role : "none"]")

		if(!candidate.mind)
			candidate.mind = new /datum/mind(candidate.key)

		setup_minds += candidate.mind
		candidate.mind.special_role = antag_flag
		candidate.mind.restricted_roles = restricted_roles
		picked_mobs += WEAKREF(candidate.client)

	setup = TRUE
	if(LAZYLEN(extra_spawned_events))
		var/event_type = pickweight(extra_spawned_events)
		if(!event_type)
			return
		var/datum/round_event_control/triggered_event = locate(event_type) in SSgamemode.control
		//wait a second to avoid any potential omnitraitor bs
		addtimer(CALLBACK(triggered_event, TYPE_PROC_REF(/datum/round_event_control, runEvent), FALSE), 1 SECONDS)