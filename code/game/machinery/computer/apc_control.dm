/obj/machinery/computer/apc_control
	name = "power flow control console"
	desc = "Wird zur Fernsteuerung des Stromflusses zu verschiedenen Teilen der Station verwendet."
	icon_screen = "solar"
	icon_keyboard = "power_key"
	req_access = list(ACCESS_ENGINE)
	circuit = /obj/item/circuitboard/computer/apc_control
	light_color = LIGHT_COLOR_YELLOW
	var/mob/living/operator //Who's operating the computer right now
	var/obj/machinery/power/apc/active_apc //The APC we're using right now
	var/list/result_filters //For sorting the results
	var/checking_logs = 0
	var/list/logs
	var/authenticated = 0
	var/auth_id = "\[NULL\]"

/obj/machinery/computer/apc_control/Initialize()
	. = ..()
	result_filters = list("Name" = null, "Charge Above" = null, "Charge Below" = null, "Responsive" = null)

/obj/machinery/computer/apc_control/process()
	if(operator && (!operator.Adjacent(src) || stat))
		operator = null
		if(active_apc)
			if(!active_apc.locked)
				active_apc.say("Fernzugriff abgebrochen. Schnittstelle gesperrt.")
				playsound(active_apc, 'sound/machines/boltsdown.ogg', 25, 0)
				playsound(active_apc, 'sound/machines/terminal_alert.ogg', 50, 0)
			active_apc.locked = TRUE
			active_apc.update_icon()
			active_apc.remote_control = null
			active_apc = null

/obj/machinery/computer/apc_control/attack_ai(mob/user)
	if(!IsAdminGhost(user))
		to_chat(user,"<span class='warning'>[src] unterstützt keine AI-Steuerung.</span>") //You already have APC access, cheater!
		return
	..(user)

/obj/machinery/computer/apc_control/proc/check_apc(obj/machinery/power/apc/APC)
	return APC.z == z && !APC.malfhack && !APC.aidisabled && !(APC.obj_flags & EMAGGED) && !APC.stat && !istype(APC.area, /area/ai_monitored) && !APC.area.outdoors

/obj/machinery/computer/apc_control/ui_interact(mob/living/user)
	. = ..()
	var/dat
	if(authenticated)
		if(!checking_logs)
			dat += "Angemeldet als [auth_id].<br><br>"
			dat += "<i>Filter</i><br>"
			dat += "<b>Name:</b> <a href='?src=[REF(src)];name_filter=1'>[result_filters["Name"] ? result_filters["Name"] : "Nicht gesetzt"]</a><br>"
			dat += "<b>Ladung:</b> <a href='?src=[REF(src)];above_filter=1'>\>[result_filters["Ladung über"] ? result_filters["Ladung über"] : "NaN"]%</a> and <a href='?src=[REF(src)];below_filter=1'>\<[result_filters["Ladung unter"] ? result_filters["Ladung unter"] : "NaN"]%</a><br>"
			dat += "<b>Erreichbarkeit:</b> <a href='?src=[REF(src)];access_filter=1'>[result_filters["Responsive"] ? "Nur Nicht-Reaktionsfähige" : "Alle"]</a><br><br>"
			for(var/A in GLOB.apcs_list)
				if(check_apc(A))
					var/obj/machinery/power/apc/APC = A
					if(result_filters["Name"] && !findtext(APC.name, result_filters["Name"]) && !findtext(APC.area.name, result_filters["Name"]))
						continue
					if(result_filters["Ladung über"] && (!APC.cell || (APC.cell && (APC.cell.charge / APC.cell.maxcharge) < result_filters["Ladung über"] / 100)))
						continue
					if(result_filters["Ladung unter"] && APC.cell && (APC.cell.charge / APC.cell.maxcharge) > result_filters["adung unter"] / 100)
						continue
					if(result_filters["Responsive"] && !APC.aidisabled)
						continue
					dat += "<a href='?src=[REF(src)];access_apc=[REF(APC)]'>[A]</a><br>\
					<b>Ladung:</b> [APC.cell ? "[DisplayEnergy(APC.cell.charge)] / [DisplayEnergy(APC.cell.maxcharge)] ([round((APC.cell.charge / APC.cell.maxcharge) * 100)]%)" : "Keine Leistungszelle installiert"]<br>\
					<b>Bereich:</b> [APC.area]<br>\
					[APC.aidisabled || APC.panel_open ? "<font color='#FF0000'>APC antwortet nicht auf die Schnittstellenabfrage.</font>" : "<font color='#00FF00'>APC antwortet auf Schnittstellenanfrage.</font>"]<br><br>"
			dat += "<a href='?src=[REF(src)];check_logs=1'>Logs öffnen</a><br>"
			dat += "<a href='?src=[REF(src)];log_out=1'>Abmelden</a><br>"
			if(obj_flags & EMAGGED)
				dat += "<font color='#FF0000'>WARNUNG: Protokollierungsfunktionalität von außen teilweise deaktiviert.</font><br>"
				dat += "<a href='?src=[REF(src)];restore_logging=1'>Logging-Funktionalität wiederherstellen?</a><br>"
		else
			if(logs.len)
				for(var/entry in logs)
					dat += "[entry]<br>"
			else
				dat += "<i>Bislang wurde keine Aktivität verzeichnet.</i><br>"
			if(obj_flags & EMAGGED)
				dat += "<a href='?src=[REF(src)];clear_logs=1'><font color='#FF0000'>@#%! LOGS LÖSCHEN</a>"
			dat += "<a href='?src=[REF(src)];check_apcs=1'>Zurück</a>"
		operator = user
	else
		dat = "<a href='?src=[REF(src)];authenticate=1'>Bitte einen gültigen Ausweis lesen.</a>"
	var/datum/browser/popup = new(user, "apc_control", name, 600, 400)
	popup.set_content(dat)
	popup.open()

