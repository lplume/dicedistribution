# Dice distribution

> Handy library written off Amit Patel's RedBlob Game blog post
> [Probability and Games: Damage Rolls](https://www.redblobgames.com/articles/probability/damage-rolls.html)

This library is my implementation (mostly 1:1 I would say) of a few handy functionalities about dice distribution. I highly reccomend heading over the blog post to read out the full thing.

## Installation

Download the libray and require it in you code


```lua
local dd = require('dicedistribution')
```

## Function

### `reseed(seed)`

(Re)Seed the system. `seed` parameter is optional, the default is `os.time()`

### `roll(dice, shift)`

Roll a single dice up to `dice` (maximum number), optionally shifted by `shift`.

```lua
-- roll a single d6
dd.roll(6)

-- roll a single d6 and add 1
dd.roll(6, 1)
```

### `rollMaxOf(dice, times, shift)`

Roll a single dice `times` time and choose the maximum, optionally shifted by `shift`.

```lua
-- roll 3 times a single d6 and choose the maximum of the three
dd.rollMaxOf(6, 3)

-- roll 3 times a single d6 and choose the maximum of the three and add 1
dd.rollMaxOf(6, 3, 1)
```

### `rollMinOf(dice, times, shift)`

Roll a single dice `times` time and choose the minimum, optionally shifted by `shift`.

```lua
-- roll 3 times a single d6 and choose the minimum of the three
dd.rollMinOf(6, 3)

-- roll 3 times a single d6 and choose the minimum of the three and add 1
dd.rollMinOf(6, 3, 1)
```

### `rolls(dice, times, shift)`

Rolls a number of dice, optionally shifted by `shift` and return a table with the values.

```lua
-- roll 3 times a single d6 and return a table
dd.rolls(6, 3)

-- returns {x1, x2, x3}

```

### `rollsMaxOf(dice, times, rolls, shift)

Rolls `times` times a dice, each roll several `rolls` times of which choosing the maximum and return the table of values. Optionally shifted by `shift`.

```lua
-- Roll a d6 2 times, choose the maximum: three times
dd.rollsMaxOf(6, 3, 2)

-- Roll a d6 2 times, choose the maximum and add 1: three times
dd.rollsMaxOf(6, 3, 2, 1)
```

### `rollsMinOf(dice, times, rolls, shift)`

Rolls `times` times a dice, each roll several `rolls` times of which choosing the minimum and return the table of values. Optionally shifted by `shift`.

```lua
-- Roll a d6 2 times, choose the minimum: three times
dd.rollsMinOf(6, 3, 2)

-- Roll a d6 2 times, choose the minimum and add 1: three times
dd.rollsMinOf(6, 3, 2, 1)
```

### `rollsAndSum(dice, times, shift)`

Same as `rolls`, but return the sum of the rolls instead.

### `rollsMaxOfAndSum`

Same as `rollsMaxOf`, but return the sum of the rolls instead.

### `rollsMinOfAndSum`

Same as `rollsMinOf`, but return the sum of the rolls instead.

### `custom_distribution(distribution)`

Roll a dice from a custom distribution. The distribution is a table in the
following format: {{weight1,value1}, ... ,{weight1,value1}}

```lua
local distribution = {{50, 1}, {50, 2}}

dd.custom_distribution(distribution)
-- return 50% 1 and 50% 2

```

## Similar

I actually remember after coding this there is something already out there, checkout [8bitskull/dicebag](https://github.com/8bitskull/dicebag).