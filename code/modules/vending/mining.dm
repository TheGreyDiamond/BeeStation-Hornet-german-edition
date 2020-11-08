/obj/machinery/vending/mining
	name = "\improper Miner Nutrition Vendor"
	desc = "Ein Automat, der vorverpackte Mahlzeiten ausgibt. Nichts für Feinschmecker, aber es wird nicht schrecklich schmecken."
	product_slogans = "Bleib im Kampf!;Geh wieder da raus, Champ!;Denk dran, bleib am Leben!;Deine Dienste werden sehr geschätzt!"
	product_ads = "Bleib dran, bleib dran!; Bleib am Leben mit dem neuen Menü-35!;Mahlzeiten, die für einen Dämonentöter geeignet sind!; Schnapp dir einen Bissen und mach uns stolz!"
	icon_state = "sustenance"
	light_color = LIGHT_COLOR_BLUEGREEN
	products = list(/obj/item/reagent_containers/food/snacks/donkpocket/warm = 8,
					/obj/item/reagent_containers/food/snacks/salad/herbsalad = 6,
					/obj/item/reagent_containers/food/snacks/canned/beans = 4,
					/obj/item/reagent_containers/glass/waterbottle/large = 10)
	contraband = list(/obj/item/reagent_containers/food/drinks/coffee = 10,
					  /obj/item/reagent_containers/food/snacks/chips = 6,
					  /obj/item/reagent_containers/food/snacks/icecreamsandwich = 6)
	refill_canister = /obj/item/vending_refill/mining
	default_price = 0
	extra_price = 0
	payment_department = NO_FREEBIES

/obj/item/vending_refill/mining
	machine_name = "Mining Nutrition Vendor"
	icon_state = "refill_snack"
