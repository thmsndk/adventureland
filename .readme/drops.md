drops.py is responsible for the drops
you can configure

- map specific drops is an additional drop compared to the monster specific drop see server.js -> drop_something
- monster specific drops

the configuration is a tuple with a chance and an item. the item can also be a reference to a list of other items.
[chance, open, "dropKey"]
[chance, "itemKey"]

You can also bundle drops and refernce them

server.js drop_something loops the following and runs drop_item_logic for each

## drop_something(player, monster, share)

This method is responsible for calculating a drop/chest that will spawn on the monsters current position.
both `gold`, `egold` is set, no idea what egold is though

There are X pools items can drop from.

- While not in konami mode

  - D.drops.maps.global_static if `B.global_drops` is enabled (default: true)
  - D.drops.maps.global if `B.global_drops` is enabled (default: true)
  - D.drops.maps[monster.map]
  - D.drops.monsters[monster.type]
  - monster.drops
    - not sure what this is, but it seems like "hidden" server side drops, needs to be researched

- While in konami mode
  - D.drops.konami

For each item in each drop pool `drop_item_logic` will be called if the `Math.random` roll succeeds.
So for each item in the drop table, you will have a chance for rolling a successfull drop

This method is used

- in `issue_monster_award`
- if the monster is `cooperative` it will call `issue_monster_awards` and nothing else
- else it will call `drop_something` and something with stats calculations
- in `issue_monster_awards`
- if your share is bigger than 0.0025
  \_ in `complete_attack` if the target has `.drop_on_hit`

If monster has the `1hp` attribute the `global_mult` will be multiplied by `1000`

`hp_mult = 1` by default, `drop_norm` is 1000 `hp_mult` will be modified by the monsters max health `hp_mult = monster.max_hp / drop_norm;`

`monster.luckx = 1` when a monster changes level `monster.luckx += 0.25 * mult` mult is a modifier that is 1 when the monster levels up and -1 if the monster delevels

TODO: section about `gold` and `egold`

TODO: perhaps we can write a loot drop simulator where you can plug in the items and see the result of N kills

- player.luckm is 1 by default this can be increased to more than 1

### D.drops.maps.global_static

```js
if (Math.random() / share / player.luckm / monster.luckx / global_mult < item[0] || mode.drop_all) {
	drop_item_logic(drop, item, is_in_pvp(player, 1));
}
```

### D.drops.maps.global

```js
if (Math.random() / share / player.luckm / hp_mult / monster.luckx / global_mult < item[0] || mode.drop_all) {
	drop_item_logic(drop, item, is_in_pvp(player, 1));
}
```

### D.drops.maps[monster.map]

```js
if (Math.random() / share / player.luckm / hp_mult / monster.luckx < item[0] || mode.drop_all) {
	drop_item_logic(drop, item, is_in_pvp(player, 1));
}
```

### D.drops.monsters[monster.type]

```js
if (
	((!monster.temp || item[0] > 0.00001) &&
		Math.random() / share / player.luckm / monster.level / monster_mult < item[0]) ||
	mode.drop_all
) {
	// /hp_mult - removed [13/07/18]
	drop_item_logic(drop, item, is_in_pvp(player, 1));
}
```

Konami mode

# drop_one_thing(player, items, args)

This method is responsible for

- dropping essenceoflife when healing ghosts
- dropping S.mics.spares with the `give spares` command in cyberland
