function controls()
    if (game.lives <= 0) return
    ship_speed_x = 0
    ship_speed_y = 0
    game.ship.sprite = 1

    if btn(0) then
        ship_speed_x = -abs(game.ship.default_speed_x)
        game.ship.sprite = 2
    end
    if btn(1) then
        ship_speed_x = abs(game.ship.default_speed_x)
        game.ship.sprite = 3
    end
    if btn(2) then
        ship_speed_y = -abs(game.ship.default_speed_y)
    end
    if btn(3) then
        ship_speed_y = abs(game.ship.default_speed_y)
    end

    if btn(5) and game.ship.current_bullet_cooldown <= 0 then
        new_bullet = {
            x = game.ship.x + 1,
            y = game.ship.y - 6,
            width = 6,
            height = 8,
            sprite = 16,
            type = "normal"
        }
        add(game.ship.bullets, new_bullet)
        game.ship.muzzleflash = true
        sfx(0)
        game.ship.current_bullet_cooldown = game.ship.default_bullet_cooldown
    end

    game.ship.current_bullet_cooldown -= 1

    game.ship.x += ship_speed_x
    game.ship.y += ship_speed_y
end

function check_ship_limits()
    if (game.ship.x > 120) game.ship.x = 120
    if (game.ship.x < 0) game.ship.x = 0
    if (game.ship.y > 117) game.ship.y = 117
    if (game.ship.y < 0) game.ship.y = 0
end

function update_bullets()
    --updating bullets position

    --
    --[[
		This for loop runs backward,
		running loop backward is useful when deleting
		objects inside the array being looped
	]]
    for i = #game.ship.bullets, 1, -1 do
        game.ship.bullets[i].y -= 4
        game.ship.bullets[i].sprite = 16
        --deleting bullet if passes screen
        if (game.ship.bullets[i].y <= -8) del(game.ship.bullets, game.ship.bullets[i])
    end
end

function update_flames()
    game.ship.flamespr += 1
    if (game.ship.flamespr > 8) game.ship.flamespr = 5
end

function check_bullet_collision()
    for enemy in all(game.enemies) do
        for bullet in all(game.ship.bullets) do
            if is_colliding(enemy, bullet) then
                del(game.ship.bullets, bullet)
                enemy.hp -= 1
                
                --FX
                sfx(3)
                enemy.flashing = 2
                add_sparks_particles(enemy.x + 4, enemy.y + 4, 2)

                if enemy.hp <= 0 then
                    --FX
                    sfx(2)
                    add_big_shockwave_particle(enemy.x + 4, enemy.y + 4, { 7 })
                    add_explosion_particles(enemy.x + 4, enemy.y + 4, { 10, 10, 10, 9, 9, 8, 2, 5 }, 15)
                    add_sparks_particles(enemy.x + 4, enemy.y + 4, 30)

                    del(game.enemies, enemy)
                    game.score += 1
                end
            end
        end
    end
end