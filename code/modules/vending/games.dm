/obj/machinery/vending/games
	name = "\improper Good Clean Fun"
	desc = "Verkauft Dinge, bei denen der Kapitän und der Personalchef es wahrscheinlich nicht zu schätzen wissen werden, dass du an deinem Job herumfummelst..."
	product_ads = "Entfliehe in eine Fantasiewelt!;Schüre deine Spielsucht!;Ruiniere deine Freundschaften!;Ergreife die Initiative!;Elfen und Zwerge!;Paranoide Computer!;Absolut nicht satanisch!;Spaß für immer!"
	icon_state = "games"
	light_color = LIGHT_COLOR_ORANGE
	products = list(/obj/item/toy/cards/deck = 5,
		            /obj/item/storage/pill_bottle/dice = 10,
		            /obj/item/toy/cards/deck/cas = 3,
		            /obj/item/toy/cards/deck/cas/black = 3,
		            /obj/item/toy/cards/deck/unum = 3,
					/obj/item/hourglass = 2)
	contraband = list(/obj/item/dice/fudge = 9)
	premium = list(/obj/item/melee/skateboard/pro = 3,
					/obj/item/melee/skateboard/hoverboard = 1)
	refill_canister = /obj/item/vending_refill/games
	default_price = 10
	extra_price = 25
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/games
	machine_name = "\improper Good Clean Fun"
	icon_state = "refill_games"
