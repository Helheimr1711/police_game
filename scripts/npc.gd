extends CharacterBody3D

class_name NPC

## Variables ##
# Components #
@onready var mesh = $Node/rig/Skeleton3D/male_player
@onready var anim_player = $AnimationPlayer

## NPC Informations and Variables ##
# 
var npc_info = {"First Name" : "", "Surname" : "", "Date of Birth" : 0, "Sex" : "", "Political Opinion" : "", "Personality" : ""}
var moral_integrity = 50



func _ready() -> void:
	mesh.mesh = "res://assets/city_characters_placeholder/models/meshes/male_mesh.res"
