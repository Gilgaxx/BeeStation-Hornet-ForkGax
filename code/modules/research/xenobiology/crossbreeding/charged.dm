/*
Charged extracts:
	Have a unique, effect when filled with
	10u plasma and activated in-hand, related to their
	normal extract effect.
*/
/obj/item/slimecross/charged
	name = "charged extract"
	desc = "It sparks with electric power."
	effect = "charged"
	icon_state = "charged"

/obj/item/slimecross/charged/Initialize(mapload)
	. = ..()
	create_reagents(10, INJECTABLE | DRAWABLE)

/obj/item/slimecross/charged/attack_self(mob/user)
	if(!reagents.has_reagent(/datum/reagent/toxin/plasma,10))
		to_chat(user, span_warning("This extract needs to be full of plasma to activate!"))
		return
	reagents.remove_reagent(/datum/reagent/toxin/plasma,10)
	to_chat(user, span_notice("You squeeze the extract, and it absorbs the plasma!"))
	playsound(src, 'sound/effects/bubbles.ogg', 50, 1)
	playsound(src, 'sound/effects/light_flicker.ogg', 50, 1)
	do_effect(user)

/obj/item/slimecross/charged/proc/do_effect(mob/user) //If, for whatever reason, you don't want to delete the extract, don't do ..()
	qdel(src)
	return

/obj/item/slimecross/charged/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "Produces a slime reviver potion, which revives dead slimes."

/obj/item/slimecross/charged/grey/do_effect(mob/user)
	new /obj/item/slimepotion/slime_reviver(get_turf(user))
	user.visible_message(span_notice("[src] distills into a potion!"))
	..()

/obj/item/slimecross/charged/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "Instantly makes a large burst of flame for a moment."

/obj/item/slimecross/charged/orange/do_effect(mob/user)
	for(var/turf/open/turf in RANGE_TURFS(5, user))
		if(!locate(/obj/effect/hotspot) in turf)
			new /obj/effect/hotspot(turf)
	..()

/obj/item/slimecross/charged/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "Creates a packet of omnizine."

/obj/item/slimecross/charged/purple/do_effect(mob/user)
	new /obj/item/slimecrossbeaker/omnizine(get_turf(user))
	user.visible_message(span_notice("[src] sparks, and floods with a regenerative solution!"))
	..()

/obj/item/slimecross/charged/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "Creates a potion that neuters the mutation chance of a slime, which passes on to new generations."

/obj/item/slimecross/charged/blue/do_effect(mob/user)
	new /obj/item/slimepotion/slime/chargedstabilizer(get_turf(user))
	user.visible_message(span_notice("[src] distills into a potion!"))
	..()

/obj/item/slimecross/charged/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "Produces a bunch of metal and plasteel."

/obj/item/slimecross/charged/metal/do_effect(mob/user)
	new /obj/item/stack/sheet/iron(get_turf(user), 25)
	new /obj/item/stack/sheet/plasteel(get_turf(user), 10)
	user.visible_message(span_notice("[src] grows into a plethora of metals!"))
	..()

/obj/item/slimecross/charged/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "Creates a hypercharged slime cell battery, which has high capacity and recharges constantly at a very fast rate."

/obj/item/slimecross/charged/yellow/do_effect(mob/user)
	new /obj/item/stock_parts/cell/high/slime/hypercharged(get_turf(user))
	user.visible_message(span_notice("[src] sparks violently, and swells with electric power!"))
	..()

/obj/item/slimecross/charged/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "Creates several sheets of plasma."

/obj/item/slimecross/charged/darkpurple/do_effect(mob/user)
	new /obj/item/stack/sheet/mineral/plasma(get_turf(user), 10)
	user.visible_message(span_notice("[src] produces a large amount of plasma!"))
	..()

/obj/item/slimecross/charged/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "Produces a pressure proofing potion."

/obj/item/slimecross/charged/darkblue/do_effect(mob/user)
	new /obj/item/slimepotion/spaceproof(get_turf(user))
	user.visible_message(span_notice("[src] distills into a potion!"))
	..()

/obj/item/slimecross/charged/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "Creates a slime cake and some drinks."

/obj/item/slimecross/charged/silver/do_effect(mob/user)
	new /obj/item/food/cake/slimecake(get_turf(user))
	for(var/i in 1 to 10)
		var/drink_type = get_random_drink()
		new drink_type(get_turf(user))
	user.visible_message(span_notice("[src] produces a party's worth of cake and drinks!"))
	..()

/obj/item/slimecross/charged/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "Makes a bluespace crystal."

/obj/item/slimecross/charged/bluespace/do_effect(mob/user)
	new /obj/item/stack/ore/bluespace_crystal/refined(get_turf(user), 10)
	user.visible_message(span_notice("[src] produces several sheets of crystal!"))
	..()

/obj/item/slimecross/charged/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "Creates a camera obscura."

/obj/item/slimecross/charged/sepia/do_effect(mob/user)
	new /obj/item/camera/spooky(get_turf(user))
	user.visible_message(span_notice("[src] flickers in a strange, ethereal manner, and produces a camera!"))
	..()

