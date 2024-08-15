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
var max_lives = 10

signal you_are_invincible

signal player_died
#signal companion_died
#signal hit_checkpoint(checkpoint_position)

signal scene_has_changed

signal collectible_picked
signal red_button_active
signal red_button_unactive

signal arrow_button_active
signal arrow_button_unactive

signal grek_gun_active
signal red_jester_hurt

signal turn_off_zhark_shield
signal you_can_kill_zhark_now

signal hand_was_destroyed

signal katrin_was_seen

signal bat_must_jump
signal bat_must_really_jump
signal the_bat_has_won

#signal blue_switch_pressed(blueswitchresponse)
#signal blue_plat_horiz_active(blueactivation)
#Just in case
