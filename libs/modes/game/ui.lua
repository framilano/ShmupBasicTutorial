function draw_lives()
    for i = 1, 3 do
        if game.lives >= i then
            spr(10, 88 + 10 * i, 2)
        else
            spr(11, 88 + 10 * i, 2)
        end
    end
end

function draw_score()
    print("score:" .. game.score, 2, 2, 12)
end