/obj/machinery/computer/apc_control/Topic(href, href_list)
	if(..())
		return
	if(!usr || !usr.canUseTopic(src, !issilicon(usr)) || stat || QDELETED(src))
		return
	if(href_list["authenticate"])
		var/obj/item/card/id/ID = usr.get_idcard(TRUE)
		if(ID && istype(ID))
			if(check_access(ID))
				authenticated = TRUE
				auth_id = "[ID.registered_name] ([ID.assignment])"
				log_activity("logged in")
	if(href_list["log_out"])
		log_activity("logged out")
		authenticated = FALSE
		auth_id = "\[NULL\]"
	if(href_list["restore_logging"])
		to_chat(usr, "<span class='robot notice'>[icon2html(src, usr)] Protokollierungsfunktionalität aus Sicherungsdaten wiederhergestellt.</span>")
		obj_flags &= ~EMAGGED
		LAZYADD(logs, "<b>-=- Logging restored to full functionality at this point -=-</b>")
	if(href_list["access_apc"])
		playsound(src, "terminal_type", 50, 0)
		var/obj/machinery/power/apc/APC = locate(href_list["access_apc"]) in GLOB.apcs_list
		if(!APC || APC.aidisabled || APC.panel_open || QDELETED(APC))
			to_chat(usr, "<span class='robot danger'>[icon2html(src, usr)] APC gibt keine Schnittstellenanforderung zurück. Der Fernzugriff kann deaktiviert werden.</span>")
			return
		if(active_apc)
			to_chat(usr, "<span class='robot danger'>[icon2html(src, usr)] Getrennt von [active_apc].</span>")
			active_apc.say("Remote access canceled. Interface locked.")
			playsound(active_apc, 'sound/machines/boltsdown.ogg', 25, 0)
			playsound(active_apc, 'sound/machines/terminal_alert.ogg', 50, 0)
			active_apc.locked = TRUE
			active_apc.update_icon()
			active_apc.remote_control = null
			active_apc = null
		to_chat(usr, "<span class='robot notice'>[icon2html(src, usr)] Verbunden mit APC in [get_area_name(APC.area, TRUE)]. Schnittstellenanforderung gesendet.</span>")
		log_activity("remotely accessed APC in [get_area_name(APC.area, TRUE)]")
		APC.remote_control = src
		APC.ui_interact(usr)
		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, 0)
		message_admins("[ADMIN_LOOKUPFLW(usr)] remotely accessed [APC] from [src] at [AREACOORD(src)].")
		log_game("[key_name(usr)] remotely accessed [APC] from [src] at [AREACOORD(src)].")
		if(APC.locked)
			APC.say("Fernzugriff erkannt. Schnittstelle entsperrt.")
			playsound(APC, 'sound/machines/boltsup.ogg', 25, 0)
			playsound(APC, 'sound/machines/terminal_alert.ogg', 50, 0)
		APC.locked = FALSE
		APC.update_icon()
		active_apc = APC
	if(href_list["name_filter"])
		playsound(src, 'sound/machines/terminal_prompt.ogg', 50, 0)
		var/new_filter = stripped_input(usr, "What name are you looking for?", name)
		if(!src || !usr || !usr.canUseTopic(src, !issilicon(usr)) || stat || QDELETED(src))
			return
		log_activity("changed name filter to \"[new_filter]\"")
		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, 0)
		result_filters["Name"] = new_filter
	if(href_list["above_filter"])
		playsound(src, 'sound/machines/terminal_prompt.ogg', 50, 0)
		var/new_filter = input(usr, "Geben Sie einen Prozentwert von 1-100 ein, nach dem sortiert werden soll (größer als).", name) as null|num
		if(!src || !usr || !usr.canUseTopic(src, !issilicon(usr)) || stat || QDELETED(src))
			return
		log_activity("changed greater than charge filter to \"[new_filter]\"")
		if(new_filter)
			new_filter = CLAMP(new_filter, 0, 100)
		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, 0)
		result_filters["Charge Above"] = new_filter
	if(href_list["below_filter"])
		playsound(src, 'sound/machines/terminal_prompt.ogg', 50, 0)
		var/new_filter = input(usr, "Geben Sie einen Prozentwert von 1-100 ein, nach dem sortiert werden soll (kleiner als).", name) as null|num
		if(!src || !usr || !usr.canUseTopic(src, !issilicon(usr)) || stat || QDELETED(src))
			return
		log_activity("changed lesser than charge filter to \"[new_filter]\"")
		if(new_filter)
			new_filter = CLAMP(new_filter, 0, 100)
		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, 0)
		result_filters["Charge Below"] = new_filter
	if(href_list["access_filter"])
		if(isnull(result_filters["Responsive"]))
			result_filters["Responsive"] = 1
			log_activity("sorted by non-responsive APCs only")
		else
			result_filters["Responsive"] = !result_filters["Responsive"]
			log_activity("sorted by all APCs")
		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, 0)
	if(href_list["check_logs"])
		checking_logs = TRUE
		log_activity("checked logs")
	if(href_list["check_apcs"])
		checking_logs = FALSE
		log_activity("checked APCs")
	if(href_list["clear_logs"])
		logs = list()
	ui_interact(usr) //Refresh the UI after a filter changes

/obj/machinery/computer/apc_control/emag_act(mob/user)
	if(!authenticated)
		to_chat(user, "<span class='warning'>Sie umgehen die Zugriffsanforderungen von [src] mit Ihrem emag.</span>")
		authenticated = TRUE
		log_activity("logged in")
	else if(!(obj_flags & EMAGGED))
		user.visible_message("<span class='warning'>Sie emagieren [src], wodurch die präzise Protokollierung deaktiviert wird und Sie Protokolle löschen können.</span>")
		log_game("[key_name(user)] emagged [src] at [AREACOORD(src)], disabling operator tracking.")
		obj_flags |= EMAGGED
	playsound(src, "sparks", 50, 1)

/obj/machinery/computer/apc_control/proc/log_activity(log_text)
	var/op_string = operator && !(obj_flags & EMAGGED) ? operator : "\[NULL OPERATOR\]"
	LAZYADD(logs, "<b>([station_time_timestamp()])</b> [op_string] [log_text]")

/mob/proc/using_power_flow_console()
	for(var/obj/machinery/computer/apc_control/A in range(1, src))
		if(A.operator && A.operator == src && !A.stat)
			return TRUE
	return
