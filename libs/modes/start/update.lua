function update_start()
    start.ship.y -= start.ship.speed
    if start.ship.y <= -8 then
        start.ship.y = 150
        start.ship.x = flr(rnd(120))
    end

    --animate flames
	start.ship.flamespr += 1
	if (start.ship.flamespr > 8) start.ship.flamespr = 5

    if btnp(4) or btnp(5) then
        change_mode_and_reset("game")
        change_mode("wave")
        add_timer({time=3, callback=change_mode, args={"game"}})
        add_timer({time=3, callback=spawn_wave, args = {}})
    end
end