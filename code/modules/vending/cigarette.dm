/obj/machinery/vending/cigarette
	name = "\improper ShadyCigs Deluxe"
	desc = "Wenn du Krebs bekommen willst, kannst du das auch mit Stil tun."
	product_slogans = "Weltraum-Zigaretten schmecken so gut, wie eine Zigarette schmecken sollte;Lieber Werkzeugkiste als Schalter;Rauchen!;Glaubt den Berichten nicht - raucht heute!"
	product_ads = "Wahrscheinlich nicht schlecht für dich!;Glaube den Wissenschaftlern nicht!;Es ist gut für dich!;Gib nicht auf, kauf mehr!;Rauch!;Nikotinhimmel.;Die besten Zigaretten seit 2150;Preisgekrönte Zigaretten."
	icon_state = "cigs"
	light_color = LIGHT_COLOR_CYAN
	products = list(/obj/item/storage/fancy/cigarettes = 5,
					/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_robust = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_midori = 3,
					/obj/item/storage/box/matches = 10,
					/obj/item/lighter/greyscale = 4,
					/obj/item/storage/fancy/rollingpapers = 5)
	contraband = list(/obj/item/clothing/mask/vape = 5)
	premium = list(/obj/item/storage/fancy/cigarettes/cigpack_robustgold = 3,
				   /obj/item/lighter = 3,
		           /obj/item/storage/fancy/cigarettes/cigars = 1,
		           /obj/item/storage/fancy/cigarettes/cigars/havana = 1,
		           /obj/item/storage/fancy/cigarettes/cigars/cohiba = 1)
	refill_canister = /obj/item/vending_refill/cigarette
	default_price = 10
	extra_price = 50
	payment_department = ACCOUNT_SRV

/obj/machinery/vending/cigarette/syndicate
	products = list(/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 7,
					/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_robust = 2,
					/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_midori = 1,
					/obj/item/storage/box/matches = 10,
					/obj/item/lighter/greyscale = 4,
					/obj/item/storage/fancy/rollingpapers = 5)

/obj/machinery/vending/cigarette/beach //Used in the lavaland_biodome_beach.dmm ruin
	name = "\improper ShadyCigs Ultra"
	desc = "Jetzt mit extra Premium-Produkten!"
	product_ads = "Wahrscheinlich nicht schlecht für dich!;Dope wird dich besser durch Zeiten ohne Geld bringen, als Geld dich durch Zeiten ohne Dope!"
	product_slogans = "Einschalten, einstimmen, aussteigen!;Besser leben durch Chemie!;Toke!;Vergiss nicht, ein Lächeln auf den Lippen und ein Lied im Herzen zu behalten!"
	products = list(/obj/item/storage/fancy/cigarettes = 5,
					/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_robust = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_midori = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_cannabis = 5,
					/obj/item/storage/box/matches = 10,
					/obj/item/lighter/greyscale = 4,
					/obj/item/storage/fancy/rollingpapers = 5)
	premium = list(/obj/item/storage/fancy/cigarettes/cigpack_mindbreaker = 5,
					/obj/item/clothing/mask/vape = 5,
					/obj/item/lighter = 3)

/obj/item/vending_refill/cigarette
	machine_name = "ShadyCigs Deluxe"
	icon_state = "refill_smoke"

/obj/machinery/vending/cigarette/pre_throw(obj/item/I)
	if(istype(I, /obj/item/lighter))
		var/obj/item/lighter/L = I
		L.set_lit(TRUE)
