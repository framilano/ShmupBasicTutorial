function update_wave()
    update_game()
end

levels = {
    {
        {"green", "green", "green", "green", "green", "green", "green", "green"},
        {"green", "green", "green", "green", "green", "green", "green", "green"},
        {"green", "green", "green", "green", "green", "green", "green", "green"},
        {"green", "green", "green", "green", "green", "green", "green", "green"}  
    },
    {
        {"brown", "purple", "purple", "purple", "purple", "purple", "purple", "brown"},
        {"brown", "purple", "purple", "purple", "purple", "purple", "purple", "brown"},
        {"brown", "purple", "purple", "green", "green", "purple", "purple", "brown"},
        {"", "grey", "grey", "grey", "grey", "grey", "grey", ""}  
    },
    {
        {"", "", "", "", "", "", "", ""},
        {"", "", "", "yellow", "yellow", "", "", ""},
        {"", "", "", "", "", "", "", ""},
        {"", "", "", "", "", "", "", ""},
    }
}

function spawn_wave()
    local level = levels[(game.wave - 1 ) % 3 + 1]

    for i=1,#level do
        for j=1,#level[i] do
            if (level[i][j] != "") spawn_enemy(level[i][j], j*16 - 12 , i * 12)
        end 
    end   
end

function next_wave()
    game.wave += 1
    change_mode("wave")
    add_timer({ time = 3, callback = change_mode, args = { "game" } })
    add_timer({ time = 3, callback = spawn_wave, args = {} })
end