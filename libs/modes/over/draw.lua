function draw_over()
    cls(1)
    spr(96, 50, 45, 2, 2)
    spr(97, 58, 45, 2, 2)

    local final_score_string = "final score: "..game.score
    local you_survived_string = "you survived for: "..game.wave.." waves"
    local press_any_key_string = "press any key to continue"
    print(final_score_string, horizontal_center_text(final_score_string), 20, 7)
    print(you_survived_string, horizontal_center_text(you_survived_string), 80, 7)
    print(press_any_key_string, horizontal_center_text(press_any_key_string), 100, blink())
end