extends CharacterBody2D
class_name Pocion
## Representa el proyectil arrojadizo instanciado por el jugador. Administra su propia física de trayectoria parabólica (desplazamiento horizontal constante afectado por la aceleración de gravedad), actualiza dinámicamente la animación del sprite según el color asignado, y gestiona la detección de colisiones mediante su Area2D para interactuar con el entorno sólido o infligir daño a los enemigos si sus colores coinciden.

## Cadena que almacena el color de la poción (por ejemplo: "Rojo", "Azul", "Amarillo", "Violeta", "Naranja", "Verde").
@export var tipo_color : String = ""

## Vector unitario que define el sentido horizontal hacia el cual fue arrojada la poción.
var direccion : Vector2 = Vector2.RIGHT

## Aceleración vertical aplicada en el eje Y fotograma a fotograma cuando la poción ha sido lanzada, simulando la caída libre natural.
var gravedad : float = 980.0

## Velocidad lineal constante con la que avanza sobre el eje X.
var velocidad_horizontal : float = 300.0

## Impulso vertical inicial hacia arriba (valor negativo en el eje Y) otorgado al dispararse para generar el arco en parábola.
var velocidad_inicial_vertical : float = -150.0

## Cantidad de puntos de salud que restará al enemigo impactado si el color coincide.
var daño_pocion : float = 100

## Conecta el AnimatedSprite2D con una variable para poder cambiar el sprit.
@onready var sprite_pocion = $SpritePocion

## Referencia al nodo detector de colisiones.
@export var area : Area2D

## Control que indica si la poción se encuentra actualmente en vuelo activo o si aún permanece sujeta en la mano del jugador.
var lanzada : bool = false

## Bucle de actualización de física y detección continua de colisiones de la poción.
func _physics_process(delta):
	actualizar_visual_pocion()
	#Evalúa si lanzada es verdadero. En caso afirmativo, suma la gravedad a velocity.y multiplicada por el tiempo transcurrido (delta) y ejecuta move_and_slide() para desplazar físicamente el cuerpo.
	if lanzada:
		velocity.y += gravedad * delta
		move_and_slide()
	
	# Si el cuerpo detectado es terreno o pared (StaticBody2D o TileMapLayer), destruye la poción llamando a queue_free().
	for body in area.get_overlapping_bodies():
		if body is StaticBody2D or body is TileMapLayer:
			queue_free()
			
	# Si el cuerpo detectado es un Enemigo, comprueba si body.color_enemigo == tipo_color. De coincidir, aplica body.daño_recibido_enemigo(daño_pocion) para restarle salud. Finalmente, invoca queue_free() para eliminar el proyectil tras el impacto.
		if body is Enemigo:
			if body.color_enemigo == tipo_color:
				body.daño_recibido_enemigo(daño_pocion)
			queue_free()

## Refrescar el aspecto del sprite según el color actual.
func actualizar_visual_pocion():
		# Compara el contenido de tipo_color y ejecuta el método .play() del nodo sprite_pocion con la animación respectiva ("rojo", "azul", "amarillo", "violeta", "naranja", "verde").
		if tipo_color == "Rojo":
			sprite_pocion.play("rojo")
		elif tipo_color== "Azul":
			sprite_pocion.play("azul")
		elif tipo_color == "Amarillo":
			sprite_pocion.play("amarillo")
		elif tipo_color == "Violeta":
			sprite_pocion.play("violeta")
		elif tipo_color == "Naranja":
			sprite_pocion.play("naranja")
		elif tipo_color == "Verde":
			sprite_pocion.play("verde")

## Configura el vector de velocidad inicial al momento del disparo.
func movimiento_pocion():
	# Asigna un vector base inicial (Vector2(50, 50)), define la velocidad en el eje X multiplicando la dirección por la velocidad horizontal (direccion.x * velocidad_horizontal), y carga en el eje Y el impulso vertical inicial negativo (velocidad_inicial_vertical).
	velocity = Vector2(50,50)
	velocity.x = direccion.x * velocidad_horizontal
	velocity.y = velocidad_inicial_vertical
