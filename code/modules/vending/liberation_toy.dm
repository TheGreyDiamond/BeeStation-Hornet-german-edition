/obj/machinery/vending/toyliberationstation
	name = "\improper Syndicate Donksoft Toy Vendor"
	desc = "Ein ab 8 Jahren zugelassener Verkäufer, der Spielzeug ausgibt. Wenn du die richtigen Drähte findest, kannst du den Erwachsenenmodus freischalten!"
	icon_state = "syndi"
	product_slogans = "Besorg dir noch heute deine coolen Spielzeuge!;Löse noch heute einen gültigen Jäger aus!;Qualitativ hochwertige Spielzeugwaffen zu günstigen Preisen!;Gib sie HoPs für alle Zugriffe!;Gib sie HoS zum Permabriggen!"
	product_ads = "Fühle dich robust mit deinem Spielzeug!;Drücke dein inneres Kind heute aus!;Spielzeugwaffen töten keine Menschen, aber gültige Jäger schon!;Wer braucht Verantwortung, wenn du Spielzeugwaffen hast?;Mach deinen nächsten Mord zum Spaß!"
	vend_reply = "Kommt zurück für mehr!"
	light_color = LIGHT_COLOR_RED
	circuit = /obj/item/circuitboard/machine/vending/syndicatedonksofttoyvendor
	products = list(/obj/item/gun/ballistic/automatic/toy/unrestricted = 10,
					/obj/item/gun/ballistic/automatic/toy/pistol/unrestricted = 10,
					/obj/item/gun/ballistic/shotgun/toy/unrestricted = 10,
					/obj/item/toy/sword = 10,
					/obj/item/ammo_box/foambox = 20,
					/obj/item/toy/foamblade = 10,
					/obj/item/toy/syndicateballoon = 10,
					/obj/item/clothing/suit/syndicatefake = 5,
					/obj/item/clothing/head/syndicatefake = 5) //OPS IN DORMS oh wait it's just an assistant
	contraband = list(/obj/item/gun/ballistic/shotgun/toy/crossbow = 10,   //Congrats, you unlocked the +18 setting!
					  /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot = 10,
					  /obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted/riot = 10,
					  /obj/item/ammo_box/foambox/riot = 20,
					  /obj/item/toy/katana = 10,
					  /obj/item/twohanded/dualsaber/toy = 5,
					  /obj/item/toy/cards/deck/syndicate = 10) //Gambling and it hurts, making it a +18 item
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/donksoft
	default_price = 25
	extra_price = 50
	payment_department = ACCOUNT_SRV
