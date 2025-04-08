extends Node2D

var sentences = [
	["Juge", "Aujourd’hui, le tribunal déclare XXX XXX officiellement décédée !"],
	["Héros P", "C’est ce qu’a déclaré le juge le jour de la septième année de la disparition de ma femme. Lors de l’annonce, j’étais complètement anéanti…"],
	["Héros P", "Un dur rappel à la réalité. Mais, même avec cette nouvelle étape, au fond de moi, je suis sûr d’une chose, c’est qu’elle est quelque part…"],
	["Héros P", "Je n’ai pas arrêté de la chercher depuis le jour de sa disparition. Tout remonte en 20XX."],
	["Héros P", "Je devais rencontrer quelqu’un ce jour-là pour ensuite rentrer à la maison."],
	["Héros P", "Elle devait elle aussi rentrer à la maison mais elle n’est jamais rentrée…"],
	["Héros P", "J’ai tout fait pour pouvoir la retrouver. Des moyens classiques en passant par des réseaux plus que douteux. Quitte à quitter mon job pour en prendre un à mi-temps."],
	["Héros P", "Mais rien n’y fait aucune trace d’elle nulle part. C’est comme-ci, le temps l’avait totalement effacée."],
	["Héros P", "Peut-être qu’il ait temps de passer à autre chose. C’est ce que je me suis dit jusqu’à qu’une inconnue vienne frapper à ma porte."],
	["Héros S", "Euh.. Excusez-moi… Vous êtes bien M.X ?"],
	["Héros P", "Oui. C’est moi. Que me voulez-vous ?"],
	["Héros S", "C’est à propos de l’avis de recherche..."],
]

@onready var name_label = get_node("DialogBox/Name")
@onready var dialog_label = get_node("DialogBox/Dialog")
var numberOfSentence = 0
var is_typing = false  # Empêche d'afficher une nouvelle phrase avant la fin de l'affichage de la précédente
var current_text = ""  # Stocke le texte complet pour le montrer instantanément si l'utilisateur clique

func _ready():
	display_sentence()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_typing == true:
			# Si le texte s'affiche encore, le montrer en entier immédiatement
			dialog_label.text = current_text
			is_typing = false
		else:
			# Sinon, passer à la phrase suivante
			if numberOfSentence < sentences.size():
				display_sentence()
			else:
				print("Fin des dialogues")

func display_sentence():
	if numberOfSentence >= sentences.size():
		return  # Empêcher les erreurs si on dépasse la liste

	name_label.text = sentences[numberOfSentence][0]
	current_text = sentences[numberOfSentence][1]
	dialog_label.text = ""

	numberOfSentence += 1
	is_typing = true

	# Affichage progressif lettre par lettre
	for i in range(current_text.length()):
		if is_typing == true:
			dialog_label.text += current_text[i]
			await get_tree().create_timer(0.05).timeout  # Attendre 0.05s entre chaque lettre

	is_typing = false


func _on_button_quit_game_pressed():
	get_tree().change_scene_to_file("res://Scene/menu_principal.tscn")
