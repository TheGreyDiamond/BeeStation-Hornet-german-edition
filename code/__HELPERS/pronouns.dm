//pronoun procs, for getting pronouns without using the text macros that only work in certain positions
//datums don't have gender, but most of their subtypes do!
/datum/proc/p_they(capitalized, temp_gender)
	. = "it"
	if(capitalized)
		. = capitalize(.)

/datum/proc/p_their(capitalized, temp_gender)
	. = "its"
	if(capitalized)
		. = capitalize(.)

/datum/proc/p_them(capitalized, temp_gender)
	. = "it"
	if(capitalized)
		. = capitalize(.)

/datum/proc/p_have(temp_gender)
	. = "hat"

/datum/proc/p_are(temp_gender)
	. = "ist"

/datum/proc/p_were(temp_gender)
	. = "war"

/datum/proc/p_do(temp_gender)
	. = "tut"

/datum/proc/p_theyve(capitalized, temp_gender)
	. = p_they(capitalized, temp_gender) + "'" + copytext_char(p_have(temp_gender), 3)

/datum/proc/p_theyre(capitalized, temp_gender)
	. = p_they(capitalized, temp_gender) + "'" + copytext_char(p_are(temp_gender), 2)

/datum/proc/p_s(temp_gender) //is this a descriptive proc name, or what?
	. = "s"

/datum/proc/p_es(temp_gender)
	. = "es"

//like clients, which do have gender.
/client/p_they(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "sie"
	switch(temp_gender)
		if(FEMALE)
			. = "sie"
		if(MALE)
			. = "er"
	if(capitalized)
		. = capitalize(.)

/client/p_their(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "ihre"
	switch(temp_gender)
		if(FEMALE)
			. = "ihre"
		if(MALE)
			. = "seine"
	if(capitalized)
		. = capitalize(.)

/client/p_them(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "sie"
	switch(temp_gender)
		if(FEMALE)
			. = "ihre"
		if(MALE)
			. = "seine"
	if(capitalized)
		. = capitalize(.)

/client/p_have(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "hat"
	if(temp_gender == PLURAL || temp_gender == NEUTER)
		. = "haben"

/client/p_are(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "ist"
	if(temp_gender == PLURAL || temp_gender == NEUTER)
		. = "sind"

/client/p_were(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "war"
	if(temp_gender == PLURAL || temp_gender == NEUTER)
		. = "waren"

/client/p_do(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "tut"
	if(temp_gender == PLURAL || temp_gender == NEUTER)
		. = "tun"

/client/p_s(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	if(temp_gender != PLURAL && temp_gender != NEUTER)
		. = "s"

/client/p_es(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	if(temp_gender != PLURAL && temp_gender != NEUTER)
		. = "es"

//mobs(and atoms but atoms don't really matter write your own proc overrides) also have gender!
/mob/p_they(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "it"
	switch(temp_gender)
		if(FEMALE)
			. = "er"
		if(MALE)
			. = "sie"
		if(PLURAL)
			. = "sie"
	if(capitalized)
		. = capitalize(.)

/mob/p_their(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "its"
	switch(temp_gender)
		if(FEMALE)
			. = "ihre"
		if(MALE)
			. = "seine"
		if(PLURAL)
			. = "their"
	if(capitalized)
		. = capitalize(.)

/mob/p_them(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "it"
	switch(temp_gender)
		if(FEMALE)
			. = "her"
		if(MALE)
			. = "him"
		if(PLURAL)
			. = "them"
	if(capitalized)
		. = capitalize(.)

/mob/p_have(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "hatt"
	if(temp_gender == PLURAL)
		. = "haben"

/mob/p_are(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "ist"
	if(temp_gender == PLURAL)
		. = "sind"

/mob/p_were(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "war"
	if(temp_gender == PLURAL)
		. = "waren"

/mob/p_do(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "does"
	if(temp_gender == PLURAL)
		. = "do"

/mob/p_s(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	if(temp_gender != PLURAL)
		. = "s"

/mob/p_es(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	if(temp_gender != PLURAL)
		. = "es"

//humans need special handling, because they can have their gender hidden
/mob/living/carbon/human/p_they(capitalized, temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/p_their(capitalized, temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/p_them(capitalized, temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/p_have(temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/p_are(temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/p_were(temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/p_do(temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/p_s(temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/p_es(temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()
