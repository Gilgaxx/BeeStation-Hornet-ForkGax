/datum/antagonist/survivalist
	name = "Survivalist"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	banning_key = ROLE_SURVIVALIST
	var/greet_message = ""

/datum/antagonist/survivalist/proc/forge_objectives()
	if(!give_objectives)
		return
	var/datum/objective/survive/survive = new
	survive.owner = owner
	objectives += survive
	log_objective(owner, survive.explanation_text)

/datum/antagonist/survivalist/on_gain()
	owner.special_role = "survivalist"
	forge_objectives()
	. = ..()

/datum/antagonist/survivalist/greet()
	to_chat(owner, "<B>You are the survivalist![greet_message]</B>")
	owner.announce_objectives()

/datum/antagonist/survivalist/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/datum/atom_hud/antag/survivalisthud = GLOB.huds[ANTAG_HUD_SURVIVALIST]
	survivalisthud.join_hud(owner.current)
	if(!owner.antag_hud_icon_state)	//Don't override traitor huds etc, they are more important.
		set_antag_hud(owner.current, "survivalist")

/datum/antagonist/survivalist/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/datum/atom_hud/antag/survivalisthud = GLOB.huds[ANTAG_HUD_SURVIVALIST]
	survivalisthud.leave_hud(owner.current)
	if(owner.antag_hud_icon_state == "survivalist")
		set_antag_hud(owner.current, null)

/datum/antagonist/survivalist/guns
	greet_message = "Your own safety matters above all else, and the only way to ensure your safety is to stockpile weapons! Grab as many guns as possible, by any means necessary. Kill anyone who gets in your way."

/datum/antagonist/survivalist/guns/forge_objectives()
	var/datum/objective/steal_five_of_type/summon_guns/guns = new
	guns.owner = owner
	objectives += guns
	log_objective(owner, guns.explanation_text)
	..()

/datum/antagonist/survivalist/magic
	name = "Amateur Magician"
	greet_message = "Grow your newfound talent! Grab as many magical artefacts as possible, by any means necessary. Kill anyone who gets in your way."

/datum/antagonist/survivalist/magic/greet()
	..()
	to_chat(owner, span_notice("As a wonderful magician, you should remember that spellbooks don't mean anything if they are used up."))

/datum/antagonist/survivalist/magic/forge_objectives()
	var/datum/objective/steal_five_of_type/summon_magic/magic = new
	magic.owner = owner
	objectives += magic
	log_objective(owner, magic.explanation_text)
	..()
