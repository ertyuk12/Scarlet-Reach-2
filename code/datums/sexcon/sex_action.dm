/datum/sex_action
	abstract_type = /datum/sex_action
	var/name = "Zodomize"
	/// Time to do the act, modified by up to 2.5x speed by the speed toggle
	var/do_time = 3.3 SECONDS
	/// Whether the act is continous and will be done on repeat
	var/continous = TRUE
	/// Stamina cost per action, modified by up to 2.5x cost by the force toggle
	var/stamina_cost = 0.5
	/// Whether the action requires both participants to be on the same tile
	var/check_same_tile = TRUE
	/// Whether the same tile check can be bypassed by an aggro grab on the person
	var/aggro_grab_instead_same_tile = TRUE
	/// Whether the action is forbidden from being done while incapacitated (stun, handcuffed)
	var/check_incapacitated = TRUE
	/// Whether the action requires an aggressive grab on the victim
	var/require_grab = FALSE
	/// If a grab is required, this is the required state of it
	var/required_grab_state = GRAB_AGGRESSIVE
	//can this feed succubi?
	var/feed_type = null
	//will this make someone want to dick succubi down?
	var/charm_type = null

/datum/sex_action/proc/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return TRUE

/datum/sex_action/proc/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return

/datum/sex_action/proc/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return

/datum/sex_action/proc/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return

/datum/sex_action/proc/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return FALSE

/datum/sex_action/proc/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return TRUE


/datum/sex_action/proc/is_succubus(mob/living/carbon/human/who)//I am NOT checking each person individually for each succubus trait
	if(HAS_TRAIT(who, TRAIT_SUCCUBUS) || HAS_TRAIT(who, TRAIT_LESSERSUCCUBUS))
		log_game("[who] is a succubus!")
		return TRUE
	else
		log_game("[who] isn't a succubus!")
		return FALSE


//  this code will remain here in case someone wants to fix it, for now i'm using the almost 1:1 ratwood code copy (see bottom)
/datum/sex_action/proc/try_succubus_drain_beta(var/mob/living/carbon/human/us, var/mob/living/carbon/human/them, var/feedtype)
//	var/datum/sex_action/action = SEX_ACTION(current_action)
	var/mob/living/carbon/human/drainer
	var/mob/living/carbon/human/drained
	log_game("type: [feedtype]")
	if (!us)
		log_game("no drain user!")
		return
	if (!them)
		log_game("no drain target!")
		return
//	var/truedrain = FALSE
	var/amountstolen = 0
	if(is_succubus(us) && !is_succubus(them) && feedtype == ("BOTH" || "USER"))
		log_game("draining [them]")
		drainer = us
		drained = them
		//truedrain = TRUE
	if(is_succubus(them) && !is_succubus(us) && feedtype == ("BOTH" || "TARGET"))
		log_game("draining [us]")
		drainer = them
		drained = us
	if (drained && drainer)
		var/datum/antagonist/succubus/SD = drainer.mind.has_antag_datum(/datum/antagonist/succubus)
		var/datum/antagonist/succubuslesser/LSD = drainer.mind.has_antag_datum(/datum/antagonist/succubuslesser)
		if (!SD && !LSD)
			return
		to_chat(drainer, span_love("My victim surrenders [(drained.gender == FEMALE) ? "her" : "his"] essence to me..It feels good!"))
		if (SD)
			if (drained.STASTR > 5 ) // sorry bucko, you aren't becoming a omnipotent horny entity
				drained.change_stat("strength", -2)

			//	amountstolen += 1
				if (!SD.starved && drainer.STASTR < 15) //prevents exploiting by starving to gain extra stats. Also, kinda makes sense, it's hard to steal more strength when you lack your own!
					drainer.change_stat("strength", 1)
			else
				drained.apply_damage(6, TOX)

			if (drained.STACON > 5 )
				drained.change_stat("constitution", -2)
			//	amountstolen += 1
				if (!SD.starved && drainer.STACON < 15)
					drainer.change_stat("constitution", 1)
			else
				drained.apply_damage(6, TOX)

			if (drained.STAINT > 5 )
				drained.change_stat("intelligence", -2)
			//	amountstolen += 1
				if (!SD.starved && drainer.STAINT < 15)
					drainer.change_stat("intelligence", 1)
			else
				drained.apply_damage(6, TOX)
			if (drained.STAEND > 5)
				drained.change_stat("endurance", -2)
			//	amountstolen += 1
				if (!SD.starved && drainer.STAEND < 15)
					drainer.change_stat("endurance", 1)
			else
				drained.apply_damage(6, TOX)
			SD.handle_vitae(150) // enough for one heal
			amountstolen += 150

		else
			LSD.handle_vitae(100) //you pathetic LESSERS don't get that benefit
		if (!drained.has_status_effect(/datum/status_effect/debuff/succuhate) && !drained.has_status_effect(/datum/status_effect/buff/succulove))
			SD.handle_vitae(50)
			to_chat(drainer, span_love("Fresh essence! It tastes wonderful!"))
			SD.totalensnared += 1
			amountstolen += 50
		SD.totalessence += amountstolen
		to_chat(drained, span_love("That felt so good...I'll need more soon.."))
		drained.apply_status_effect(/datum/status_effect/buff/succulove)
		drained.sexcon.adjust_charge(300)
		drainer.sexcon.adjust_charge(300) // infinite cum for the cum god
		if (drained.has_status_effect(/datum/status_effect/debuff/succuhate))
			drained.remove_status_effect(/datum/status_effect/debuff/succuhate)
		if (drained.has_status_effect(/datum/status_effect/debuff/succucharm))
			drained.remove_status_effect(/datum/status_effect/debuff/succucharm)




