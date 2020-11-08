/mob/living/carbon/examine(mob/user)
	var/t_He = p_they(TRUE)
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()

	. = list("<span class='info'>*---------*\nDas ist [icon2html(src, user)] \a <EM>[src]</EM>!")
	var/list/obscured = check_obscured_slots()

	if (handcuffed)
		. += "<span class='warning'>[t_He] [t_is] [icon2html(handcuffed, user)] handcuffed!</span>"
	if (head)
		. += "[t_He] [t_is] trägt [head.get_examine_string(user)] auf [t_his] Kopf. "
	if(wear_mask && !(SLOT_WEAR_MASK in obscured))
		. += "[t_He] [t_is] trägt [wear_mask.get_examine_string(user)] in [t_his] Gesicht."
	if(wear_neck && !(SLOT_NECK in obscured))
		. += "[t_He] [t_is] trägt [wear_neck.get_examine_string(user)] um [t_his] Hals."

	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT))
			. += "[t_He] [t_is] hält [I.get_examine_string(user)] in [t_his] [get_held_index_name(get_held_index_of_item(I))]."

	if (back)
		. += "[t_He] [t_has] [back.get_examine_string(user)] auf [t_his] Rücken."
	var/appears_dead = 0
	if (stat == DEAD)
		appears_dead = 1
		if(getorgan(/obj/item/organ/brain))
			. += "<span class='deadsay'>[t_He] [t_is] schlaff und nicht ansprechbar, ohne Lebenszeichen.</span>"
		else if(get_bodypart(BODY_ZONE_HEAD))
			. += "<span class='deadsay'>Es sieht so aus als würde [t_his] Gehirn fehlen...</span>"


	var/list/missing = get_missing_limbs()
	for(var/t in missing)
		if(t==BODY_ZONE_HEAD)
			. += "<span class='deadsay'><B>[t_His] [parse_zone(t)] fehlt!</B></span>"
			continue
		. += "<span class='warning'><B>[t_His] [parse_zone(t)] fehlt!</B></span>"

	var/list/msg = list("<span class='warning'>")
	var/temp = getBruteLoss()
	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if (temp < 25)
				msg += "[t_He] [t_has] kleinere Blutergüsse.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> Blutergüsse!\n"
			else
				msg += "<B>[t_He] [t_has] schwere Blutergüsse!</B>\n"

		temp = getFireLoss()
		if(temp)
			if (temp < 25)
				msg += "[t_He] [t_has] kleinere Verbrennungen.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> Verbrennungen!\n"
			else
				msg += "<B>[t_He] [t_has] schwere Verbrennungen!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_is] slightly deformiert.\n"
			else if (temp < 50)
				msg += "[t_He] [t_is] <b>moderate</b> deformiert!\n"
			else
				msg += "<b>[t_He] [t_is] stark deformiert!</b>\n"

	if(HAS_TRAIT(src, TRAIT_DUMB))
		msg += "[t_He] scheint ungeschickt und unfähig zu denken.\n"

	if(fire_stacks > 0)
		msg += "[t_He] [t_is] covered in something flammable.\n"
	if(fire_stacks < 0)
		msg += "[t_He] look[p_s()] a little soaked.\n"

	if(pulledby?.grab_state)
		msg += "[t_He] [t_is] restrained by [pulledby]'s grip.\n"

	msg += "</span>"

	. += msg.Join("")

	if(!appears_dead)
		if(stat == UNCONSCIOUS)
			. += "[t_He] [t_is]n't responding to anything around [t_him] and seems to be asleep."
		else if(InCritical())
			. += "[t_His] Atmung ist flach und schwerfällig."

		if(digitalcamo)
			. += "[t_He] [t_is] moving [t_his] body in an unnatural and blatantly unsimian manner."

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam

	var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
	if(mood)
		switch(mood.shown_mood)
			if(-INFINITY to MOOD_LEVEL_SAD4)
				. += "[t_He] sieht depressiv aus."
			if(MOOD_LEVEL_SAD4 to MOOD_LEVEL_SAD3)
				. += "[t_He] sieht sehr traurig aus."
			if(MOOD_LEVEL_SAD3 to MOOD_LEVEL_SAD2)
				. += "[t_He] sieht ein wenig down au."
			if(MOOD_LEVEL_HAPPY2 to MOOD_LEVEL_HAPPY3)
				. += "[t_He] sieht relativ fröhlich aus."
			if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
				. += "[t_He] look[p_s()] very happy."
			if(MOOD_LEVEL_HAPPY4 to INFINITY)
				. += "[t_He] look[p_s()] ecstatic."
	. += "*---------*</span>"
