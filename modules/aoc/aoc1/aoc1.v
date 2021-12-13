module aoc1

import arrays
import strconv

pub struct AOC1 { }

pub fn (aoc AOC1) run_p1 (input []string) ?u64 {
	parsed := input.map(strconv.atoi(it)?)

	increases := arrays.window<int>(parsed, size: 2).filter(it[1] > it[0])
	return u64(increases.len)
}

pub fn (aoc AOC1) run_p2 (input []string) ?u64 {
	parsed := input.map(strconv.atoi(it)?)

	sums := arrays.window<int>(parsed, size: 3).map(it[0] + it[1] + it[2])
	increases := arrays.window<int>(sums, size: 2).filter(it[1] > it[0])

	return u64(increases.len)
}