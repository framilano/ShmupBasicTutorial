function draw_start()
    cls(1)
    spr(1, start.ship.x, start.ship.y)
    spr(start.ship.flamespr, start.ship.x, start.ship.y + 8)
    
    title_string = "vecho game demake"
    press_any_key_string = "press any key to start"
    print(title_string, 28, horizontal_center_text(title_string), 7)
    print(press_any_key_string, horizontal_center_text(press_any_key_string), 80, 12)

end