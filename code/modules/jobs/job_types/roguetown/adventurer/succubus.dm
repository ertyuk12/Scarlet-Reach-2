/datum/job/roguetown/succubus
	title = "Succubus"
	flag = SUCCUBUS
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 6
	spawn_positions = 6
	antag_job = TRUE
	allowed_races = RACES_ALL_KINDS
	tutorial = "Whether created by Baotha, as per the story, or a deviant who simply permitted Baotha's hand to work on them, you've become a 'Nite-beast' of a unique kind..Instead of bringing fear and pain, as the other kinds do, you bring pleasure and lust. However, your inability to partake in combat, has made you weaker, and your hunger is just as strong as the other kinds'. All you can hope, is to charm more than you enrage."

	outfit = null
	outfit_female = null

	display_order = JDO_SUCCUBUS
	show_in_credits = FALSE
	announce_latejoin = FALSE
	min_pq = null // for testing lol
	max_pq = null

	advclass_cat_rolls = list(CTAG_SUCCUBUS = 20)
	PQ_boost_divider = 10
	wanderer_examine = TRUE
	obsfuscated_job = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 30 MINUTES


//	cmode_music = 'sound/music/combat_bandit2.ogg'

/datum/job/roguetown/succubus/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		if(!H.mind)
			return
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		H.ambushable = FALSE

	//	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "SUCCUBUS"), 5 SECONDS)

datum/outfit/job/roguetown/succubus/post_equip(mob/living/carbon/human/H)
	..()
	var/datum/antagonist/new_antag = new /datum/antagonist/succubus()
		H.mind.add_antag_datum(new_antag)