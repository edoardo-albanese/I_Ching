extends PanelContainer

@onready var title = $MarginContainer/VBoxContainer/Title
@onready var description = $MarginContainer/VBoxContainer/Description/VBoxContainer/Description
@onready var author = $MarginContainer/VBoxContainer/Description/VBoxContainer/Author
@onready var allegory = $MarginContainer/VBoxContainer/Description/VBoxContainer/Allegory

@onready var buttons = $MarginContainer/VBoxContainer/Buttons
@onready var first = $MarginContainer/VBoxContainer/Buttons/First
@onready var second = $MarginContainer/VBoxContainer/Buttons/Second

@onready var click = $"../Sounds/Click"

var file_path = "res://Assets/iChing.csv"

var titles : Array = []
var descriptions : Array = []
var ids : Array = []
var authors : Array = []

var id : String
var buttonIndex : int

func _ready():
	import_csv()
	Global.text_manager = self
	
	# Create an HTTP request node and connect its completion signal.
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_http_request_completed)
	# Perform the HTTP request. The URL below returns a PNG image as of writing.
	var error = http_request.request("https://gratisography.com/wp-content/uploads/2024/10/gratisography-cool-cat-800x525.jpg")
	if error != OK:
		push_error("An error occurred in the HTTP request.")


# Called when the HTTP request is completed.
func _http_request_completed(result, _response_code, _headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Image couldn't be downloaded. Try a different image.")
	
	var image = Image.new()
	var error = image.load_jpg_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")

	var texture = ImageTexture.create_from_image(image)

	# Display the image in a TextureRect node.
	allegory.set_texture(texture)

func import_csv():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file == null:
			print("Error opening file: " + file_path)
			return
		while !file.eof_reached():
			var data_set = Array(file.get_csv_line())
			titles.append(data_set[3])
			descriptions.append(data_set[4])
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
	author.text = "Scritto da: " + authors[index]


func _on_first_pressed():
	click.play()
	buttonIndex = 1
	update_text()

func _on_second_pressed():
	click.play()
	buttonIndex = 2
	update_text()
