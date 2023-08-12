function blink()
    local blinkcolors = { 5, 5, 5, 6, 6, 7, 7, 6, 6, 5, 5, 5 }
    if (blinkt > #blinkcolors) blinkt = 1
    return blinkcolors[blinkt]
end