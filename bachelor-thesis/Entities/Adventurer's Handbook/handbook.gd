extends CanvasLayer

@onready var sprite : AnimatedSprite2D = $Mother/BookRect/AnimatedSprite2D
@onready var BookContents : Control = $Mother/BookRect/AnimatedSprite2D/BookContents
@onready var ClosingTab : Control = $"Mother/BookRect/AnimatedSprite2D/Closing Button/Tab"
@onready var vbox : VBoxContainer = $Mother/BookRect/AnimatedSprite2D/VBoxContainer

@onready var left : MarginContainer = $Mother/BookRect/AnimatedSprite2D/BookContents/Left
@onready var right : MarginContainer = $Mother/BookRect/AnimatedSprite2D/BookContents/Right

@onready var leftpage : Label = $Mother/BookRect/AnimatedSprite2D/BookContents/LeftPage
@onready var rightpage : Label = $Mother/BookRect/AnimatedSprite2D/BookContents/RightPage

@onready var index : int = 0 #Starts at base index page

@onready var mother : Control = $Mother

var duration = 0.1 #Duration of text appearance 
var disabled = false

#Actual
var book : Dictionary[int, PackedScene] = {
	#Set 0
	0: preload("res://Entities/Adventurer's Handbook/Pages/Page0.tscn"), #Page 0
	1: preload("res://Entities/Adventurer's Handbook/Pages/Page1.tscn"), #Page 1
	
	#Set 1 | Oplossing Puzzel Segment 2
	2: preload("res://Entities/Adventurer's Handbook/Pages/Page2.tscn"), #FILLER
	3: preload("res://Entities/Adventurer's Handbook/Pages/Page3.tscn"), #FILLER
	
	#Set 2 | Oplossing Puzzel Tutorial (2)
	4: preload("res://Entities/Adventurer's Handbook/Pages/LorumPage.tscn"), #FILLER
	5: preload("res://Entities/Adventurer's Handbook/Pages/Page5.tscn"), #Page 5
	
	#Set 3
	6: preload("res://Entities/Adventurer's Handbook/Pages/Page6.tscn"), #Page 6
	7: preload("res://Entities/Adventurer's Handbook/Pages/Page7.tscn"), #Page 7
	
	#Set 4
	8: preload("res://Entities/Adventurer's Handbook/Pages/Page8.tscn"), #Page 8
	9: preload("res://Entities/Adventurer's Handbook/Pages/Page9.tscn"), #Page 9
	
	#Set 5
	10: preload("res://Entities/Adventurer's Handbook/Pages/Page10.tscn"), #Page 8
	11: preload("res://Entities/Adventurer's Handbook/Pages/LorumPage.tscn"), #FILLER
	
	#Set 6 | Oplossing Puzzel Segment 3
	13: preload("res://Entities/Adventurer's Handbook/Pages/LorumPage.tscn"), #FILLER
	14: preload("res://Entities/Adventurer's Handbook/Pages/Page14.tscn"), #Page 14
	
	#Set 7
	15: preload("res://Entities/Adventurer's Handbook/Pages/Page15.tscn"), #Page 15
	16: preload("res://Entities/Adventurer's Handbook/Pages/LorumPage.tscn"), #FILLER
	
	#Set 20
	20: preload("res://Entities/Adventurer's Handbook/Pages/Pagina20.tscn"), #Page 20
	21: preload("res://Entities/Adventurer's Handbook/Pages/LorumPage.tscn"), #FILLER
	
	#Set 24: #TODO: Oplossing Puzzel Segment 5
	24: preload("res://Entities/Adventurer's Handbook/Pages/Pagina24.tscn"), #Page 24
	25: preload("res://Entities/Adventurer's Handbook/Pages/Pagina25.tscn"), #Page 25
	
	#Set 30
	30: preload("res://Entities/Adventurer's Handbook/Pages/Pagina30.tscn"), #Page 30
	31: preload("res://Entities/Adventurer's Handbook/Pages/LorumPage.tscn"), #FILLER
	
	#Set 36 | Oplossing Puzzel Segment 1 (1)
	36: preload("res://Entities/Adventurer's Handbook/Pages/Pagina36.tscn"), #Page 36
	37: preload("res://Entities/Adventurer's Handbook/Pages/LorumPage.tscn"), #Page 37
	
	#Set 40
	40: preload("res://Entities/Adventurer's Handbook/Pages/Pagina40.tscn"), #Page 40
	41: preload("res://Entities/Adventurer's Handbook/Pages/Page41.tscn"), #FILLER
	
	#Set 42 | Oplossing Puzzel Segment 1 (2)
	42: preload("res://Entities/Adventurer's Handbook/Pages/Page42.tscn"), #Page 42
	43: preload("res://Entities/Adventurer's Handbook/Pages/Page43.tscn"), #Page 43
	
	#Set 44
	44: preload("res://Entities/Adventurer's Handbook/Pages/Page44.tscn"), #Page 44
	45: preload("res://Entities/Adventurer's Handbook/Pages/Page45.tscn"), #Page 45
	
	#Set 46 | Oplossing Puzzel Tutorial (1)
	46: preload("res://Entities/Adventurer's Handbook/Pages/Page46.tscn"), #Page 46
	47: preload("res://Entities/Adventurer's Handbook/Pages/LorumPage.tscn"), #Page 47
	
	#Set 50: Bronnen
	50: preload("res://Entities/Adventurer's Handbook/Pages/Pagina50.tscn"), #Page 50
	51: preload("res://Entities/Adventurer's Handbook/Pages/Pagina51.tscn"), #Page 51
	
	#Set -1
	-1: preload("res://Entities/Adventurer's Handbook/Pages/LorumPage.tscn") #nullpage
}

