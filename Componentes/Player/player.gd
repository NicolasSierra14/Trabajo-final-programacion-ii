
extends Entidad
class_name Player
## Controla el comportamiento del personaje principal. Administra la lectura de entradas del teclado para desplazarse y saltar, el inventario básico de colores (primarios, secundarios y combinaciones), la creación visual/instanciación de la poción activa en la mano del personaje, y el disparo hacia el escenario con control de enfriamiento (cooldown). Además, verifica su ciclo de vida ejecutando la muerte si los puntos de salud se agotan.

## Almacena el color primario seleccionado o el resultado de una mezcla secundaria.
@export var color_actual : String = ""

## Guarda temporalmente el segundo color ingresado por el jugador para ser mezclado con el actual.
@export var color_secundario : String = ""

## Referencia al nodo Timer asignado para gestionar el tiempo de recarga entre lanzamientos de pociones.
@export var cooldown_player : Timer 

## Booleano que bloquea o autoriza el lanzamiento de una nueva poción según el cooldown_player.
var puede_lanzar : bool = true

## Carga una instancia de pocion.
var escena_pocion = preload("res://Componentes/Pocion y disparos/pocion.tscn")

## Guarda la referencia del nodo de la poción que está creada actualmente como hija del jugador antes de ser disparada.
var instancia : Pocion

## Bucle de físicas principal del personaje
func _physics_process(delta):
	var direccion_x = Input.get_axis("Izquierda", "Derecha")
	direccion = Vector2(direccion_x, 0)
	
	if is_on_floor() and Input.is_action_just_pressed("Saltar"):
		velocity.y = -400.0 # Impulso inicial hacia arriba
	super._physics_process(delta)
	
	gestionar_colores()
	
	if Input.is_action_just_pressed("Lanzar"):
		lanzar_pocion()
	super._physics_process(delta)
	if vida < 0:
		Muerte()

## Detecta las pulsaciones de las teclas asignadas a los colores base ("Rojo", "Azul", "Amarillo").
## Al presionar cualquiera de los tres botones, llama a seleccionar_o_combinar() pasando el color respectivo y luego invoca crear_instancia_pocion(color_actual) para actualizar la poción que sostiene el personaje.
func gestionar_colores():
	if Input.is_action_just_pressed("Rojo"):
		print("Tecla 1 presionada")
		seleccionar_o_combinar("Rojo")
		crear_instancia_pocion(color_actual)
	elif Input.is_action_just_pressed("Azul"):
		print("Tecla 2 presionada")
		seleccionar_o_combinar("Azul")
		crear_instancia_pocion(color_actual)
	elif Input.is_action_just_pressed("Amarillo"):
		print("Tecla 3 presionada")
		seleccionar_o_combinar("Amarillo")
		crear_instancia_pocion(color_actual)

## Spawnea y vincula la poción al jugador para mostrarla visualmente en mano antes de disparar.
func crear_instancia_pocion(color):
	if instancia:
		if not instancia.lanzada:
			instancia.queue_free()
	instancia = escena_pocion.instantiate()
	instancia.tipo_color = color
	add_child(instancia)

## Decide si asignar un color primario inicial o preparar una mezcla.
## Si color_actual está vacío, guarda el color seleccionado. Si ya existía un color y el secundario está libre (y no es el mismo color repetido), guarda el segundo color y llama a combinar_colores().
func seleccionar_o_combinar(nuevo_color: String):
	if color_actual == "":
		color_actual = nuevo_color
	elif color_secundario == "" and color_actual != nuevo_color:
		color_secundario = nuevo_color
		combinar_colores()

## Fusiona los dos colores primarios en un color secundario resultante.
## Inserta ambos colores en un arreglo y aplica .sort() para ordenar alfabéticamente los textos (haciendo que el orden de entrada no afecte). Transforma las parejas en "Violeta" (Azul + Rojo), "Naranja" (Amarillo + Rojo) o "Verde" (Amarillo + Azul), vacía color_secundario e imprime la confirmación.
func combinar_colores():
	var combinacion = [color_actual, color_secundario]
	combinacion.sort()
	
	if combinacion == ["Azul", "Rojo"]:
		color_actual = "Violeta"
	elif combinacion == ["Amarillo", "Rojo"]:
		color_actual = "Naranja"
	elif combinacion == ["Amarillo", "Azul"]:
		color_actual = "Verde"
	
	color_secundario = ""
	print("¡Combinación exitosa! Poción resultante: ", color_actual)
	color_secundario = ""


## Ejecuta el disparo de la poción hacia el escenario.
func lanzar_pocion():
	print("La variable global es ", color_actual)
	print("Se lanzo la pocion: ", color_actual)
	if color_actual != "":
		color_actual = ""
		color_secundario = ""
	if puede_lanzar:
		puede_lanzar = false
		cooldown_player.start()
		if instancia:
			if instancia.lanzada: return
			instancia.lanzada = true
			instancia.reparent(get_tree().current_scene)
			instancia.movimiento_pocion()


## Función conectada a la señal de fin de tiempo del temporizador de recarga.
## Vuelve a colocar puede_lanzar = true, permitiendo disparar otra poción.
func _on_cooldown_player_timeout():
	puede_lanzar = true
