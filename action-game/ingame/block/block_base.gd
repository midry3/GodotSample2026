extends CharacterBody2D
signal hitted # ブロックが叩かれたシグナル

@onready var anim := $AnimatedSprite2D

var hit_handled := false # 多重処理防止

func _ready():
	anim.play("default")

func _physics_process(delta):
	move_and_slide()
	if is_on_floor() and !hit_handled: # プレイヤーとの当たり判定があるので、プレイヤーが下から接触してくる＝プレイヤーがブロックに対して床となる　と解釈できる
		hit()
		hit_handled = true
	else:
		hit_handled = false

func hit() -> void:
	var t := create_tween()
	t.tween_property(self, "position:y", position.y-50, 0.1)
	t.tween_property(self, "position:y", position.y, 0.1)
	hitted.emit()
