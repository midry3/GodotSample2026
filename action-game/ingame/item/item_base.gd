@tool

extends RigidBody2D
class_name ItemBase

@export var monitoring_collision_shape: Shape2D
@export var monitoring_collision_pos: Vector2

@onready var monitoring_area := $Area2D
@onready var monitoring_collision := $Area2D/CollisionShape2D
@onready var anim := $AnimatedSprite2D


func _on_ready():
	monitoring_collision.shape = monitoring_collision_shape
	monitoring_collision.position = monitoring_collision_pos
