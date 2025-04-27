extends Node2D

@onready var name_label = get_node("DialogBox/Name")
@onready var dialog_label = get_node("DialogBox/Dialog")
var BackgroundLaboratoryEntrance = preload("res://Image/Background/Entrée laboratoire.png")
var BackgroundLaboratoryRoom = preload("res://Image/Background/Salle du laboratoire.png")
var BackgroundOfficeDirector = preload("res://Image/Background/Bureau du directeur.png")
var BackgroundLaboratoryWarehouse = preload("res://Image/Background/Entrepôt laboratoire.png")
var CharacterAF = preload("res://Image/Character/Amie H.png")
var CharacterCL = preload("res://Image/Character/Méchant.png")
var CharacterHS = preload("res://Image/Character/Perso secondaire.png")
var numberOfSentence = 0
var is_typing = false  # Empêche d'afficher une nouvelle phrase avant la fin de l'affichage de la précédente
var current_text = ""  # Stocke le texte complet pour le montrer instantanément si l'utilisateur clique
var searchMode = false
var LaboratoryRoomLocation1 = false
var LaboratoryRoomLocation2 = false
var LaboratoryRoomLocation3 = false

func _ready():
	await get_tree().create_timer(1).timeout

func _process(delta):
	if numberOfSentence == 0:
		fadeInImage(delta,"Background",0.3)
		if get_node("Background").modulate.a == 1.0:
			get_node("DialogBox").show()
			display_sentence()
	if numberOfSentence == 4:
		fadeOutImage(delta,"Background",0.5)
	if numberOfSentence == 6:
		get_node("Background").texture = BackgroundLaboratoryEntrance
		get_node("Background").scale.x = 1.57
		get_node("Background").scale.y = 1.2
		fadeInImage(delta,"Background",1.0)
	if numberOfSentence == 8:
		get_node("Background").texture = BackgroundLaboratoryRoom
		get_node("Background").scale.x = 1.57
		get_node("Background").scale.y = 1.2
	if numberOfSentence == 9:
		if is_typing == false and searchMode == false:
			get_node("DialogBox").hide()
			searchMode = true
			print("searchMode: ", searchMode)
	if LaboratoryRoomLocation1 == true and LaboratoryRoomLocation2 == true and LaboratoryRoomLocation3 == true and searchMode == true:
		numberOfSentence = 12
		searchMode = false
	if numberOfSentence == 15:
		get_node("Character").texture = CharacterAF
		get_node("Character").scale.x = 1
		get_node("Character").scale.y = 1
	if numberOfSentence == 32:
		get_node("Character").hide()
		get_node("Character").texture = null
	if numberOfSentence == 33:
		get_node("Background").texture = BackgroundOfficeDirector
		get_node("Background").scale.x = 1.57
		get_node("Background").scale.y = 1.2
	if numberOfSentence == 37:
		get_node("Character").show()
		get_node("Character").texture = CharacterCL
		get_node("Character").scale.x = 1
		get_node("Character").scale.y = 1
	if numberOfSentence == 62:
		get_node("Character").hide()
		get_node("Character").texture = null
	if numberOfSentence == 63:
		get_node("Background").texture = null
	if numberOfSentence == 64:
		get_node("Background").texture = BackgroundLaboratoryEntrance
		get_node("Background").scale.x = 1.57
		get_node("Background").scale.y = 1.2
	if numberOfSentence == 68:
		get_node("Character").show()
		get_node("Character").texture = CharacterHS
		get_node("Character").scale.x = 1
		get_node("Character").scale.y = 1
	if numberOfSentence == 98:
		get_node("Character").hide()
		get_node("Character").texture = null
		get_node("Background").texture = BackgroundLaboratoryWarehouse
		get_node("Background").scale.x = 1.57
		get_node("Background").scale.y = 1.2
	if numberOfSentence == 99:
		get_node("Character").show()
		get_node("Character").texture = CharacterHS
		get_node("Character").scale.x = 1
		get_node("Character").scale.y = 1

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if searchMode == false:
			if get_node("DialogBox").visible == true and get_global_mouse_position().x >= 0 and get_global_mouse_position().x <= 1920 \
			and get_global_mouse_position().y >= 800 and get_global_mouse_position().y <= 1025:
				print("numberOfSentence: ", numberOfSentence)
				if is_typing == true:
					# Si le texte s'affiche encore, le montrer en entier immédiatement
					dialog_label.text = current_text
					is_typing = false
				else:
					# Sinon, passer à la phrase suivante
					if numberOfSentence < GlobalScriptText.sentencesIntroduction.size():
						display_sentence()
					else:
						print("Fin des dialogues")
						
		if searchMode == true:
			if get_node("Background").texture == BackgroundLaboratoryRoom and get_node("DialogBox").visible == false:
				#print("get_global_mouse_position().x:", get_global_mouse_position().x)
				#print("get_global_mouse_position().y:", get_global_mouse_position().y)
				if get_global_mouse_position().x >= 0 and get_global_mouse_position().x <= 470 \
				and get_global_mouse_position().y >= 500 and get_global_mouse_position().y <= 800:
					name_label.text = GlobalScriptText.sentencesIntroduction[9][0]
					dialog_label.text = GlobalScriptText.sentencesIntroduction[9][1]
					get_node("DialogBox").show()
					LaboratoryRoomLocation1 = true
					
				elif get_global_mouse_position().x >= 470 and get_global_mouse_position().x <= 1200 \
				and get_global_mouse_position().y >= 350 and get_global_mouse_position().y <= 700:
					get_node("DialogBox").show()
					name_label.text = GlobalScriptText.sentencesIntroduction[10][0]
					dialog_label.text = GlobalScriptText.sentencesIntroduction[10][1]
					LaboratoryRoomLocation2 = true
					
				elif get_global_mouse_position().x >= 1450 and get_global_mouse_position().x <= 1920 \
				and get_global_mouse_position().y >= 450 and get_global_mouse_position().y <= 800:
					get_node("DialogBox").show()
					name_label.text = GlobalScriptText.sentencesIntroduction[11][0]
					dialog_label.text = GlobalScriptText.sentencesIntroduction[11][1]
					LaboratoryRoomLocation3 = true
					
			elif get_node("Background").texture == BackgroundLaboratoryRoom and get_node("DialogBox").visible == true:
				get_node("DialogBox").hide()

