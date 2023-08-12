function init_game()
    game = {
        frame_counter = 0,
        score = 0,
        lives = 3,
        bombs = 1,
        ship = {
            x = 56,
            y = 56,
            muzzle = 0,
            flamespr = 4,
            sprite = 1,
            default_speed_x = 3,
            default_speed_y = 3,
            bullets = {},
            current_bullet_cooldown = -1,
            default_bullet_cooldown = 4,
            invul = 0
        },
        stars = {},
        enemies = {},
        explosions = {},
    }

    --Adding enemies
    spawn_enemy()

    --creating stars and adding stars to game
    add_stars()
end

function add_stars()
    for i = 1, 50 do
        new_star = {
            x = flr(rnd(128)),
            y = flr(rnd(128)),
            spd = rnd(1.5) + 0.4
        }
        add(game.stars, new_star)
    end
end