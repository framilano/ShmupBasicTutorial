function update_enemies()
    for enemy in all(game.enemies) do
        enemy.y += enemy.speed
        if (enemy.y >= 128) enemy.y = -8
    end
end

function check_enemy_collision()
    for enemy in all(game.enemies) do
        if is_colliding(enemy, game.ship, 6)
                and game.ship.invul == 0 then
            game.ship.invul = 60
            game.lives -= 1
            sfx(1)
            if (game.lives <= 0) change_mode("over")
        end
    end
    -- decreasing invulnerability frames for each frame, stopping at 0
    if (game.ship.invul > 0) game.ship.invul -= 1
end

function spawn_enemy()
    for i = 1, 2 do
        new_enemy_0 = {
            x = flr(rnd(120)),
            y = -8,
            hp = 100,
            speed = 1,
            type = "green",
            flashing = 0,
            animation_timings = {0, 0, 0, 0}
        }
        add(game.enemies, new_enemy_0)
    end
end