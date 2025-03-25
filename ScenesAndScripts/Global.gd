extends Node

var coin_flipper : Node
var text_manager : Node
var binary : int
var yao : int = 0
var yao2 : int = 0
var id : String
var id2 : String
var safe_ids = range(64)
var unsafe_ids = [3, 4, 9, 10, 21, 22, 33, 34, 45, 46, 49, 50, 53, 54]
var incremented_array = []

func _ready():
	for number in safe_ids:
		incremented_array.append(number + 1)
	safe_ids = incremented_array
	for i in unsafe_ids:
		safe_ids.erase(i)
