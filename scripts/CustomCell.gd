extends Node
class_name CustomCell

var position : Vector2i
var neighbors: String

func CustomCell(position:Vector2i,neighbors:String):
	self.position = position
	self.neighbors = neighbors
