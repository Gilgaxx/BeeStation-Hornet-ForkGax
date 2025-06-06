/mob/living/simple_animal/hostile/alien
	name = "alien hunter"
	desc = "Hiss!"
	icon = 'icons/mob/alien.dmi'
	icon_state = "alienh"
	icon_living = "alienh"
	icon_dead = "alienh_dead"
	icon_gib = "syndicate_gib"
	gender = FEMALE
	speed = 0
	butcher_results = list(/obj/item/food/meat/slab/xeno = 4,
							/obj/item/stack/sheet/animalhide/xeno = 1)
	maxHealth = 125
	health = 125
	obj_damage = 60
	melee_damage = 25
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	speak_emote = list("hisses")
	bubble_icon = "alien"
	combat_mode = TRUE
	attack_sound = 'sound/weapons/bladeslice.ogg'
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list(FACTION_ALIEN)
	status_flags = CANPUSH
	minbodytemp = 0
	see_in_dark = NIGHTVISION_FOV_RANGE
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	unique_name = 1
	gold_core_spawnable = NO_SPAWN
	deathsound = 'sound/voice/hiss6.ogg'
	deathmessage = "lets out a waning guttural screech, green blood bubbling from its maw..."
	chat_color = "#9EE08F"
	mobchatspan = "alienmobsay"

	discovery_points = 2000
	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/hostile/alien/drone
	name = "alien drone"
	icon_state = "aliend"
	icon_living = "aliend"
	icon_dead = "aliend_dead"
	melee_damage = 15
	var/plant_cooldown = 30
	var/plants_off = 0

/mob/living/simple_animal/hostile/alien/drone/handle_automated_action()
	if(!..()) //AIStatus is off
		return
	plant_cooldown--
	if(AIStatus == AI_IDLE)
		if(!plants_off && prob(10) && plant_cooldown<=0)
			plant_cooldown = initial(plant_cooldown)
			SpreadPlants()

/mob/living/simple_animal/hostile/alien/sentinel
	name = "alien sentinel"
	icon_state = "aliens"
	icon_living = "aliens"
	icon_dead = "aliens_dead"
	health = 150
	maxHealth = 150
	melee_damage = 15
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	projectiletype = /obj/projectile/neurotox
	projectilesound = 'sound/weapons/pierce.ogg'


/mob/living/simple_animal/hostile/alien/queen
	name = "alien queen"
	icon_state = "alienq"
	icon_living = "alienq"
	icon_dead = "alienq_dead"
	health = 250
	maxHealth = 250
	melee_damage = 15
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	move_to_delay = 4
	butcher_results = list(/obj/item/food/meat/slab/xeno = 4,
							/obj/item/stack/sheet/animalhide/xeno = 1)
	projectiletype = /obj/projectile/neurotox
	projectilesound = 'sound/weapons/pierce.ogg'
	status_flags = 0
	unique_name = 0
	var/sterile = 1
	var/plants_off = 0
	var/egg_cooldown = 30
	var/plant_cooldown = 30

/mob/living/simple_animal/hostile/alien/queen/handle_automated_action()
	if(!..()) //AIStatus is off
		return
	egg_cooldown--
	plant_cooldown--
	if(AIStatus == AI_IDLE)
		if(!plants_off && prob(10) && plant_cooldown<=0)
			plant_cooldown = initial(plant_cooldown)
			SpreadPlants()
		if(!sterile && prob(10) && egg_cooldown<=0)
			egg_cooldown = initial(egg_cooldown)
			LayEggs()

/mob/living/simple_animal/hostile/alien/proc/SpreadPlants()
	if(!isturf(loc) || isspaceturf(loc))
		return
	if(locate(/obj/structure/alien/weeds/node) in get_turf(src))
		return
	visible_message(span_alertalien("[src] has planted some alien weeds!"))
	new /obj/structure/alien/weeds/node(loc)

/mob/living/simple_animal/hostile/alien/proc/LayEggs()
	if(!isturf(loc) || isspaceturf(loc))
		return
	if(locate(/obj/structure/alien/egg) in get_turf(src))
		return
	visible_message(span_alertalien("[src] has laid an egg!"))
	new /obj/structure/alien/egg(loc)

/mob/living/simple_animal/hostile/alien/queen/large
	name = "alien empress"
	icon = 'icons/mob/alienqueen.dmi'
	icon_state = "alienq"
	icon_living = "alienq"
	icon_dead = "alienq_dead"
	bubble_icon = "alienroyal"
	move_to_delay = 4
	maxHealth = 400
	health = 400
	butcher_results = list(/obj/item/food/meat/slab/xeno = 10,
							/obj/item/stack/sheet/animalhide/xeno = 2)
	mob_size = MOB_SIZE_LARGE
	gold_core_spawnable = NO_SPAWN

/obj/projectile/neurotox
	name = "neurotoxin"
	damage = 30
	icon_state = "toxin"

/mob/living/simple_animal/hostile/alien/handle_temperature_damage()
	if(bodytemperature < minbodytemp)
		adjustBruteLoss(2)
		throw_alert("temp", /atom/movable/screen/alert/cold, 1)
	else if(bodytemperature > maxbodytemp)
		adjustBruteLoss(20)
		throw_alert("temp", /atom/movable/screen/alert/hot, 3)
	else
		clear_alert("temp")

/mob/living/simple_animal/hostile/alien/maid
	name = "lusty xenomorph maid"
	melee_damage = 0
	combat_mode = FALSE
	friendly_verb_continuous = "caresses"
	friendly_verb_simple = "caress"
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	gold_core_spawnable = HOSTILE_SPAWN
	icon_state = "maid"
	icon_living = "maid"
	icon_dead = "maid_dead"
	var/datum/action/cleaning_toggle/maid/autoclean_toggle

/mob/living/simple_animal/hostile/alien/maid/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cleaning)
	autoclean_toggle = new()
	autoclean_toggle.Grant(usr)

/mob/living/simple_animal/hostile/alien/maid/Destroy()
	. = ..()
	autoclean_toggle.Remove(usr)
	QDEL_NULL(autoclean_toggle)

/mob/living/simple_animal/hostile/alien/maid/AttackingTarget()
	if(ismovable(target))
		target.wash(CLEAN_WASH)
		if(istype(target, /obj/effect/decal/cleanable))
			visible_message(span_notice("[src] cleans up \the [target]."))
		else
			visible_message(span_notice("[src] polishes \the [target]."))
		return TRUE
