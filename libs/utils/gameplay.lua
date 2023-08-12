--All sprites are 8 px width and height? For now yes
function is_colliding(entity_one, entity_two, collision_offset)
	if abs(entity_one.x - entity_two.x) <= collision_offset
			and abs(entity_one.y - entity_two.y) <= collision_offset then
		return true
	end
	return false
end