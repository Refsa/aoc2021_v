module aoc7

import strconv
import arrays
import math.util

pub struct AOC7 {}

pub fn (aoc AOC7) run_p1(input []string) ?u64 {
	state := parse(input)?
	min := arrays.min(state)?
	max := arrays.max(state)?

	mut costs := gen_cost_p1(state, min, max).map(arrays.sum(it)?)
	costs.sort()
	
	return u64(costs[0])
}

pub fn (aoc AOC7) run_p2(input []string) ?u64 {
	state := parse(input)?
	min := arrays.min(state)?
	max := arrays.max(state)?

	mut costs := gen_cost_p2(state, min, max).map(arrays.sum(it)?)
	costs.sort()
	
	return u64(costs[0])
}

fn gen_cost_p1(state []int, min int, max int) [][]int {
	mut costs := [][]int{}

	for j in min..max {
		costs << state.map(util.iabs(it - j))
	}

	return costs
}

fn sum(num int) int {
	return (num * (num + 1)) / 2
}

fn gen_cost_p2(state []int, min int, max int) [][]int {
	mut costs := [][]int{}

	for j in min..max {
		costs << state.map(sum(util.iabs(it - j)))
	}

	return costs
}

fn parse(input []string) ?[]int {
	return input[0].split(',').map(strconv.atoi(it)?)
}