timers = {}

function update_timers()
    for i = #timers, 1, -1 do
        timers[i].time -= 1
        if timers[i].time == 0 then
            timers[i].callback(unpack(timers[i].args))
            del(timers, timers[i])
        end
    end
end

function add_timer(timer)
    add(
        timers, {
            time = timer.time * 30,
            callback = timer.callback,
            args = timer.args
        }
    )
end