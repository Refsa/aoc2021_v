module aoc

import aoc.aoc1
import aoc.aoc2
import aoc.aoc3
import aoc.aoc4
import aoc.aoc5
import aoc.aoc6
import aoc.aoc7
import aoc.aoc8
import aoc.aoc9

pub interface Runner {
	run_p1([]string) ?u64
	run_p2([]string) ?u64
}

pub fn get_runner(day int) ?Runner {
	match day {
		1 { return aoc1.AOC1{} }
		2 { return aoc2.AOC2{} }
		3 { return aoc3.AOC3{} }
		4 { return aoc4.AOC4{} }
		5 { return aoc5.AOC5{} }
		6 { return aoc6.AOC6{} }
		7 { return aoc7.AOC7{} }
		8 { return aoc8.AOC8{} }
		9 { return aoc9.AOC9{} }
		else { return error('Runner for day $day not implemented') }
	}
}
