function add_explosion_particles(enemy_x, enemy_y, color_sequence, quantity)
    --Adding multiple particles, the first one has to be a big circle in the center
    for i = 1, quantity do
        add(
            game.particles, {
                x = enemy_x,
                y = enemy_y,
                speed_x = (rnd()-0.5) * 6,
                speed_y = (rnd()-0.5) * 6,
                current_age = 0,
                max_age = 10 + rnd(10),
                size = 3 + rnd(2),
                color_sequence = color_sequence,
                type = "explosion"
            }
        )
    end
end

function add_big_shockwave_particle(enemy_x, enemy_y, color_sequence)
    add(
        game.particles, {
            x = enemy_x,
            y = enemy_y,
            speed_x = 0,
            speed_y = 0,
            current_age = 0,
            max_age = 10,
            size = 1,
            color_sequence = color_sequence,
            type = "shockwave"
        }
    )
end

function add_sparks_particles(enemy_x, enemy_y, quantity)
    for i = 1, quantity do
        add(
            game.particles, {
                x = enemy_x,
                y = enemy_y,
                speed_x = (rnd()-0.5) * 12,
                speed_y = (rnd()-0.5) * 12,
                current_age = 0,
                max_age = 7 + rnd(10),
                type = "sparks"
            }
        )
    end
end