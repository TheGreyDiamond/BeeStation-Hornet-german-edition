/obj/machinery/vending/sustenance
	name = "\improper Sustenance Vendor"
	desc = "Ein Automat, der Essen ausgibt, wie in Abschnitt 47-C des NT's Prisoner Ethical Treatment Agreement (Vereinbarung über die ethische Behandlung von Gefangenen) gefordert."
	product_slogans = "Genieße deine Mahlzeit;Genug Kalorien, um anstrengende Arbeit zu unterstützen."
	product_ads = "Ausreichend gesund;Effizient produzierter Tofu;Mmm! So gut!;Nimm eine Mahlzeit zu dir!;Du brauchst Nahrung zum Leben!;Nimm noch etwas Zuckermais!;Probiere unsere neuen Eisbecher!"
	icon_state = "sustenance"
	light_color = LIGHT_COLOR_BLUEGREEN
	products = list(/obj/item/reagent_containers/food/snacks/tofu/prison = 24,
					/obj/item/reagent_containers/food/drinks/ice/prison = 12,
					/obj/item/reagent_containers/food/snacks/candy_corn/prison = 6)
	contraband = list(/obj/item/kitchen/knife = 6,
					  /obj/item/reagent_containers/food/drinks/coffee = 12,
					  /obj/item/tank/internals/emergency_oxygen = 6,
					  /obj/item/clothing/mask/breath = 6)
	refill_canister = /obj/item/vending_refill/sustenance
	default_price = 0
	extra_price = 0
	payment_department = NO_FREEBIES

/obj/item/vending_refill/sustenance
	machine_name = "Sustenance Vendor"
	icon_state = "refill_snack"
