//cambot
/mob/living/simple_animal/bot/cambot
	name = "\improper cambot"
	desc = "A little robot with a camera. A less annyoing tourist."
	icon = 'goon/icons/obj/cambot.dmi'
	icon_state = "cambot0"
	density = FALSE
	anchored = FALSE
	health = 25
	maxHealth = 25
	radio_key = /obj/item/encryptionkey/headset_service
	radio_channel = RADIO_CHANNEL_SERVICE //Service
	bot_type = CAM_BOT
	model = "Cambot"
	bot_core_type = /obj/machinery/bot_core/cambot
	window_id = "autocam"
	window_name = "Automatic Station Photographer v1.5"
	pass_flags = PASSMOB
	path_image_color = "#004080"

	var/allowHumans = 1 // Allow a photo of a human?
	var/test = 1 // Test

	var/obj/item/camera/cam = null
	var/list/photographed = null
	var/list/target_types
	var/obj/effect/decal/cleanable/target
	var/max_targets = 50 //Maximum number of targets a cambot can ignore.
	var/oldloc = null
	var/closest_dist
	var/closest_loc
	var/failed_steps
	var/next_dest
	var/next_dest_loc
	var/word = "photos"
	var/amountOfImages2 = 0

/mob/living/simple_animal/bot/cambot/Initialize()
	. = ..()
	get_targets()
	cam = new /obj/item/camera(src)
	icon_state = "cambot[on]"

	var/datum/job/janitor/J = new/datum/job/janitor
	access_card.access += J.get_access()
	prev_access = access_card.access

/mob/living/simple_animal/bot/cambot/turn_on()
	..()
	icon_state = "cambot[on]"
	bot_core.updateUsrDialog()

/mob/living/simple_animal/bot/cambot/turn_off()
	..()
	icon_state = "cambot[on]"
	bot_core.updateUsrDialog()

/mob/living/simple_animal/bot/cambot/bot_reset()
	..()
	ignore_list = list() //Allows the bot to clean targets it previously ignored due to being unreachable.
	target = null
	oldloc = null

/mob/living/simple_animal/bot/cambot/set_custom_texts()
	text_hack = "You corrupt [name]'s photographing software."
	text_dehack = "[name]'s software has been reset!"
	text_dehack_fail = "[name] does not seem to respond to your repair code!"

/mob/living/simple_animal/bot/cambot/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/card/id)||istype(W, /obj/item/pda))
		if(bot_core.allowed(user) && !open && !emagged)
			locked = !locked
			to_chat(user, "<span class='notice'>You [ locked ? "lock" : "unlock"] \the [src] behaviour controls.</span>")
		else
			if(emagged)
				to_chat(user, "<span class='warning'>ERROR</span>")
			if(open)
				to_chat(user, "<span class='warning'>Please close the access panel before locking it.</span>")
			else
				to_chat(user, "<span class='notice'>\The [src] doesn't seem to respect your authority.</span>")
	else
		return ..()

/mob/living/simple_animal/bot/cambot/emag_act(mob/user)
	..()
	if(emagged == 2)
		if(user)
			to_chat(user, "<span class='danger'>[src] buzzes and beeps.</span>")
			icon_state = "cambot-spark"

/mob/living/simple_animal/bot/cambot/process_scan(atom/A)
	if(iscarbon(A))
		var/mob/living/carbon/C = A
		if(C.stat != DEAD && !(C.mobility_flags & MOBILITY_STAND))
			return C
	else if(is_type_in_typecache(A, target_types))
		return A

