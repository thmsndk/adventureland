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

The list of `aggressives` is looped for each player, if the player is in front of the player, or the monster can attack the player, they will start attacking the player

`aggressives` is populated in `update_instance` if the monsters `aggro` property is more than 0.99 it is considered aggressive, else it has a chance of being aggressive
```ts
if (
	!monster.pet &&
	!monster.trap &&
	mode.aggro &&
	!monster.target &&
	monster.aggro &&
	can_attack(monster, "aggro")
) {
	monster.last_aggro = new Date();
	if (monster.aggro > 0.99 || Math.random() < monster.aggro) {
		set_ghash(aggressives, monster, 32);
	}
}
```

`update_instance` will loop the following list of aggressives
`var l = get_nearby_ghash(aggressives, player, 32);`
`32` is what is considered a `zone` and is used with `ghash` to generate a hash that can be looked up in aggressives

```ts
function ghash(entity, zone, a_d, b_d) {
	//zone is the square's dimension, a_d, and b_d are displacements
	var a = floor((1.0 * entity.x) / zone) + (a_d || 0);
	var b = floor((1.0 * entity.y) / zone) + (b_d || 0);
	return a + "|" + b;
}
```

There is a little tiein to the .rage property of monsters here. if the following evaluates to true, the agressive monster will also target the player

```ts
player.aggro_diff = player.bling / 100 - player.cuteness / 100;
if (monster.rage && Math.random() < monster.rage - player.aggro_diff) {
	target_player(monster, player);
}
```

## player.aggro_def
Sure! Let's break down the `aggro_diff` calculation step by step.

Here's the formula:

```javascript
player.aggro_diff = player.bling / 100 - player.cuteness / 100;
```

This formula determines a value `aggro_diff` based on two attributes of the player: `bling` and `cuteness`. Both attributes are divided by 100 and then subtracted from each other.

Let's analyze the effect of `bling` and `cuteness`:

1. **Bling**: This represents some form of status, wealth, or attractiveness related to the player's appearance or possessions.
2. **Cuteness**: This represents how cute or adorable the player is perceived to be.

The division by 100 normalizes these attributes, scaling them down to a range that impacts the calculation proportionately.

### Impact of `bling` and `cuteness` on `aggro_diff`

- **When `bling` is high and `cuteness` is low**:
  - `player.bling / 100` will be a larger value.
  - `player.cuteness / 100` will be a smaller value.
  - The result of the subtraction (`bling/100 - cuteness/100`) will be positive, resulting in a higher `aggro_diff`.

- **When `bling` is low and `cuteness` is high**:
  - `player.bling / 100` will be a smaller value.
  - `player.cuteness / 100` will be a larger value.
  - The result of the subtraction (`bling/100 - cuteness/100`) will be negative, resulting in a lower `aggro_diff`.

- **When both `bling` and `cuteness` are equal**:
  - Both `player.bling / 100` and `player.cuteness / 100` will be the same.
  - The result of the subtraction (`bling/100 - cuteness/100`) will be zero, resulting in an `aggro_diff` of 0.

### Interpretation of `aggro_diff`

- **Positive `aggro_diff`**: Indicates that the player has more `bling` relative to their `cuteness`. This might suggest that the player is more attention-grabbing or intimidating due to their wealth/status.
- **Negative `aggro_diff`**: Indicates that the player has more `cuteness` relative to their `bling`. This might suggest that the player is more endearing or non-threatening.
- **Zero `aggro_diff`**: Indicates a balance between `bling` and `cuteness`, suggesting a neutral or balanced perception.

In summary, the `aggro_diff` calculation helps quantify the difference in the player's perceived status/attractiveness (bling) versus their cuteness. The resulting value indicates whether the player is more likely to attract attention due to their bling or be perceived as cute and non-threatening.

### Impact of `aggro_diff` on the Logic

- **Positive `aggro_diff`**:
  - Increases the chance that `Math.random() < player.aggro_diff` will be true, leading to an early return and no further action. This makes it less likely for the player to be targeted by the monster.
  - Decreases the value of `monster.rage - player.aggro_diff`, making it less likely that `Math.random() < monster.rage - player.aggro_diff` will be true, further reducing the chances of the player being targeted.

- **Negative `aggro_diff`**:
  - Decreases the chance that `Math.random() < player.aggro_diff` will be true, making it more likely for the code to proceed to the second `if` statement.
  - Increases the value of `monster.rage - player.aggro_diff`, making it more likely that `Math.random() < monster.rage - player.aggro_diff` will be true, increasing the chances of the player being targeted.

### Summary

- The **first `if` statement** uses `player.aggro_diff` to determine if the function should exit early, with a higher `aggro_diff` increasing the likelihood of an early exit.
- The **second `if` statement** uses `monster.rage` adjusted by `player.aggro_diff` to determine if the monster should target the player. A higher `aggro_diff` reduces the likelihood of being targeted.

In essence, a player with higher `bling` relative to `cuteness` (positive `aggro_diff`) is less likely to be targeted by the monster, while a player with higher `cuteness` relative to `bling` (negative `aggro_diff`) is more likely to be targeted.

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
