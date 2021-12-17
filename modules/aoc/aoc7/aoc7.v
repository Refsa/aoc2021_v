module aoc7

import strconv
import arrays
import math.util

pub struct AOC7 {}

pub fn (aoc AOC7) run_p1(input []string) ?u64 {
	state := parse(input)?
	min := arrays.min(state)?
	max := arrays.max(state)?

	cost := gen_cost_p1(state, min, max)
	
	return u64(cost)
}

pub fn (aoc AOC7) run_p2(input []string) ?u64 {
	state := parse(input)?
	min := arrays.min(state)?
	max := arrays.max(state)?

	cost := gen_cost_p2(state, min, max)
	
	return u64(cost)
}

fn gen_cost_p1(state []int, min int, max int) int {
	mut min_cost := 1 << 30

	for j in min..max {
		mut tot := 0
		for s in state {
			tot += util.iabs(s - j)
		}
		min_cost = util.imin(min_cost, tot)
	}

	return min_cost
}

fn sum(num int) int {
	return (num * (num + 1)) / 2
}

fn gen_cost_p2(state []int, min int, max int) int {
	mut min_cost := 1 << 30

	for j in min..max {
		mut tot := 0
		for s in state {
			tot += sum(util.iabs(s - j))
		}
		min_cost = util.imin(min_cost, tot)
	}

	return min_cost
}

fn parse(input []string) ?[]int {
	return input[0].split(',').map(strconv.atoi(it)?)
}