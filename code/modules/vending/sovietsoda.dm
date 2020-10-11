/obj/machinery/vending/sovietsoda
	name = "\improper BODA"
	desc = "Alter Süßwasserautomat."
	icon_state = "sovietsoda"
	light_color = LIGHT_COLOR_TUNGSTEN
	product_ads = "Für Zar und Vaterland:;Habt ihr heute eure Ernährungsquote erfüllt?;Sehr schön!;Wir sind einfache Leute, denn das ist alles, was wir essen;;Wenn es einen Menschen gibt, gibt es ein Problem. Wenn es keinen Menschen gibt, dann gibt es kein Problem."
	products = list(/obj/item/reagent_containers/food/drinks/drinkingglass/filled/soda = 30)
	contraband = list(/obj/item/reagent_containers/food/drinks/drinkingglass/filled/cola = 20)
	refill_canister = /obj/item/vending_refill/sovietsoda
	resistance_flags = FIRE_PROOF
	default_price = 1
	extra_price = 1
	payment_department = NO_FREEBIES

/obj/item/vending_refill/sovietsoda
	machine_name = "BODA"
	icon_state = "refill_cola"