/obj/item/slimecross/charged/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "Creates an extract enhancer, giving whatever it's used on five more uses."

/obj/item/slimecross/charged/cerulean/do_effect(mob/user)
	new /obj/item/slimepotion/enhancer/max(get_turf(user))
	user.visible_message(span_notice("[src] distills into a potion!"))
	..()

/obj/item/slimecross/charged/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "Creates bananium. Oh no."

/obj/item/slimecross/charged/pyrite/do_effect(mob/user)
	new /obj/item/stack/sheet/mineral/bananium(get_turf(user), 10)
	user.visible_message(span_warning("[src] solidifies with a horrifying banana stench!"))
	..()

/obj/item/slimecross/charged/red
	colour = SLIME_TYPE_RED
	effect_desc = "Produces a lavaproofing potion"

/obj/item/slimecross/charged/red/do_effect(mob/user)
	new /obj/item/slimepotion/lavaproof(get_turf(user))
	user.visible_message(span_notice("[src] distills into a potion!"))
	..()

/obj/item/slimecross/charged/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "Lets you choose what slime species you want to be."

/obj/item/slimecross/charged/green/do_effect(mob/user)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		to_chat(user, span_warning("You must be a humanoid to use this!"))
		return
	var/racechoice = input(H, "Choose your slime subspecies.", "Slime Selection") as null|anything in sort_list(subtypesof(/datum/species/oozeling), GLOBAL_PROC_REF(cmp_typepaths_asc))
	if(!racechoice)
		to_chat(user, span_notice("You decide not to become a slime for now."))
		return
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	H.set_species(racechoice, icon_update=1)
	H.visible_message(span_warning("[H] suddenly shifts form as [src] dissolves into [H.p_their()] skin!"))
	..()

/obj/item/slimecross/charged/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "Produces a... lovepotion... no ERP."

/obj/item/slimecross/charged/pink/do_effect(mob/user)
	new /obj/item/slimepotion/lovepotion(get_turf(user))
	user.visible_message(span_notice("[src] distills into a potion!"))
	..()

/obj/item/slimecross/charged/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "Slowly spawns 10 hostile monsters."
	var/max_spawn = 10
	var/spawned = 0

/obj/item/slimecross/charged/gold/do_effect(mob/user)
	user.visible_message(span_warning("[src] starts shuddering violently!"))
	addtimer(CALLBACK(src, PROC_REF(startTimer)), 50)

/obj/item/slimecross/charged/gold/proc/startTimer()
	START_PROCESSING(SSobj, src)

/obj/item/slimecross/charged/gold/process()
	visible_message(span_warning("[src] lets off a spark, and produces a living creature!"))
	new /obj/effect/particle_effect/sparks(get_turf(src))
	playsound(get_turf(src), "sparks", 50, 1)
	create_random_mob(get_turf(src), HOSTILE_SPAWN)
	spawned++
	if(spawned >= max_spawn)
		visible_message(span_warning("[src] collapses into a puddle of goo."))
		qdel(src)

/obj/item/slimecross/charged/gold/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/slimecross/charged/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "Creates an explosion after a few seconds."

/obj/item/slimecross/charged/oil/do_effect(mob/user)
	user.visible_message(span_danger("[src] begins to shake with rapidly increasing force!"))
	addtimer(CALLBACK(src, PROC_REF(boom)), 50)

/obj/item/slimecross/charged/oil/proc/boom()
	explosion(get_turf(src), 3, 2, 1) //Much smaller effect than normal oils, but devastatingly strong where it does hit.
	qdel(src)

/obj/item/slimecross/charged/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "Randomizes the user's species."

/obj/item/slimecross/charged/black/do_effect(mob/user)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		to_chat(user, span_warning("You have to be able to have a species to get your species changed."))
		return
	var/list/allowed_species = list()
	for(var/stype in subtypesof(/datum/species))
		var/datum/species/X = stype
		if(initial(X.changesource_flags) & SLIME_EXTRACT)
			allowed_species += stype

	var/datum/species/changed = pick(allowed_species)
	if(changed)
		H.set_species(changed, icon_update = 1)
		to_chat(H, span_danger("You feel very different!"))
	..()

/obj/item/slimecross/charged/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "Produces a pacification potion, which works on monsters and humanoids."

/obj/item/slimecross/charged/lightpink/do_effect(mob/user)
	new /obj/item/slimepotion/peacepotion(get_turf(user))
	user.visible_message(span_notice("[src] distills into a potion!"))
	..()

/obj/item/slimecross/charged/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "Creates a completed golem shell."

/obj/item/slimecross/charged/adamantine/do_effect(mob/user)
	user.visible_message(span_notice("[src] produces a fully formed golem shell!"))
	new /obj/effect/mob_spawn/human/golem/servant(get_turf(src), /datum/species/golem/adamantine, user)
	..()

/obj/item/slimecross/charged/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "Produces three living slimes of random colors."

/obj/item/slimecross/charged/rainbow/do_effect(mob/user)
	user.visible_message(span_warning("[src] swells and splits into three new slimes!"))
	for(var/i in 1 to 3)
		var/mob/living/simple_animal/slime/S = new(get_turf(user))
		S.random_colour()
	..()
