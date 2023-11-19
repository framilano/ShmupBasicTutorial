function draw_game()
    cls()

    --draw stars
    starfield()

    --ship and flame
    draw_ship_and_flame()

    --bullets
    draw_bullets()

    --muzzleflash
    draw_muzzleflash()

    --drawing particles
    draw_explosion_particles()
    draw_shockwave_particle()
    draw_sparks_particles()

    --enemies
    draw_enemies()

    ---ui---
    draw_lives()
    draw_score()
end

function draw_ship_and_flame()
    if (game.lives <= 0) return
    if game.ship.invul <= 0 then
        spr(game.ship.sprite, game.ship.x, game.ship.y)
        spr(game.ship.flamespr, game.ship.x, game.ship.y + 8)
    else
        --
        --[[
            Using sin function on framecounter to create a consistent timing
            Dividing by 3 because sin of an integer is always 0, so dividing
            by 3 we're obtaining float numbers that give us numbers between -1 and 1
            If the ship is in invulnerability state then the ship has to blink
        ]]
        if sin(global_vars.frame_counter / 3) < 0 then
            for i = 1, 15 do
                pal(i, 7)
            end
            spr(game.ship.sprite, game.ship.x, game.ship.y)
            spr(game.ship.flamespr, game.ship.x, game.ship.y + 8)
            pal()
        end
    end
end

function draw_muzzleflash()
    local color = 9
    if (game.ship.invul > 0) color = 7
    if(game.ship.muzzleflash) then
        pset(game.ship.x, game.ship.y + 1, color)
        pset(game.ship.x+1,game.ship.y, color)
        pset(game.ship.x+6, game.ship.y, color)
        pset(game.ship.x+7,game.ship.y+1, color)
        game.ship.muzzleflash = false
    end
end

function starfield()
    for i = 1, #game.stars do
        local scol = 6

        --setting slower stars colors
        if game.stars[i].spd < 1.5 then
            scol = 13
        end
        if game.stars[i].spd < 1 then
            scol = 1
        end

        --setting star px position
        if game.stars[i].spd > 1.5 then
            --setting as line not a px
            --if star is fast
            line(
                game.stars[i].x, game.stars[i].y,
                game.stars[i].x, game.stars[i].y - 2,
                scol
            )
        else
            pset(game.stars[i].x, game.stars[i].y, scol)
        end
        --setting speed
        game.stars[i].y += game.stars[i].spd

        --resetting position
        --when reacing bottom
        if game.stars[i].y > 127 then
            game.stars[i].y = 0
            game.stars[i].x = flr(rnd(128))
        end
    end
end

function draw_bullets()
    for i = 1, #game.ship.bullets do
        if game.ship.bullets[i].type == "normal" then
            spr(game.ship.bullets[i].sprite, game.ship.bullets[i].x, game.ship.bullets[i].y)
        end
    end
end

function draw_enemies()
    for enemy in all(game.enemies) do
        if enemy.flashing > 0 then
            enemy.flashing -= 1
            for i = 1, 15 do
                pal(i, 7)
            end
        end
        draw_entity_animation(enemy, enemy.animation_description, true)
        pal()
    end
end

---PARTICLES

function draw_explosion_particles()
    for particle in all(game.particles) do
        if (particle.type != "explosion") goto continue 
        local current_color = get_color_by_age(particle.current_age, particle.max_age, particle.color_sequence)
        circfill(particle.x, particle.y, particle.size, current_color)

        --slowing down speed
        particle.speed_x *= 0.9
        particle.speed_y *= 0.9

        particle.x += particle.speed_x
        particle.y += particle.speed_y
        particle.current_age += 1

        if particle.current_age > particle.max_age then
            particle.size -= 0.5
            if (particle.size <= 0) del(game.particles, particle)
        end

        ::continue::
    end
end

function draw_shockwave_particle()
    for particle in all(game.particles) do
        if (particle.type != "shockwave") goto continue 
        local current_color = get_color_by_age(particle.current_age, particle.max_age, particle.color_sequence)
        circ(particle.x, particle.y, particle.size, current_color)

        --slowing down speed
        particle.speed_x *= 0.9
        particle.speed_y *= 0.9

        particle.x += particle.speed_x
        particle.y += particle.speed_y
        particle.current_age += 1

        particle.size += 2

        if particle.current_age > particle.max_age then
            del(game.particles, particle)
        end

        ::continue::
    end
end

function draw_sparks_particles()
    for particle in all(game.particles) do
        if (particle.type != "sparks") goto continue 
        pset(particle.x, particle.y, 7)

        --slowing down speed
        particle.speed_x *= 0.9
        particle.speed_y *= 0.9

        particle.x += particle.speed_x
        particle.y += particle.speed_y
        particle.current_age += 1

        if particle.current_age > particle.max_age then
            del(game.particles, particle)
        end

        ::continue::
    end
end

function get_color_by_age(current_age, max_age, color_sequence)
    local dividers = max_age / #color_sequence

    --For objects that have max age as 0
    if (dividers == 0) return color_sequence[1]
    if (current_age > max_age) return color_sequence[#color_sequence]
    local i = 1
    while true do
        if (i * dividers >= current_age) return color_sequence[i] 
        i += 1
    end
end

function draw_entity_animation(entity_to_animate, animations_info, loop)
    should_loop = loop or false

    for i = 1, #animations_info.sprites do
        while entity_to_animate.animation_counters[i] < animations_info.limits[i] do
            spr(
                animations_info.sprites[i],
                entity_to_animate.x,
                entity_to_animate.y,
                animations_info.sizes[i][1],
                animations_info.sizes[i][2]
            )
            entity_to_animate.animation_counters[i] += 1
            return "still_animating"
        end
    end

    if should_loop then
        --Reset timings animation
        for i = 1, #entity_to_animate.animation_counters do
            entity_to_animate.animation_counters[i] = 0
        end

        --Do the first animation frame, so it doesn't blink
        spr(
            animations_info.sprites[1],
            entity_to_animate.x,
            entity_to_animate.y,
            animations_info.sizes[1][1],
            animations_info.sizes[1][2]
        )
        entity_to_animate.animation_counters[1] += 1
    else
        return "done"
    end
end