extends Node

signal touch_water

signal blue_switch_pressed
signal blue_plat_horiz_active

signal yellow_switch_pressed
signal yellow_plat_verti_active

signal green_switch_one_pressed
signal green_switch_two_pressed
signal halfcircle_plat_active_one
signal halfcircle_plat_active_two

signal floor_switch_active
signal floor_switch_barrier_opens

signal trade_item_received

signal coin_was_captured
signal score_was_updated

signal new_life
signal life_lost
var score = 0
var lives = 3
var max_lives = 5

signal you_are_invincible

signal player_died
#signal companion_died
#signal hit_checkpoint(checkpoint_position)

signal scene_has_changed

signal collectible_picked


#signal blue_switch_pressed(blueswitchresponse)
#signal blue_plat_horiz_active(blueactivation)
#Just in case
