/obj/machinery/computer/warrant//TODO:SANITY
	name = "security warrant console"
	desc = "Wird verwendet, um die Sicherheitsaufzeichnungen von Besatzungsmitgliedern einzusehen"
	icon_screen = "security"
	icon_keyboard = "security_key"
	circuit = /obj/item/circuitboard/computer/warrant
	light_color = LIGHT_COLOR_RED
	var/authenticated = null
	var/screen = null
	var/datum/data/record/current = null

/obj/machinery/computer/warrant/ui_interact(mob/user)
	. = ..()

	var/list/dat = list("Angemeldet als: ")
	if(authenticated)
		dat += {"<a href='?src=[REF(src)];choice=Logout'>[authenticated]</a><hr>"}
		if(current)
			var/background
			var/notice = ""
			switch(current.fields["criminal"])
				if("*Arrest*")
					background = "background-color:#990000;"
					notice = "<br>**MELDUNG AN DIE BRIGG**"
				if("Incarcerated")
					background = "background-color:#CD6500;"
				if("Paroled")
					background = "background-color:#CD6500;"
				if("Discharged")
					background = "background-color:#006699;"
				if("None")
					background = "background-color:#4F7529;"
				if("")
					background = "''" //"'background-color:#FFFFFF;'"
			dat += "<font size='4'><b>Warrant Data</b></font>"
			dat += {"<table>
			<tr><td>Name:</td><td>&nbsp;[current.fields["name"]]&nbsp;</td></tr>
			<tr><td>ID:</td><td>&nbsp;[current.fields["id"]]&nbsp;</td></tr>
			</table>"}
			dat += {"Strafrechtlicher Status:<br>
			<div style='[background] padding: 3px; text-align: center;'>
			<strong>[current.fields["criminal"]][notice]</strong>
			</div>"}

			dat += "<br><br>Zitate:"

			dat +={"<table style="text-align:center;" border="1" cellspacing="0" width="100%">
			<tr>
			<th>Verbrechen</th>
			<th>Strafe</th>
			<th>Author</th>
			<th>Zeit hinzugefügt</th>
			<th>Fälliger Betrag</th>
			<th>Zahlung vornehmen</th>
			</tr>"}
			for(var/datum/data/crime/c in current.fields["citation"])
				var/owed = c.fine - c.paid
				dat += {"<tr><td>[c.crimeName]</td>
				<td>$[c.fine]</td>
				<td>[c.author]</td>
				<td>[c.time]</td>"}
				if(owed > 0)
					dat += {"<td>$[owed]</td>
					<td><A href='?src=[REF(src)];choice=Pay;field=citation_pay;cdataid=[c.dataId]'>\[Pay\]</A></td>"}
				else
					dat += "<td colspan='2'>Alle bezahlt</td>"
				dat += "</tr>"
			dat += "</table>"

			dat += "<br>Kleinere Straftaten:"

			dat +={"<table style="text-align:center;" border="1" cellspacing="0" width="100%">
			<tr>
			<th>Verbechen</th>
			<th>Details</th>
			<th>Author</th>
			<th>Zeit hinzugefügt</th>
			</tr>"}
			for(var/datum/data/crime/c in current.fields["mi_crim"])
				dat += {"<tr><td>[c.crimeName]</td>
				<td>[c.crimeDetails]</td>
				<td>[c.author]</td>
				<td>[c.time]</td>
				</tr>"}
			dat += "</table>"

			dat += "<br>Schwere Straftaten:"
			dat +={"<table style="text-align:center;" border="1" cellspacing="0" width="100%">
			<tr>
			<th>Verbrechen</th>
			<th>Details</th>
			<th>Author</th>
			<th>Zeit hinzugefügt</th>
			</tr>"}
			for(var/datum/data/crime/c in current.fields["ma_crim"])
				dat += {"<tr><td>[c.crimeName]</td>
				<td>[c.crimeDetails]</td>
				<td>[c.author]</td>
				<td>[c.time]</td>
				</tr>"}
			dat += "</table>"
		else
			dat += {"<span>** Kein Sicherheitseintrag für diese ID gefunden **</span>"}
	else
		dat += {"<a href='?src=[REF(src)];choice=Login'>------------</a><hr>"}

	var/datum/browser/popup = new(user, "warrant", "Security Warrant Console", 600, 400)
	popup.set_content(dat.Join())
	popup.open()

/obj/machinery/computer/warrant/Topic(href, href_list)
	if(..())
		return
	var/mob/M = usr
	switch(href_list["choice"])
		if("Login")
			var/obj/item/card/id/scan = M.get_idcard(TRUE)
			authenticated = scan.registered_name
			if(authenticated)
				for(var/datum/data/record/R in GLOB.data_core.security)
					if(R.fields["name"] == authenticated)
						current = R
				playsound(src, 'sound/machines/terminal_on.ogg', 50, 0)
		if("Logout")
			current = null
			authenticated = null
			playsound(src, 'sound/machines/terminal_off.ogg', 50, 0)

		if("Pay")
			for(var/datum/data/crime/p in current.fields["citation"])
				if(p.dataId == text2num(href_list["cdataid"]))
					var/obj/item/holochip/C = M.is_holding_item_of_type(/obj/item/holochip)
					if(C && istype(C))
						var/pay = C.get_item_credit_value()
						if(!pay)
							to_chat(M, "<span class='warning'>[C] scheint nichts wert zu sein!</span>")
						else
							var/diff = p.fine - p.paid
							GLOB.data_core.payCitation(current.fields["id"], text2num(href_list["cdataid"]), pay)
							to_chat(M, "<span class='notice'>Sie haben [pay] Credits auf Ihre Geldstrafe bezahlt</span>")
							if (pay == diff || pay > diff || pay >= diff)
								investigate_log("Citation Paid off: <strong>[p.crimeName]</strong> Fine: [p.fine] | Paid off by [key_name(usr)]", INVESTIGATE_RECORDS)
								to_chat(M, "<span class='notice'>Das Bußgeld ist vollständig bezahlt worden</span>")
							qdel(C)
							playsound(src, "terminal_type", 25, 0)
					else
						to_chat(M, "<span class='warning'>Geldstrafen können nur mit Holochips bezahlt werden</span>")

	updateUsrDialog()
	add_fingerprint(M)
