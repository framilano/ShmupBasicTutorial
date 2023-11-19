function blink()
    if (sin(global_vars.frame_counter / 30) < 0.2) then
        return 6
    else
        return 7
    end
end

function horizontal_center_text(some_text)
    return flr((128-#some_text*4)/2)
end

function vertical_center_text(some_text)
    return 61
end
