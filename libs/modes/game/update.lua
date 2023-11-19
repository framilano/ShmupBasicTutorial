function update_game()
	--check game control buttons pressed
	controls()

	--check ship game boundaries
	check_ship_limits()

	--update bullets position
	update_bullets()

	--animate flames
	update_flames()

	--animate enemies
	update_enemies()

	--checking enemies hitting ship
	check_enemy_collision()

	--checking bullets hitting enemies
	check_bullet_collision()
end