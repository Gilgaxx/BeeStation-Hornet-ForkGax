/obj/machinery/vending/hydronutrients
	name = "\improper NutriMax"
	desc = "A plant nutrients vendor."
	product_slogans = "Aren't you glad you don't have to fertilize the natural way?;Now with 50% less stink!;Plants are people too!"
	product_ads = "We like plants!;Don't you want some?;The greenest thumbs ever.;We like big plants.;Soft soil..."
	icon_state = "nutri"
	icon_deny = "nutri-deny"
	light_mask = "nutri-light-mask"
	products = list(/obj/item/reagent_containers/cup/bottle/nutrient/ez = 30,
					/obj/item/reagent_containers/cup/bottle/nutrient/l4z = 20,
					/obj/item/reagent_containers/cup/bottle/nutrient/rh = 10,
					/obj/item/reagent_containers/spray/pestspray = 20,
					/obj/item/reagent_containers/syringe = 5,
					/obj/item/storage/bag/plants = 5,
					/obj/item/cultivator = 3,
					/obj/item/shovel/spade = 3,
					/obj/item/plant_analyzer = 4)
	contraband = list(/obj/item/reagent_containers/cup/bottle/ammonia = 10,
						/obj/item/reagent_containers/cup/bottle/diethylamine = 5)
	refill_canister = /obj/item/vending_refill/hydronutrients
	default_price = 10
	extra_price = 50
	dept_req_for_free = ACCOUNT_SRV_BITFLAG

/obj/item/vending_refill/hydronutrients
	machine_name = "NutriMax"
	icon_state = "refill_plant"
