function update_over()
    
    if (btn(4) == false and btn(5) == false) btn_released = true
    if ((btnp(4) or btnp(5)) and btn_released) then
        change_mode_and_reset("start")
    end
end