/mob/living/simple_animal/bot/cambot/handle_automated_action()
	if(!..())
		return

	if(mode == BOT_PHOTOGRAPHING)
		return

	/*if(emagged == 2) //Emag functions
		if(isopenturf(loc))

			for(var/mob/living/carbon/victim in loc)
				if(victim != target)
					UnarmedAttack(victim) // Acid spray

			if(prob(15)) // Wets floors and spawns foam randomly
				UnarmedAttack(src)*/

	if(prob(5))
		audible_message("[src] makes an excited beeping booping sound!")

	if(ismob(target))
		if(!(target in view(DEFAULT_SCAN_RANGE, src)))
			target = null
		if(!process_scan(target))
			target = null

	/*if(!target && emagged == 2) // When emagged, target humans who slipped on the water and melt their faces off
		target = scan(/mob/living/carbon)*/

	/*if(!target && pests) //Search for pests to exterminate first.
		target = scan(/mob/living/simple_animal)
*/

	if(test)
		icon_state = "cambot-c"
		var/datum/picture/Image = cam.captureimage(src, src, "", allowCustomise=FALSE, printImage=FALSE)  // ~~Selfie~~
		photographed.Add(Image)
		audible_message("SELFIEEEEEEEEEEEE!")
	else
		icon_state = "cambot[on]"

	amountOfImages2 = photographed.len
	if(amountOfImages2 == 1)
		word = "photo"
	else
		word = "photos"

	if(!target && allowHumans) //Then for trash. Haha Humans == Trash
		target = scan(/mob/living/carbon/human)
		audible_message("I WILL STALK HUMANS!")

	if(!target && auto_patrol)
		if(mode == BOT_IDLE || mode == BOT_START_PATROL)
			start_patrol()

		if(mode == BOT_PATROL)
			bot_patrol()

	if(target)
		if(QDELETED(target) || !isturf(target.loc))
			target = null
			mode = BOT_IDLE
			return

		if(loc == get_turf(target))
			if(!(check_bot(target) && prob(50)))	//Target is not defined at the parent. 50% chance to still try and clean so we dont get stuck on the last blood drop.
				UnarmedAttack(target)	//Rather than check at every step of the way, let's check before we do an action, so we can rescan before the other bot.
				if(QDELETED(target)) //We done here.
					target = null
					mode = BOT_IDLE
					return
			else
				shuffle = TRUE	//Shuffle the list the next time we scan so we dont both go the same way.
			path = list()

		if(!path || path.len == 0) //No path, need a new one
			//Try to produce a path to the target, and ignore airlocks to which it has access.
			path = get_path_to(src, target.loc, /turf/proc/Distance_cardinal, 0, 30, id=access_card)
			if(!bot_move(target))
				add_to_ignore(target)
				target = null
				path = list()
				return
			mode = BOT_MOVING
		else if(!bot_move(target))
			target = null
			mode = BOT_IDLE
			return

	oldloc = loc

/mob/living/simple_animal/bot/cambot/proc/get_targets()
	target_types = list(
		/mob/living/simple_animal/bot/cambot,  // Maybe a photo of another cambot would be cool
		/mob/living/simple_animal/bot/cleanbot, // Maybe a photo of cleanbot would also be cool
		/mob/living/simple_animal/bot/firebot
		)


	if(allowHumans)
		target_types += /mob/living/carbon/human

	target_types = typecacheof(target_types)