#Change the pages of the book
func change_pages(new_page : int):
	print("Changing to page: ")
	print(new_page)
	if new_page == 2 and Global.area == 2:
		#Only If puzzle is shown segment 2
		Dialogic.VAR.set_variable("Actual.Segment 2.handbook_37_seen", true)
	if new_page == 24 and Global.area == 5:
		#Only if puzzle is shown Segment 5
		Dialogic.VAR.set_variable("Segment 5.right1_unlocked", true)
	disabled = true
	if new_page > index:
		flip("flip_left", new_page)
	if new_page < index:
		flip("flip_right", new_page)
	if new_page == index:
		disabled = false
	index = new_page


#Flip page animation
#Direction: flip_left or flip_right
func flip(direction : StringName, new_page: int):
	var tween : Tween = create_tween()
	tween.tween_property(BookContents, "modulate:a", 0, duration)
	tween.tween_callback(sprite.play.bind(direction))
	await sprite.animation_finished
	sprite.play("idle") #TODO: Remove?
	set_pages(new_page)
	var tween2 : Tween = create_tween()
	tween2.tween_property(BookContents, "modulate:a", 1, duration)
	await tween2.finished
	disabled = false

#Set new pages of the book
func set_pages(new_page : int):
	remove_pages()
	leftpage.text = str(new_page)
	rightpage.text = str(new_page + 1)
	if book.has(new_page) and book.has(new_page+1):
		var lefty = book[new_page].instantiate()
		left.add_child(lefty)
		var righty = book[new_page+1].instantiate()
		right.add_child(righty)
	else:
		var lefty = book[-1].instantiate()
		left.add_child(lefty)
		var righty = book[-1].instantiate()
		right.add_child(righty)

#Clears current pages book
func remove_pages() -> void:
	left.get_children().all(func(i:Node):i.queue_free())
	right.get_children().all(func(i:Node):i.queue_free())

func open_book():
	if not disabled:
		disabled = true
		Global.update_handbook_tracker()
		mother.show()
		index = 0
		set_pages(0)
		#TODO: Fix?
		#sprite.play("open")
		#await sprite.animation_finished
		disabled = false
		var tween : Tween = create_tween()
		tween.tween_property(BookContents, "modulate:a", 1, duration)
		tween.tween_callback(open_tabs)

func open_tabs():
	ClosingTab.open()
	for child in vbox.get_children():
		child.open()
		await get_tree().create_timer(0.1).timeout

func close_tabs():
	ClosingTab.close()
	
	for child in vbox.get_children():
		child.close()

func _closing_tab():
	if not disabled:
		disabled = true
		close_tabs()
		await get_tree().create_timer(0.3).timeout
		var tween : Tween = create_tween()
		tween.tween_property(BookContents, "modulate:a", 0, duration) 
		#TODO: Fix?
		#tween.tween_callback(sprite.play.bind("close"))
		#await sprite.animation_finished
		Dialogic.paused = false #Unpauses Dialogic
		mother.hide()
		disabled = false

func _on_page_forward_pressed():
	if not disabled:
		if index < 50: #TODO: Change limit?
			change_pages(index + 2)

func _on_page_backward_pressed():
	if not disabled:
		if index > 0:
			change_pages(index - 2)

func _on_page_50_pressed():
	if not disabled:
		change_pages(50)

func _on_page_40_pressed():
	if not disabled:
		change_pages(40)

func _on_page_30_pressed():
	if not disabled:
		change_pages(30)

func _on_page_20_pressed():
	if not disabled:
		change_pages(20)

func _on_page_10_pressed():
	if not disabled:
		change_pages(10)

func _on_page_0_pressed():
	if not disabled:
		change_pages(0)

#Close book via bottom-left button
func _on_close_book_2_pressed():
	_closing_tab() #Closes the Handbook
