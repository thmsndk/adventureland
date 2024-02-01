drops.py is responsible for the drops
you can configure

- map specific drops is an additional drop compared to the monster specific drop see server.js -> drop_something
- monster specific drops

the configuration is a tuple with a chance and an item. the item can also be a reference to a list of other items.
[chance, open, "dropKey"]
[chance, "itemKey"]

You can also bundle drops and refernce them

server.js drop_something loops the following and runs drop_item_logic for each

- D.drops.maps.global_static

```js
if (Math.random() / share / player.luckm / monster.luckx / global_mult < item[0] || mode.drop_all) {
	drop_item_logic(drop, item, is_in_pvp(player, 1));
}
```

- D.drops.maps.global

```js
if (Math.random() / share / player.luckm / hp_mult / monster.luckx / global_mult < item[0] || mode.drop_all) {
	drop_item_logic(drop, item, is_in_pvp(player, 1));
}
```

- D.drops.maps[monster.map]

```js
if (Math.random() / share / player.luckm / hp_mult / monster.luckx < item[0] || mode.drop_all) {
	drop_item_logic(drop, item, is_in_pvp(player, 1));
}
```

- D.drops.monsters[monster.type]

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