func display_sentence():
	if numberOfSentence >= GlobalScriptText.sentencesIntroduction.size():
		return  # Empêcher les erreurs si on dépasse la liste

	name_label.text = GlobalScriptText.sentencesIntroduction[numberOfSentence][0]
	current_text = GlobalScriptText.sentencesIntroduction[numberOfSentence][1]
	dialog_label.text = ""

	numberOfSentence += 1
	is_typing = true

	# Affichage progressif lettre par lettre
	for i in range(current_text.length()):
		if is_typing == true:
			dialog_label.text += current_text[i]
			await get_tree().create_timer(0.05).timeout  # Attendre 0.05s entre chaque lettre

	is_typing = false

func fadeInImage(delta,nameOfNode : String ,fadeSpeed : float) -> void:
	if get_node(nameOfNode).modulate.a < 1.0:
		get_node(nameOfNode).show()
		get_node(nameOfNode).modulate.a += fadeSpeed * delta
		get_node(nameOfNode).modulate.a = min(get_node(nameOfNode).modulate.a, 1.0)  # Ne pas dépasser 1

func fadeOutImage(delta,nameOfNode : String ,fadeSpeed : float) -> void:
	if get_node(nameOfNode).modulate.a > 0.0:
		get_node(nameOfNode).modulate.a -= fadeSpeed * delta
		get_node(nameOfNode).modulate.a = max(get_node(nameOfNode).modulate.a, 0.0) # Clamp à 0 pour éviter de passer négatif

func _on_button_quit_game_pressed():
	get_tree().change_scene_to_file("res://Scene/main_menu.tscn")
