This document describes different features of monsters.py and their effect.

# Aggro

0.5, // 50% chance to attack on sight

If a monster has .aggro a .last_aggro date is set when the monster is created (new_monster)

server.js -> update_instance
if a monster is not a pet, a trap and mode.aggro is enabled `can_attack(monster, "aggro")` will run

```ts
if (player == "aggro") {
	return (
		mssince(monster.last_aggro) > max(1200, 1200 / monster.frequency) &&
		mssince(monster.last.attack) > 1000 / monster.frequency
	);
} //aggro check is arbitrary
```

last_aggro will be updated.
if the following is true `monster.aggro > 0.99 || Math.random() < monster.aggro` the monster is added to a list of agressives

The list of agressives is looped for each player, if the player is in front of the player, or the monster can attack the player, they will start attacking the player

There is a little tiein to the .rage property of monsters here. if the following evaluates to true, the agressive monster will also target the player

```ts
player.aggro_diff = player.bling / 100 - player.cuteness / 100;
if (monster.rage && Math.random() < monster.rage - player.aggro_diff) {
	target_player(monster, player);
}
```

# Rage

0.5, // 50% chance to target the player on attack

## Rage boundaries

The `rage_logic` function looks at the last_rage in the instance, raging can only occur every 4200 ms

it also looks at a rage_list that is populated by rage zones in the map defined by spawn boundaries

if player.aggro_diff is 1+ rage will never happen

# Supporter

server.js -> update_instance
if the monster has the .supporter property and the monster does not have any focus it will find a suitable monster (.humanoid on both supporter and other monster currently) in 300 range and mark that monster as their focus, this focus will be used next tick

each tick the focus of a monster will be reset if the monster is gone or the distance is more than 380

if the monster has a focus, a `change` variable will be set. this triggers a stat calculation to change the speed of the monster

if a monster has the `healing` effect in .s and is closer than 120 to their .focus, it will heal the focus target for the `monster.a.healing.heal` amount .a is a shorthand for abilities.

a monsters abilities are automaticly added to the .s property if it has a cooldown (new_monster)

server.js -> attack_target_or_move
if distance is more than 40 and the monster is not moving, it will move towards the focus target

calculate_monster_stats
if a monster has focus, it's speed will be set to the .charge property.
later it's speed will be set to the minimum, it's own speed, or the speed of it's focus target + 4
