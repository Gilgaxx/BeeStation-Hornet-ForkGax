
/obj/item/clothing/suit/space/space_ninja/proc/ninja_sword_recall()
	var/mob/living/carbon/human/H = affecting

	var/cost = 0
	var/inview = 1

	if(!energyKatana)
		to_chat(H, span_warning("Could not locate Energy Katana!"))
		return

	if(energyKatana in H)
		return

	var/distance = get_dist(H,energyKatana)

	if(!(energyKatana in view(H)))
		cost = distance //Actual cost is cost x 10, so 5 turfs is 50 cost.
		inview = 0

	if(!ninjacost(cost))
		if(iscarbon(energyKatana.loc))
			var/mob/living/carbon/C = energyKatana.loc
			C.transferItemToLoc(energyKatana, get_turf(energyKatana), TRUE)

		else
			energyKatana.forceMove(get_turf(energyKatana))

		if(inview) //If we can see the katana, throw it towards ourselves, damaging people as we go.
			energyKatana.spark_system.start()
			playsound(H, "sparks", 50, 1)
			H.visible_message(span_danger("\the [energyKatana] flies towards [H]!"),span_warning("You hold out your hand and \the [energyKatana] flies towards you!"))
			energyKatana.throw_at(H, distance+1, energyKatana.throw_speed,H)

		else //Else just TP it to us.
			energyKatana.returnToOwner(H,1)
