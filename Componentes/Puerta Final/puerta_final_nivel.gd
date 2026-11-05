extends Area2D

func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is Player:
		if VariablesGlobales.cantidad_zona_alquimica_necesarias >= 3:
			get_tree().change_scene_to_file("res://Escenas/Niveles/Ganaste_Nivel_1.tscn")
