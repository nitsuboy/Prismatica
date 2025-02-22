extends Node2D

@onready var ray:Array[RayCast2D] = []
var maxref = 10
var refs = 0

func _ready() -> void:
	ray.append_array(get_children())
	
func bn(vec1:Vector2,n) -> Vector2:
	return vec1-(2*vec1.dot(n)*n)

func _process(delta: float) -> void:
	var idx = 1
	for r in ray:
		if r.is_colliding():
			r.get_child(0).set_points(PackedVector2Array([Vector2i(0,0), r.get_collision_point() - r.global_position]))
			match r.get_collider().att:
				1:
					if idx < ray.size():
						ray[idx].position = to_local(r.get_collision_point())
					if idx > refs and refs < maxref:
						refs+=1
						var rayr = RayCast2D.new()
						rayr.target_position = bn(r.target_position,r.get_collision_normal())
						print(r.get_collision_point())
						rayr.collide_with_areas = true
						rayr.collide_with_bodies = false
						rayr.position = to_local(r.get_collision_point())
						var line = Line2D.new()
						line.width = 3
						line.end_cap_mode = Line2D.LINE_CAP_ROUND
						line.begin_cap_mode = Line2D.LINE_CAP_ROUND
						rayr.add_child(line)
						add_child(rayr)
						ray.append(rayr)
				2:
					pass
		else :
			if idx < ray.size():
				var t = idx
				while t < ray.size():
					ray[t].queue_free()
					t+=1
				ray = ray.slice(0,idx)
				refs = idx-1
				break
		idx += 1
				
			
