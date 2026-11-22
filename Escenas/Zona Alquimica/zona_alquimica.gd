extends Area2D
class_name ZonaAlquimica
## Gestiona las zonas interactivas de alquimia en el mapa. Al entrar el jugador, genera y muestra una secuencia numérica aleatoria de 5 dígitos (basada en las teclas 1, 2 y 3) utilizando etiquetas o íconos mediante un RichTextLabel. Monitorea las entradas de teclado del usuario, valida que la combinación sea correcta en tiempo real (ocultando los números a medida que se aciertan o reiniciando si se comete un error) y avisa al sistema global al completar la zona.

## Referencia al nodo de texto asignado desde el Inspector para mostrar dinámicamente los códigos visuales de las pociones faltantes.
@export var label_combinacion : RichTextLabel

## Base de datos que almacena los 5 números generados al azar (valores entre 1 y 3) que conforman la combinación correcta a adivinar.
var secuencia_objetivo : Array[int] = []

## Base de datos donde se van registrando los dígitos presionados por el jugador dentro de la zona.
var secuencia_ingresada : Array[int] = []

## Booleano que indica si el jugador se encuentra actualmente dentro del área de la zona alquímica.
var jugador_adentro : bool = false

## Booleano de control que determina si la zona ya fue resuelta con éxito para desactivar futuras interacciones.
var completada : bool = false

## Referencia al nodo del jugador (Player) cuando entra al área, utilizada para modificar sus permisos de mezcla.
var jugador : Player


## Configura los estados iniciales de la zona al entrar en ejecución.
func _ready():
	if not body_entered.is_connected(_on_body_entered): #Conecta la deteccion del el Player entro a la zona.
		body_entered.connect(_on_body_entered)
	if not body_exited.is_connected(_on_body_exited): #Conecta la deteccion del Players alio a la zona.
		body_exited.connect(_on_body_exited)
	
	generar_combinacion_azar() 
	
	if label_combinacion:
		label_combinacion.visible = false #El texto del objeto no es visible al incio de la partida.

## Crea una nueva secuencia numérica aleatoria de 5 elementos.
func generar_combinacion_azar(): 
	secuencia_objetivo.clear() #Limpia el Array.
	for i in range(5): #Inicia un bucle de 5 veces.
		var num_random = randi_range(1, 3) # Devuelve un numero entre 1 y 3.
		secuencia_objetivo.append(num_random) #Agrega los numero que salieron a la Array.

## Refresca el contenido visual del RichTextLabel mostrando únicamente los números o íconos que el jugador aún debe presionar.
func actualizar_interfaz():
	if not label_combinacion: 
		return
	
	var texto_restante : String = "" 
	var desde_indice = secuencia_ingresada.size() #Guarda en una variable cuántas teclas lleva presionadas y acertadas el jugador hasta el momento.

	
	
	# Recorre desde el dígito que toca presionar hasta el final
	for i in range(desde_indice, secuencia_objetivo.size()): #Dibuja la secuencia de las pociones en la Zona Alquimica.
		match secuencia_objetivo[i]:
			1:
				texto_restante += "[img=20]res://Componentes/Sprites/Pociones/tile_7_0.png[/img] "
			2:
				texto_restante += "[img=20]res://Componentes/Sprites/Pociones/tile_7_10.png[/img] "
			3:
				texto_restante += "[img=20]res://Componentes/Sprites/Pociones/tile_7_4.png[/img]"
	
	label_combinacion.text = texto_restante

## Detecta la entrada de cuerpos al área física.
func _on_body_entered(body):
	print("Objeto entró al área: ", body.name)
	# Verificamos si entra el jugador y la zona no fue completada
	if body is Player and not completada:
		jugador = body
		jugador_adentro = true
		secuencia_ingresada.clear()
		actualizar_interfaz()
		if label_combinacion:
			label_combinacion.visible = true
		body.puede_mezclar = false

## Detecta cuando un cuerpo abandona el área física.
func _on_body_exited(body):# Si sale el jugador y la zona aún no se completó, se oculta y resetea
	if (body is Player or body.is_in_group("Player")) and not completada:
		jugador_adentro = false
		secuencia_ingresada.clear()
		if label_combinacion:
			label_combinacion.visible = false
		body.puede_mezclar = true

## Captura eventos de entrada de teclado globales mientras el jugador está dentro y la zona esté activa.
func _input(event):
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

## Evalúa el dígito introducido frente a la secuencia esperada.
func procesar_tecla(tecla: int):
	secuencia_ingresada.append(tecla)
	var indice_actual = secuencia_ingresada.size() - 1 #Calcula la posición exacta del último número que se acaba de ingresar, restándole 1 al tamaño total del Array.
	
	# Si falla la tecla, se reinicia la entrada y reaparece el código completo
	if secuencia_ingresada[indice_actual] != secuencia_objetivo[indice_actual]: #Compara el número que el jugador acaba de presionar con el número que debería ir.
		secuencia_ingresada.clear()
		actualizar_interfaz()
		return #Si es erroneo el boton precionado por el Player, el codigo detiene la ejecucion para que no haya errores.
	
	# Tecla correcta: borra el número acertado mostrando solo los restantes
	actualizar_interfaz()
	
	# Si se ingresaron los 5 números
	if secuencia_ingresada.size() == secuencia_objetivo.size():
		completar_zona()
		VariablesGlobales.cantidad_zona_alquimica_necesarias += 1

## Finaliza con éxito la zona alquímica.
func completar_zona():
	completada = true
	jugador.puede_mezclar = true
	print("¡Zona completada!")
	
	if label_combinacion:
		label_combinacion.text = "¡COMPLETO!"
		queue_free()
