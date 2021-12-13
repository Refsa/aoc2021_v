module aoc10

import arrays
import utils.collections

pub struct AOC10 {}

pub fn (aoc AOC10) run_p1(input []string) ?u64 {
	parsed := parse(input).map(score_corrupted(it))

	return u64(arrays.sum(parsed)?)
}

pub fn (aoc AOC10) run_p2(input []string) ?u64 {
	mut parsed := parse(input).map(score_incomplete(it)).filter(it > 0)
	parsed.sort()

	return u64(parsed[parsed.len / 2])
}

fn score_corrupted(input []Bracket) int {
	mut st := collections.new_stack<Bracket>()

	for v in input {
		match v {
			Opening { st.push(Bracket(v)) }
			Closing {
				if !is_matching(st.peek() or { Closing{-1} }, v) {
					return score_lookup_p1[Bracket(v).get()]
				}
				st.pop() or {}
			}
		}
	}

	return 0
}

fn score_incomplete(input []Bracket) int {
	mut st := collections.new_stack<Bracket>()

	for v in input {
		match v {
			Opening { st.push(Bracket(v)) }
			Closing {
				if !is_matching(st.peek() or { Closing{-1} }, v) {
					return 0
				}
				st.pop() or {}
			}
		}
	}

	mut score := 0
	for n in st {
		score = (5 * score) + score_lookup_p2[n.get()]
	}
	
	return score
}

fn is_matching(open Bracket, close Bracket) bool {
	return (close.get() - 1) == open.get()
}

struct Opening {
	t int
}
struct Closing {
	t int
}

type Bracket = Opening | Closing
fn (bracket Bracket) get() int {
	return match bracket {
		Opening { bracket.t }
		Closing { bracket.t }
	}
}

fn parse(input []string) [][]Bracket {
	return input.map(it.bytes().map(parse_bracket(it)))
}

fn parse_bracket(input byte) Bracket {
	ident := bracket_lookup[input]
	if ident % 2 == 0 {
		return Opening{ident}
	} else {
		return Closing{ident}
	}
}

const (
	bracket_lookup = {
		'('[0]: 0
		')'[0]: 1

		'['[0]: 2
		']'[0]: 3

		'{'[0]: 4
		'}'[0]: 5

		'<'[0]: 6
		'>'[0]: 7
	}

	bracket_rev_lookup = {
		0: '('
		1: ')'

		2: '['
		3: ']'

		4: '{'
		5: '}'

		6: '<'
		7: '>'
	}

	score_lookup_p1 = {
		1: 3
		3: 57
		5: 1197
		7: 25137
	}

	score_lookup_p2 = {
		0: 1
		2: 2
		4: 3
		6: 4
	}
)