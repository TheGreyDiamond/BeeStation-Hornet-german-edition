/datum/controller/subsystem/ticker/proc/give_crew_objective(var/datum/mind/crewMind)
	if(CONFIG_GET(flag/allow_crew_objectives) && crewMind?.current?.client.prefs.crew_objectives)
		generate_individual_objectives(crewMind)
	return

/datum/controller/subsystem/ticker/proc/generate_individual_objectives(var/datum/mind/crewMind)
	if(!(CONFIG_GET(flag/allow_crew_objectives)))
		return
	if(!crewMind)
		return
	if(!crewMind.current || crewMind.special_role)
		return
	if(!crewMind.assigned_role)
		return
	var/list/validobjs = crewobjjobs["[ckey(crewMind.assigned_role)]"]
	if(!validobjs || !validobjs.len)
		return
	var/selectedObj = pick(validobjs)
	var/datum/objective/crew/newObjective = new selectedObj
	if(!newObjective)
		return
	newObjective.owner = crewMind
	crewMind.crew_objectives += newObjective
	to_chat(crewMind, "<B>Als Teil von Nanotrasen's Anti-tide-Bemühungen wurde dir ein optionales Ziel zugewiesen. Es wird am Ende der Schicht überprüft. <span class='warning'>Das Ausführen verräterischer Handlungen zur Verfolgung deines Ziels kann zur Beendigung deines Arbeitsverhältnisses führen.</span></B>")
	to_chat(crewMind, "<B>Dein Ziel:</B> [newObjective.explanation_text]")
	crewMind.memory += "<br><B>Your Optional Objective:Euer optionales Ziel:</B> [newObjective.explanation_text]"

/datum/objective/crew
	var/jobs = ""
	explanation_text = "Schrei die Leute auf Github an, wenn das jemals auftaucht. Irgendwas mit den Zielen der Crew ist kaputt."
