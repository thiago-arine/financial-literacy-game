extends Control

@onready var side_menu: Control = $SideMenu
@onready var menu_toggle_button: Button = $ButtonMenu
@onready var content_container: Control = $ContentContainer

var is_menu_open: bool = false
const MENU_WIDTH: float = 250.0
const CLOSED_POSITION: float = -MENU_WIDTH
const OPEN_POSITION: float = 0.0
const ANIMATION_DURATION: float = 0.3

func _ready() -> void:
    side_menu.position.x = CLOSED_POSITION
    
    menu_toggle_button.pressed.connect(toggle_menu)
    
    hide_all_screens()
    show_screen("Home_Screen")

func toggle_menu() -> void:
    is_menu_open = !is_menu_open
    
    var target_x: float = OPEN_POSITION if is_menu_open else CLOSED_POSITION
    
    var tween: Tween = create_tween()
    tween.tween_property(side_menu, "position:x", target_x, ANIMATION_DURATION)

func _input(event: InputEvent) -> void:

    if event.is_action_pressed("open_menu"):
        toggle_menu()
        get_viewport().set_input_as_handled()

func hide_all_screens() -> void:
    for child in content_container.get_children():
        if child is Control:
            child.visible = false

func show_screen(screen_name: String) -> void:
    hide_all_screens()
    var target_screen: Control = content_container.get_node(screen_name)
    if is_instance_valid(target_screen):
        target_screen.visible = true

func _on_icon_home_pressed() -> void:
    show_screen("tilemap_screen")
    toggle_menu()

func _on_icon_perfil_pressed() -> void:
    show_screen("eventscreen_scene")
    toggle_menu()
