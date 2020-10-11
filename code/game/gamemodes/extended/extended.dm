/datum/game_mode/extended
	name = "extended"
	config_tag = "extended"
	report_type = "extended"
	false_report_weight = 0
	required_players = 0

	announce_span = "notice"
	announce_text = "Habe spaß!"

	title_icon = "extended_white"

	var/secret = FALSE

/datum/game_mode/extended/secret
	name = "secret extended"
	config_tag ="secret_extended"
	report_type = "traitor"	//So this won't appear with traitor report
	secret = TRUE

/datum/game_mode/extended/pre_setup()
	return 1

/datum/game_mode/extended/generate_report()
	return "The transmission mostly failed to mention your sector. It is possible that there is nothing in the Syndicate that could threaten your station during this shift."

/datum/game_mode/extended/generate_station_goals()
	if(secret)
		return ..()
	for(var/T in subtypesof(/datum/station_goal))
		var/datum/station_goal/G = new T
		station_goals += G
		G.on_report()

/datum/game_mode/extended/send_intercept(report = 0)
	if(secret)
		return ..()
	priority_announce("Dank der unermüdlichen Bemühungen unserer Sicherheits- und Geheimdienstabteilungen gibt es derzeit keine glaubwürdigen Bedrohungen für [station_name()]. Alle Stationsbauvorhaben sind genehmigt worden. Ich wünsche Ihnen eine sichere Schicht!", "Sicherheitsbericht", 'sound/ai/commandreport.ogg')
