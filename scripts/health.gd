extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		var parent = get_parent()
		if parent.is_in_group("spike"):
			GameManager.change_health(-1)
