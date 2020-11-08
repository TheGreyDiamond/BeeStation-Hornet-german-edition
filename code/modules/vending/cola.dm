
/obj/machinery/vending/cola
	name = "\improper Robust Softdrinks"
	desc = "Ein Anbieter von Erfrischungsgetränken, bereitgestellt von Robust Industries, LLC."
	icon_state = "Cola_Machine"
	product_slogans = "Robuste Softdrinks: Robuster als ein Werkzeugkasten am Kopf!"
	product_ads = "Erfrischend!;Hoffentlich hast du Durst!;Über 1 Million verkaufte Getränke!;Durstig? Warum nicht Cola?;Bitte, trink etwas!;Trink aus!;Die besten Getränke im Weltraum."
	light_color = LIGHT_COLOR_BLUE
	products = list(/obj/item/reagent_containers/food/drinks/soda_cans/cola = 10,
		            /obj/item/reagent_containers/food/drinks/soda_cans/space_mountain_wind = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/dr_gibb = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/starkist = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/space_up = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/pwr_game = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/lemon_lime = 10,
					/obj/item/reagent_containers/glass/waterbottle = 10)
	contraband = list(/obj/item/reagent_containers/food/drinks/soda_cans/thirteenloko = 6,
		              /obj/item/reagent_containers/food/drinks/soda_cans/shamblers = 6)
	premium = list(/obj/item/reagent_containers/food/drinks/drinkingglass/filled/nuka_cola = 1,
		           /obj/item/reagent_containers/food/drinks/soda_cans/air = 1,
		           /obj/item/reagent_containers/food/drinks/soda_cans/monkey_energy = 1,
		           /obj/item/reagent_containers/food/drinks/soda_cans/grey_bull = 1)
	refill_canister = /obj/item/vending_refill/cola
	default_price = 10
	extra_price = 30
	payment_department = ACCOUNT_SRV
/obj/item/vending_refill/cola
	machine_name = "Robust Softdrinks"
	icon_state = "refill_cola"

/obj/machinery/vending/cola/random
	name = "\improper Random Drinkies"
	icon_state = "random_cola"
	desc = "Uh oh!"

/obj/machinery/vending/cola/random/Initialize()
	..()
	var/T = pick(subtypesof(/obj/machinery/vending/cola) - /obj/machinery/vending/cola/random)
	new T(loc)
	return INITIALIZE_HINT_QDEL

/obj/machinery/vending/cola/blue
	icon_state = "Cola_Machine"

/obj/machinery/vending/cola/black
	icon_state = "cola_black"
	light_color = LIGHT_COLOR_WHITE

/obj/machinery/vending/cola/red
	icon_state = "red_cola"
	name = "\improper Space Cola Vendor"
	desc = "Es verkauft Cola, im Weltraum."
	product_slogans = "Cola in space!"
	light_color = LIGHT_COLOR_RED

/obj/machinery/vending/cola/space_up
	icon_state = "space_up"
	name = "\improper Space-up! Vendor"
	desc = "Schwelge in einer Explosion des Geschmacks."
	product_slogans = "Weltraum-Aufstieg! Wie ein Hüllenbruch in deinem Mund."
	light_color = LIGHT_COLOR_GREEN

/obj/machinery/vending/cola/starkist
	icon_state = "starkist"
	name = "\improper Star-kist Vendor"
	desc = "Der Geschmack eines Sterns in flüssiger Form."
	product_slogans = "Trink die Sterne! Sternen-Kist!"
	light_color = LIGHT_COLOR_ORANGE

/obj/machinery/vending/cola/sodie
	icon_state = "soda"
	light_color = LIGHT_COLOR_LAVA

/obj/machinery/vending/cola/pwr_game
	icon_state = "pwr_game"
	name = "\improper Pwr Game Vendor"
	desc = "Du willst es, wir haben es. Zu dir gebracht in Partnerschaft mit Vlad's Salads."
	product_slogans = "The POWER that gamers crave! PWR GAME!"
	light_color = LIGHT_COLOR_PURPLE

/obj/machinery/vending/cola/shamblers
	name = "\improper Shambler's Vendor"
	desc = "~Schüttle mir etwas von diesem Shambler's Juice!~"
	icon_state = "shamblers_juice"
	light_color = LIGHT_COLOR_RED
	products = list(/obj/item/reagent_containers/food/drinks/soda_cans/cola = 10,
		            /obj/item/reagent_containers/food/drinks/soda_cans/space_mountain_wind = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/dr_gibb = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/starkist = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/space_up = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/pwr_game = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/lemon_lime = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/shamblers = 10)
	product_slogans = "~Schüttle mir etwas von diesem Shambler's Juice auf!~"
	product_ads = "Erfrischend!;Jyrbv dv lg jfdv fw kyrk Jyrdscvi'j Alztv!;Über 1 Billionen Seelen Schnaps!;Durstig? Nyp efk uizeb kyv uribevjjjj?;Kyv Jyrdscvi uizebj kyv ezxyk!;Trink aus!;Krjkp."