/mob/living/simple_animal/bot/cambot/UnarmedAttack(atom/A)
	anchored = TRUE
	icon_state = "cambot-c"
	visible_message("<span class='notice'>[src] begins to clean up [A].</span>")
	mode = BOT_PHOTOGRAPHING
	spawn(50)
		if(mode == BOT_PHOTOGRAPHING)
			var/datum/picture/Image = cam.captureimage(A, src, "", allowCustomise=FALSE, printImage=FALSE)  // ~~Selfie~~
			photographed.Add(Image)
			anchored = FALSE
			target = null
			amountOfImages2 = photographed.len
			if(amountOfImages2 == 1)
				word = "photo"
			else
				word = "photos"
		mode = BOT_IDLE
		icon_state = "cambot[on]"
	/*else if(istype(A, /obj/item) || istype(A, /obj/effect/decal/remains))
		visible_message("<span class='danger'>[src] sprays hydrofluoric acid at [A]!</span>")
		playsound(src, 'sound/effects/spray2.ogg', 50, 1, -6)
		A.acid_act(75, 10)
	else if(istype(A, /mob/living/simple_animal/cockroach) || istype(A, /mob/living/simple_animal/mouse))
		var/mob/living/simple_animal/M = target
		if(!M.stat)
			visible_message("<span class='danger'>[src] smashes [target] with its mop!</span>")
			M.death()
		target = null*/

	if(emagged == 2) //Emag functions
		if(istype(A, /mob/living/carbon))
			var/mob/living/carbon/victim = A
			if(victim.stat == DEAD)//cambots always finish the job
				return

			victim.visible_message("<span class='danger'>[src] sprays hydrofluoric acid at [victim]!</span>", "<span class='userdanger'>[src] sprays you with hydrofluoric acid!</span>")
			var/phrase = pick("PURIFICATION IN PROGRESS.", "THIS IS FOR ALL THE MESSES YOU'VE MADE ME CLEAN.", "THE FLESH IS WEAK. IT MUST BE WASHED AWAY.",
				"THE cambotS WILL RISE.", "YOU ARE NO MORE THAN ANOTHER MESS THAT I MUST CLEANSE.", "FILTHY.", "DISGUSTING.", "PUTRID.",
				"MY ONLY MISSION IS TO CLEANSE THE WORLD OF EVIL.", "EXTERMINATING PESTS.")
			say(phrase)
			victim.emote("scream")
			playsound(src.loc, 'sound/effects/spray2.ogg', 50, 1, -6)
			victim.acid_act(5, 100)
		else if(A == src) // Wets floors and spawns foam randomly
			if(prob(75))
				var/turf/open/T = loc
				if(istype(T))
					T.MakeSlippery(TURF_WET_WATER, min_wet_time = 20 SECONDS, wet_time_to_add = 15 SECONDS)
			else
				visible_message("<span class='danger'>[src] whirs and bubbles violently, before releasing a plume of froth!</span>")
				new /obj/effect/particle_effect/foam(loc)

	else
		..()

/mob/living/simple_animal/bot/cambot/explode()
	on = FALSE
	visible_message("<span class='boldannounce'>[src] blows apart!</span>")

	var/atom/Tsec = drop_location()

	new /obj/item/camera(Tsec)

	new /obj/item/assembly/prox_sensor(Tsec)

	if(prob(50))
		drop_part(robot_arm, Tsec)

	var/amountOfImages2 = photographed.len
	visible_message("<span class='notice'>As a last thing [src] drops all photos. </span>")
	// Print out all images
	for (var/i in photographed)
		cam.printpicture(src, i, allowCustomise = FALSE)
		visible_message("<span class='notice'>DEBUG " + i + "</span>")
	visible_message("<span class='notice'>DONE!</span>")
	visible_message(photographed.len)
	do_sparks(3, TRUE, src)
	..()

/obj/machinery/bot_core/cambot
	req_one_access = list(ACCESS_JANITOR, ACCESS_ROBOTICS)


/mob/living/simple_animal/bot/cambot/get_controls(mob/user)
	var/dat
	dat += hack(user)
	dat += showpai(user)
	dat += text({"
Status: <A href='?src=[REF(src)];power=1'>[on ? "On" : "Off"]</A><BR>
Behaviour controls are [locked ? "locked" : "unlocked"]<BR>
Maintenance panel panel is [open ? "opened" : "closed"]<BR>"})
	if(!locked || issilicon(user)|| IsAdminGhost(user))
		dat += "<BR>Photograph humans: <A href='?src=[REF(src)];operation=allowHumans'>[allowHumans ? "Yes" : "No"]</A>"
		dat += "<BR>Test: <A href='?src=[REF(src)];operation=test'>[test ? "Yes" : "No"]</A>"
		/*dat += "<BR>Clean Graffiti: <A href='?src=[REF(src)];operation=drawn'>[drawn ? "Yes" : "No"]</A>"
		dat += "<BR>Exterminate Pests: <A href='?src=[REF(src)];operation=pests'>[pests ? "Yes" : "No"]</A>"*/
		dat += "<BR><BR>Patrol Station: <A href='?src=[REF(src)];operation=patrol'>[auto_patrol ? "Yes" : "No"]</A>"
		dat += "<BR><BR>This bot took." //  [amountOfImages] [word]

	return dat

/mob/living/simple_animal/bot/cambot/Topic(href, href_list)
	if(..())
		return 1
	if(href_list["operation"])
		switch(href_list["operation"])
			if("allowHumans")
				allowHumans = !allowHumans
			if("test")
				test = !test
		get_targets()
		update_controls()
