/obj/machinery/vending/coffee
	name = "\improper Solar's Best Hot Drinks"
	desc = "Ein Automat, der heiße Getränke ausgibt."
	product_ads = "Nimm einen Drink!;Trink aus!;Das tut dir gut!;Möchtest du einen heißen Kaffee?;Für Kaffee würde ich töten!;Die besten Bohnen in der Galaxie.;Nur das beste Gebräu für dich.;Mmmm. Nichts geht über einen Kaffee;Ich mag Kaffee, du nicht?;Kaffee hilft dir bei der Arbeit!;Probier mal Tee!;Wir hoffen, du magst das Beste!;Probier unsere neue Schokolade!;Verschwörungen der Verwaltung"
	icon_state = "coffee"
	icon_vend = "coffee-vend"
	light_color = LIGHT_COLOR_BROWN
	products = list(/obj/item/reagent_containers/food/drinks/coffee = 6,
		            /obj/item/reagent_containers/food/drinks/mug/tea = 6,
		            /obj/item/reagent_containers/food/drinks/mug/cocoa = 3)
	contraband = list(/obj/item/reagent_containers/food/drinks/ice = 12)
	refill_canister = /obj/item/vending_refill/coffee
	default_price = 10
	extra_price = 25
	payment_department = ACCOUNT_SRV
/obj/item/vending_refill/coffee
	machine_name = "Solar's Best Hot Drinks"
	icon_state = "refill_joe"
