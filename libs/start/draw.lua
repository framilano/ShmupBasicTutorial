function draw_start()
    cls(1)
    spr(1, start.ship.x, start.ship.y)
    spr(start.ship.flamespr, start.ship.x, start.ship.y + 8)
    
    print("vecho game demake", 28, 40, 7)
    print("press any key to start", 20, 80, 12)

end