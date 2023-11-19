function init_game()
    game = {
        wave = 1,
		score = 0,
        lives = 3,
        bombs = 1,
        ship = {
            x = 56,
            y = 100,
            width = 8,
            height = 8,
            flamespr = 4,
            muzzleflash = false,
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
        particles = {}
    }

    --Stops the music, 3000 milliseconds fading out
    music(-1, 2000)
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