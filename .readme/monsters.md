This document describes different features of monsters.py and their effect.

# Supporter

server.js -> update_instance
if the monster has the .supporter property and the monster does not have any focus it will find a suitable monster (.humanoid currently) in 300 range and mark that monster as their focus, this focus will be used next tick

each tick the focus of a monster will be reset if the monster is gone or the distance is more than 380

if the monster has a focus, a `change` variable will be set. this triggers a stat calculation to change the speed of the monster

if a monster has the `healing` effect in .s and is closer than 120 to their .focus, it will heal the focus target for the `monster.a.healing.heal` amount .a is a shorthand for abilities.

a monsters abilities are automaticly added to the .s property if it has a cooldown (new_monster)

server.js -> attack_target_or_move
if distance is more than 40 and the monster is not moving, it will move towards the focus target

calculate_monster_stats
if a monster has focus, it's speed will be set to the .charge property.
later it's speed will be set to the minimum, it's own speed, or the speed of it's focus target + 4
