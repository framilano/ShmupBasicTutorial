enemies_descriptor = {
    green = {
        hp = 1,
        speed = 1,
        width = 8,
        height = 8,
        animation_counters = { 0, 0, 0, 0 },
        animation_description = {
            sprites = { 32, 33, 34, 35 },
            sizes = { { 1, 1 }, { 1, 1 }, { 1, 1 }, { 1, 1 } },
            limits = { 6, 6, 6, 6 }
        }
    },
    purple = {
        hp = 2,
        speed = 1,
        width = 8,
        height = 8,
        animation_counters = { 0, 0 },
        animation_description = {
            sprites = { 48, 49 },
            sizes = { { 1, 1 }, { 1, 1 }, { 1, 1 }, { 1, 1 } },
            limits = { 6, 6 }
        }
    },
    brown = {
        hp = 3,
        speed = 1,
        width = 6,
        height = 8,
        animation_counters = { 0, 0 },
        animation_description = {
            sprites = { 50, 51 },
            sizes = { { 1, 1 }, { 1, 1 }, { 1, 1 }, { 1, 1 } },
            limits = { 6, 6 }
        }
    },
    grey = {
        hp = 3,
        speed = 1.5,
        width = 8,
        height = 8,
        animation_counters = { 0, 0, 0, 0 },
        animation_description = {
            sprites = { 184, 185, 186, 187 },
            sizes = { { 1, 1 }, { 1, 1 }, { 1, 1 }, { 1, 1 } },
            limits = { 6, 6, 6, 6 }
        }
    },
    yellow = {
        hp = 5,
        speed = 1,
        width = 16,
        height = 16,
        animation_counters = { 0, 0 },
        animation_description = {
            sprites = { 208, 210 },
            sizes = { { 2, 2 }, { 2, 2 } },
            limits = { 10, 10 }
        }
    }
}

function update_enemies()
    for enemy in all(game.enemies) do
        --enemy.y += enemy.speed
        if (enemy.y >= 128) del(game.enemies, enemy)
        
    end
    
    -- if no enemies are in here, next wave
    if (#game.enemies == 0 and mode == "game") next_wave()
end

function check_enemy_collision()
    for enemy in all(game.enemies) do
        if is_colliding(enemy, game.ship) and game.ship.invul == 0 then
            add_explosion_particles(game.ship.x, game.ship.y, { 8 }, 20)
            game.ship.invul = 60
            game.lives -= 1
            sfx(1)
            if game.lives <= 0 then
                game.ship.invul = 90    --let's make it invulnerable so nothing happens before over screen
                add_big_shockwave_particle(game.ship.x, game.ship.y, { 8 })
                add_timer({
                    time = 3,
                    callback = change_mode_and_reset,
                    args = { "over" }
                })
            end
        end
    end
    -- decreasing invulnerability frames for each frame, stopping at 0
    if (game.ship.invul > 0) game.ship.invul -= 1
end

function spawn_enemy(enemy_type, enemy_x, enemy_y)
    add(
         game.enemies, {
            x = enemy_x,
            y = enemy_y,
            hp = enemies_descriptor[enemy_type].hp,
            speed = enemies_descriptor[enemy_type].speed,
            flashing = 0,
            width = enemies_descriptor[enemy_type].width,
            height = enemies_descriptor[enemy_type].height,
            collision_offset = enemies_descriptor[enemy_type].collision_offset,
            animation_counters = clone_table(enemies_descriptor[enemy_type].animation_counters),
            animation_description = enemies_descriptor[enemy_type].animation_description
        }
    )
end