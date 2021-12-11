import arrays
import strconv

pub struct AOC2 { }

pub fn (aoc AOC2) run_p1 (input []string) ?u64 {
	parsed := parse(input)?

	mut pos := 0
	mut depth := 0

	for p in parsed {
		match p {
			Forward {
				pos += p.value
			}
			Up {
				depth -= p.value
			}
			Down {
				depth += p.value
			}
			Unknown {}
		}
	}

	return u64(pos * depth)
}

pub fn (aoc AOC2) run_p2 (input []string) ?u64 {
	parsed := parse(input)?
	
	mut pos := 0
	mut depth := 0
	mut aim := 0

	for p in parsed {
		match p {
			Forward {
				pos += p.value
				depth += aim * p.value
			}
			Up {
				aim -= p.value
			}
			Down {
				aim += p.value
			}
			Unknown {}
		}
	}

	return u64(pos * depth)
}

fn parse(input []string) ?[]Direction {
	mut output := []Direction{}

	for l in input {
		lr := split(l, ' '[0])
		value := strconv.atoi(lr[1])?

		item := match lr[0] {
			'forward' { Direction(Forward{value}) }
			'up' 	  { Direction(Up{value}) }
			'down' 	  { Direction(Down{value}) }
			else { Direction(Unknown{}) }
		}

		output << item
	}

	return output
}

type Direction = Forward | Up | Down | Unknown

struct Unknown {}

struct Forward {
	value int
}

struct Up {
	value int
}

struct Down {
	value int
}