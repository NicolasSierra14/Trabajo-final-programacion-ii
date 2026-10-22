extends Area2D
class_name ZonaAlquimica

@export var label_combinacion : Label

var secuencia_objetivo : Array[int] = []
var secuencia_ingresada : Array[int] = []
var jugador_adentro : bool = false
var completada : bool = false

func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	if not body_exited.is_connected(_on_body_exited):
		body_exited.connect(_on_body_exited)
	
	generar_combinacion_azar()
	
	if label_combinacion:
		label_combinacion.visible = false

func generar_combinacion_azar():
	secuencia_objetivo.clear()
	# Genera 5 números al azar entre 1 y 3
	for i in range(5):
		var num_random = randi_range(1, 3)
		secuencia_objetivo.append(num_random)
	
	actualizar_interfaz()

func actualizar_interfaz():
	if label_combinacion:
		# Convertimos los números explícitamente a texto
		var texto : String = ""
		for n in secuencia_objetivo:
			texto += str(n) + " "
		label_combinacion.text = texto
		print("Texto asignado al Label: ", label_combinacion.text)

func _on_body_entered(body):
	print("Objeto entró al área: ", body.name)
	# Verificamos si entra el jugador y la zona no fue completada
	if body is Player and not completada:
		jugador_adentro = true
		secuencia_ingresada.clear()
		actualizar_interfaz()
		if label_combinacion:
			label_combinacion.visible = true


func _on_body_exited(body):# Si sale el jugador y la zona aún no se completó, se oculta y resetea
	if (body is Player or body.is_in_group("Player")) and not completada:
		jugador_adentro = false
		secuencia_ingresada.clear()
		if label_combinacion:
			label_combinacion.visible = false

func _unhandled_input(event):
	if not jugador_adentro or completada:
		return
	
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var tecla_presionada : int = 0
		
		if event.keycode == KEY_1:
			tecla_presionada = 1
		elif event.keycode == KEY_2:
			tecla_presionada = 2
		elif event.keycode == KEY_3:
			tecla_presionada = 3
		
		if tecla_presionada != 0:
			procesar_tecla(tecla_presionada)

func procesar_tecla(tecla: int):
	secuencia_ingresada.append(tecla)
	var indice_actual = secuencia_ingresada.size() - 1
	
	# Si falla la combinación, se reinicia la entrada
	if secuencia_ingresada[indice_actual] != secuencia_objetivo[indice_actual]:
		secuencia_ingresada.clear()
		actualizar_interfaz()
		return
	
	# Mostrar progreso visual
	if label_combinacion:
		label_combinacion.text = "OK: " + str(secuencia_ingresada.size()) + " / 5"
	
	if secuencia_ingresada.size() == secuencia_objetivo.size():
		completar_zona()

func completar_zona():
	completada = true
	print("¡Zona completada!")
	
	if label_combinacion:
		label_combinacion.text = "¡COMPLETO!"
		queue_free()
