/obj/machinery/vending/hydronutrients
	name = "\improper NutriMax"
	desc = "Ein Lieferant von Pflanzennährstoffen."
	product_slogans = "Bist du nicht froh, dass du nicht mehr auf natürliche Weise düngen musst?;Jetzt mit 50% weniger Gestank!;Pflanzen sind auch Menschen!"
	product_ads = "Wir mögen Pflanzen!;Willst du nicht auch welche?;Die grünsten Daumen aller Zeiten;Wir mögen große Pflanzen;Weiche Erde..."
	icon_state = "nutri"
	icon_deny = "nutri-deny"
	light_color = LIGHT_COLOR_GREEN
	products = list(/obj/item/reagent_containers/glass/bottle/nutrient/ez = 30,
					/obj/item/reagent_containers/glass/bottle/nutrient/l4z = 20,
					/obj/item/reagent_containers/glass/bottle/nutrient/rh = 10,
					/obj/item/reagent_containers/spray/pestspray = 20,
					/obj/item/reagent_containers/syringe = 5,
					/obj/item/storage/bag/plants = 5,
					/obj/item/cultivator = 3,
					/obj/item/shovel/spade = 3,
					/obj/item/plant_analyzer = 4)
	contraband = list(/obj/item/reagent_containers/glass/bottle/ammonia = 10,
					  /obj/item/reagent_containers/glass/bottle/diethylamine = 5)
	refill_canister = /obj/item/vending_refill/hydronutrients
	default_price = 10
	extra_price = 50
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/hydronutrients
	machine_name = "NutriMax"
	icon_state = "refill_plant"
