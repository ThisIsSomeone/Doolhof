extends Node2D

var current:Node
@export var start_scene:PackedScene

@export_range(0.1, 2.0, 0.05, "or_greater", "suffix:seconds") var transition_duration:float = 1.0
@export var transition_type:Tween.TransitionType
@export var transition_ease_type:Tween.EaseType

func _ready() -> void:
	var start_instance:Node = start_scene.instantiate()
	current = start_instance
	add_child(start_instance)

##Wipes the screen on a screen transition
func wipe_to_scene(scene:PackedScene) -> void:
	#Take the current texture of the viewport and apply it to the TextureRect node
	var viewport_tex_copy := ImageTexture.create_from_image(get_viewport().get_texture().get_image())
	var wiping:TextureRect = $WiperLayer/WipingTexture
	wiping.texture = viewport_tex_copy
	
	#Create a Tween over the shader parameter called progress, indicating how far we are in a scene transition
	var tween := create_tween()
	tween.tween_method(
		func(value:float):
			(wiping.material as ShaderMaterial).set_shader_parameter(&"progress", value)
			, 0.0, 1.0, transition_duration).set_ease(transition_ease_type).set_trans(transition_type)
	
	#Delete old scene
	current.queue_free()
	remove_child(current)
	
	#Instantiate new scene and make it current scene
	var scene_instance := scene.instantiate()
	current = scene_instance
	add_child(scene_instance)