/datum/sex_action/proc/try_succubus_charm(var/us, var/them, var/charmtype)
	var/mob/living/carbon/human/drainer
//	var/datum/sex_action/action = SEX_ACTION(current_action)
	var/mob/living/carbon/human/drained
	if (!us)
		return
	if (!them)
		return
	if (us == them)
		return
	if(is_succubus(us) && !is_succubus(them) && charmtype == ("BOTH" || "USER"))
		drainer = us
		drained = them
		//truedrain = TRUE
	if(is_succubus(them) && !is_succubus(us) && charmtype == ("BOTH" || "TARGET"))
		drainer = them
		drained = us
	if (drained && drainer && !drained.has_status_effect(/datum/status_effect/debuff/succuhate) && !drained.has_status_effect(/datum/status_effect/buff/succulove) && !drained.has_status_effect(/datum/status_effect/debuff/succucharm))
		to_chat(drainer, span_love("[drained.name] lusts for my body, now."))
		if (drained.patron.type == /datum/patron/divine/eora)
			to_chat(drained, span_love("I fight off the deep, carnal desires, clinging to the will of Eora!"))
		else if (drained.patron.type == /datum/patron/inhumen/baotha)
			to_chat(drained, span_love("That touch feels wonderful, they certainly must be touched by Baotha"))
		else
			to_chat(drained, span_love("[drainer.name] is so good..Simple teasing won't do...."))
			drained.apply_status_effect(/datum/status_effect/debuff/succucharm)
		drained.sexcon.adjust_charge(300)
		drainer.sexcon.adjust_charge(300) // refill those balls so you can fill my womb :3

//god damn i-

//so yeah, tried to get code above working but failed, this works however, so...Hello again, old ratcode!
//add this to anything you want the succubus to feed off, in any cum functions
/datum/sex_action/proc/try_succubus_drain(mob/living/carbon/human/succ, mob/living/carbon/human/victim)
	var/mob/living/carbon/human/drainer
	var/mob/living/carbon/human/drained
//	var/truedrain = FALSE
	var/amountstolen = 0
//	if(HAS_TRAIT(succ, TRAIT_SUCCUBUS) && !HAS_TRAIT(victim, TRAIT_SUCCUBUS))
	if(!is_succubus(victim) && is_succubus(succ))
		drainer = succ
		drained = victim
	//	truedrain = TRUE
//	if(!HAS_TRAIT(succ, TRAIT_SUCCUBUS) && HAS_TRAIT(victim, TRAIT_SUCCUBUS))
	if(is_succubus(victim) && !is_succubus(succ))
		drainer = victim
		drained = succ
	//	truedrain = TRUE
	if (drained && drainer)
		var/datum/antagonist/succubus/SD = drainer.mind.has_antag_datum(/datum/antagonist/succubus)
		var/datum/antagonist/succubus/LSD = drainer.mind.has_antag_datum(/datum/antagonist/succubuslesser)
		if (!SD && !LSD)
			return

		to_chat(drainer, span_love("My victim surrenders [(victim.gender == FEMALE) ? "her" : "his"] essence to me..It feels good!"))
		if (SD)
			if (drained.STASTR > 5 ) // sorry bucko, you aren't becoming a omnipotent horny entity
				drained.change_stat("strength", -2)
				amountstolen += 1
				if (!SD.starved && drainer.STASTR < 15) //prevents exploiting by starving to gain extra stats. Also, kinda makes sense, it's hard to steal more strength when you lack your own!
					drainer.change_stat("strength", 1)
			else
				drained.apply_damage(6, TOX)
			if (drained.STACON > 5 )
				drained.change_stat("constitution", -2)
				amountstolen += 1
				if (!SD.starved && drainer.STACON < 15)
					drainer.change_stat("constitution", 1)
			else
				drained.apply_damage(6, TOX)

			if (drained.STAINT > 5 )
				drained.change_stat("intelligence", -2)
				amountstolen += 1
				if (!SD.starved && drainer.STAINT < 15)
					drainer.change_stat("intelligence", 1)
			else
				drained.apply_damage(6, TOX)
			if (drained.STAEND > 5)
				drained.change_stat("endurance", -2)
				amountstolen += 1
				if (!SD.starved && drainer.STAEND < 15)
					drainer.change_stat("endurance", 1)
			else
				drained.apply_damage(6, TOX)

			SD.handle_vitae(150) // enough for one heal
			amountstolen += 150
			if (!drained.has_status_effect(/datum/status_effect/debuff/succuhate) && !drained.has_status_effect(/datum/status_effect/buff/succulove))
				SD.handle_vitae(50)
				to_chat(drainer, span_love("Fresh essence! It tastes wonderful!"))
				SD.totalensnared += 1
			if (drained.has_status_effect(/datum/status_effect/debuff/succuhate))
				drained.remove_status_effect(/datum/status_effect/debuff/succuhate)
			if (drained.has_status_effect(/datum/status_effect/debuff/succucharm))
				drained.remove_status_effect(/datum/status_effect/debuff/succucharm)
			drained.apply_status_effect(/datum/status_effect/buff/succulove)
		//	SD.succpoints += amountstolen
		else
			LSD.handle_vitae(100)
		to_chat(drained, span_love("That felt so good...I'll need more soon.."))

		drained.sexcon.adjust_charge(300)
		drainer.sexcon.adjust_charge(300) // infinite cum for the cum god