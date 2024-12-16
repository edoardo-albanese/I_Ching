extends PanelContainer

@onready var title = $MarginContainer/VBoxContainer/Title
@onready var description = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Description
@onready var author = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Author
@onready var allegory = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Allegory

@onready var buttons = $MarginContainer/VBoxContainer/Buttons
@onready var first = $MarginContainer/VBoxContainer/Buttons/First
@onready var second = $MarginContainer/VBoxContainer/Buttons/Second
@onready var scroll_container = $MarginContainer/VBoxContainer/ScrollContainer

@onready var click = $"../Sounds/Click"

var file_path = "res://Assets/iChing.csv"

var id : String
var buttonIndex : int

var titles : Array = []
var descriptions : Array = []
var ids : Array = []
var authors : Array = []
var images : Dictionary = {
	1: preload("res://Images/Esagrammo 1 - Edoardo Albanese.jpg"),
	2: preload("res://Images/Esagrammo 2 - Edoardo Albanese.jpg"),
	3: null,
	4: null,
	5: preload("res://Images/5_BRUSA.jpg"), #ci sta,
	6: preload("res://Images/6_BRUSA.jpg"), #ci sta,
	7: preload("res://Images/CHING 7 MATTEO CASSANITI.jpeg"),
	8: preload("res://Images/CHING 8 MATTEO CASSANITI.jpeg"),
	9: null,
	10: null,
	11: null,
	12: null,
	13: preload("res://Images/DI_MARZO_Ching_13.jpg"),
	14: preload("res://Images/DI_MARZO_Ching_14.jpg"),
	15: preload("res://Images/Esagramma 15 Fimiani .JPG"),
	16: preload("res://Images/Esagramma 16 Fimiani.JPG"),
	17: preload("res://Images/ching 17-Lorenza Fiorillo.jpg"),
	18: preload("res://Images/ching 18 Lorenza Fiorillo.jpg"), #ci sta
	19: preload("res://Images/19-esagramma.jpg"),
	20: preload("res://Images/20-esagramma.jpg"),
	21: null,
	22: null,
	23: preload("res://Images/I ching n23 Eduardo Hakobyan.jpg"),
	24: preload("res://Images/I ching n24 Eduardo Hakobyan.jpg"),
	25: null,
	26: null,
	27: preload("res://Images/ching 27.webp"),
	28: preload("res://Images/ching 28.webp"),
	29: null,
	30: null,
	31: preload("res://Images/Esagramma 31 Pan Yijie.jpg"),
	32: preload("res://Images/Esagramma 32 Pan Yijie.jpg"),
	33: null,
	34: null,
	35: preload("res://Images/Esagramma 35 Riccardo Piacente.webp"),
	36: preload("res://Images/Esagramma 36 Riccardo Piacente.webp"),
	37: preload("res://Images/Esagramma 37-Maria Grazia Pisano.jpg"),
	38: preload("res://Images/Esagramma 38-Maria Grazia Pisano.jpg"),
	39: preload("res://Images/Leonardo respiggi esagramma 39.jpg"),
	40: preload("res://Images/Leonardo respiggi esagramma 40.jpg"),
	41: preload("res://Images/ROMANO ESAGRAMMA 41.jpg"),
	42: preload("res://Images/ROMANO ESAGRAMMA 42.jpg"),
	43: null,
	44: null,
	45: null,
	46: null,
	47: preload("res://Images/ching 47 _L_assillo_ Sole Diana.jpg"),
	48: preload("res://Images/ching 49 realistica.jpg"),
	49: preload("res://Images/ching 49 realistica.jpg"),
	50: preload("res://Images/ching 50 realistica.jpg"),
	51: preload("res://Images/ESAGRAMMA 51 ROBERTO VARETTO.jpg"),
	52: preload("res://Images/ESAGRAMMA 52ROBERTO VARETTO.jpg"),
	53: null,
	54: null,
	55: preload("res://Images/esagramma 55 Irene Vittoria_.jpg"),
	56: preload("res://Images/esagramma 56 Irene Vittoria.jpg"),
	57: null,
	58: null,
	59: null,
	60: null,
	61: preload("res://Images/Esagramma 61 - Francesca Zhou.jpg"),
	62: preload("res://Images/Esagramma 62 - Francesca Zhou.jpg"),
	63: preload("res://Images/Esagramma 63-ZhouGioia.jpg"),
	64: preload("res://Images/Esagramma 64-ZhouGioia.jpg")
	
}

func _ready():
	import_csv()
	Global.text_manager = self

func import_csv():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file == null:
			print("Error opening file: " + file_path)
			return
		while !file.eof_reached():
			var data_set = Array(file.get_csv_line())
			titles.append(data_set[3])
			descriptions.append(data_set[5])
			ids.append(data_set[1])
			authors.append(data_set[0])
		file.close()
	else:
		print("File does not exist: " + file_path)
	

func _draw():
	update_text()
	if Global.id == Global.id2:
		buttons.hide()
	else:
		buttons.show()

func update_text():
	if buttonIndex == 1:
		id = Global.id
		first.disabled = true
		second.disabled = false
	else:
		id = Global.id2
		first.disabled = false
		second.disabled = true
	var index
	for i in ids.size():
		if id == ids[i]:
			index = i
	title.text = str(index) + ". " + titles[index]
	description.text = descriptions[index]
	description.visible_characters = 400
	author.text = "Scritto da: " + authors[index]
	allegory.texture = images[index]
	scroll_container.scroll_vertical = 0


func _on_first_pressed():
	click.play()
	buttonIndex = 1
	update_text()

func _on_second_pressed():
	click.play()
	buttonIndex = 2
	update_text()
