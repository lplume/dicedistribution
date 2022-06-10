--- dicedistribution Module.
-- @module dicedistribution
-- @author faildev
-- This module aims to implement dice rolls and offers a few shortcut.
-- It's an implementation of Probability and Games: Damage Rolls from Red Blob
-- Games (https://www.redblobgames.com/articles/probability/damage-rolls.html)

local randomseed, random = math.randomseed, math.random
local min, max = math.min, math.max

--- Seed the system
-- @function reseed
-- @param seed the seed. (Default: os.time())
local reseed = function (seed)
    seed = seed or os.time()
    randomseed(seed)
end

--- Roll a single dice.
-- Roll a single dice up to 'dice', optionally shifted by 'shift'.
-- @param dice dice max value
-- @param shift shifts the result of the roll. (Default: 0)
-- @return the rolled number
local roll_dice = function (dice, shift)
    shift = shift or 0
    return random(dice) + shift
end

--- Roll a single dice 'times' time and choose the max
-- Repeat the roll of the dice and return the max of the series.
-- Eventually shifted by 'shift'
-- @param dice dice max value
-- @param times how many rolls. (Dafault: 1)
-- @param shift shifts the result of the selected roll. (Default: 0)
-- @return the selected roll
local rollMaxOf = function (dice, times, shift)
    local roll = 0

    times = times or 1
    shift = shift or 0

    for _=1, times do
        dice = random(dice)
        roll = max(roll, dice)
    end

    return roll + shift
end

--- Roll a single dice 'times' time and choose the min
-- Repeat the roll of the dice and return the min of the series.
-- Eventually shifted by 'shift'
-- @param dice dice max value
-- @param times how many rolls. (Dafault: 1)
-- @param shift shifts the result of the selected roll. (Default: 0)
-- @return the selected roll
local rollMinOf = function (dice, times, shift)
    local roll = dice + 1

    times = times or 1
    shift = shift or 0

    for _=1, times do
        dice = random(dice)
        roll = min(roll, dice)
    end

    return roll + shift
end

--- Rolls a numbers of dice
-- Rolls 'times' times a dice and return a table of values.
-- Values is shifted by 'shift'.
-- @param dice dice max value
-- @param times how many rolls. (Default: 1)
-- @param shift shifts the result of the selected roll. (Default: 0)
-- @return the table of values
local roll_dices = function (dice, times, shift)
    local values = {}

    times = times or 1
    shift = shift or 0

    for _=1, times do
        local roll = roll_dice(dice, shift)
        table.insert(values, roll)
    end

    return values
end

--- Rolls a number of dices, each roll several times choosing the max
-- Rolls 'times' times a dice, each roll several 'rolls' times of wich choosing
-- the max. Values is shifted by 'shift'.
-- @param dice dice max value
-- @param times how many rolls. (Default: 1)
-- @param shift shifts the result of the selected roll. (Default: 0)
-- @return the table of values
local rollsMaxOf = function (dice, times, rolls, shift)
    local values = {}

    times = times or 1
    shift = shift or 0

    for _=1, times do
        local roll = rollMaxOf(dice, rolls, shift)
        table.insert(values, roll)
    end

    return values
end

--- Rolls a number of dices, each roll several times choosing the min
-- Rolls 'times' times a dice, each roll several 'rolls' times of wich choosing
-- the max. Values is shifted by 'shift'.
-- @param dice dice max value
-- @param times how many rolls. (Default: 1)
-- @param shift shifts the result of the selected roll. (Default: 0)
-- @return the table of values
local rollsMinOf = function (dice, times, rolls, shift)
    local values = {}

    times = times or 1
    shift = shift or 0

    for _=1, times do
        local roll = rollMinOf(dice, rolls, shift)
        table.insert(values, roll)
    end

    return values
end

--- Rolls a number of dice
-- Rolls 'times' times a dice and return a table of values.
-- Values is shifted by 'shift'.
-- @param dice dice max value
-- @param times how many rolls. (Default: 1)
-- @param shift shifts the result of the selected roll. (Default: 0)
-- @return the sum of the rolls
local rollsAndSum = function (dice, times, shift)
    local sum = 0

    shift = shift or 0
    times = times or 1

    for _=1, times do
        local roll = roll_dice(dice, shift)
        sum = sum + roll
    end

    return sum
end

--- Rolls a number of dices, each roll several times choosing the max
-- Rolls 'times' times a dice, each roll several 'rolls' times of wich choosing
-- the max. Values is shifted by 'shift'.
-- @param dice dice max value
-- @param times how many rolls. (Default: 1)
-- @param shift shifts the result of the selected roll. (Default: 0)
-- @return the sum of the rolls
local rollsMaxOfAndSum = function (dice, times, rolls, shift)
    local sum = 0

    shift = shift or 0
    times = times or 1

    for _=1, times do
        local roll = rollMaxOf(dice, rolls, shift)
        sum = sum + roll
    end

    return sum
end

--- Rolls a number of dices, each roll several times choosing the min
-- Rolls 'times' times a dice, each roll several 'rolls' times of wich choosing
-- the max. Values is shifted by 'shift'.
-- @param dice dice max value
-- @param times how many rolls. (Default: 1)
-- @param shift shifts the result of the selected roll. (Default: 0)
-- @return the sum of the rolls
local rollsMinOfAndSum = function (dice, times, rolls, shift)
    local sum = 0

    shift = shift or 0
    times = times or 1

    for _=1, times do
        local roll = rollMinOf(dice, rolls, shift)
        sum = sum + roll
    end

    return sum
end

local lookup_value = function (distribution, x)
    local cumulative_weight = 0

    for i=1, #distribution do
        local current = distribution[i]
        cumulative_weight = cumulative_weight + current[1]
        if x < cumulative_weight then
            return current[2]
        end
    end
end

--- Roll from a custom distribution
-- Roll a dice from a custom distribution. The distribution is a table in the
-- following format: {{weight1,value1}, ... ,{weight1,value1}}
-- @param distribution table of distributions {{weight1,value1}, ... ,{weight1,value1}}
local custom_distribution = function(distribution)
    local sum_of_weights = 0

    for i=1, #distribution do
        local current = distribution[i]
        sum_of_weights = sum_of_weights + current[1]
    end

    local x = random(sum_of_weights)

    return lookup_value(distribution, x)
end

return {
    reseed = reseed,
    roll = roll_dice,
    rollMaxOf = rollMaxOf,
    rollMinOf = rollMinOf,
    rolls = roll_dices,
    rollsMaxOf = rollsMaxOf,
    rollsMinOf = rollsMinOf,
    rollsAndSum = rollsAndSum,
    rollsMaxOfAndSum = rollsMaxOfAndSum,
    rollsMinOfAndSum = rollsMinOfAndSum,
    custom_distribution = custom_distribution
}