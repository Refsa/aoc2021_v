module aoc1

import arrays
import strconv

pub struct AOC1 { }

pub fn (aoc AOC1) run_p1 (input []string) ?u64 {
	parsed := input.map(strconv.atoi(it)?)

	// return arrays.window<int>(parsed, size: 2).filter(it[1] > it[0]).len
	
	mut increases := 0
	for v in arrays.window<int>(parsed, size: 2) {
		if v[1] > v[0] {
			increases += 1
		}
	}
	return u64(increases)
}

pub fn (aoc AOC1) run_p2 (input []string) ?u64 {
	parsed := input.map(strconv.atoi(it)?)

	sums := arrays.window<int>(parsed, size: 3).map(it[0] + it[1] + it[2])

	mut increases := 0
	for v in arrays.window<int>(sums, size: 2) {
		if v[1] > v[0] {
			increases += 1
		}
	}
	return u64(increases)
}