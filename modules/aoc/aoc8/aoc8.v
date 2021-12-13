module aoc8

import math

const (
	c_zero = [0, 1, 2, 4, 5, 6]
	c_one = [2, 5]
	c_two = [0, 2, 3, 4, 6]
	c_three = [0, 2, 3, 5, 6]
	c_four = [1, 2, 3, 5]
	c_five = [0, 1, 3, 5, 6]
	c_six = [0, 1, 3, 4, 5, 6]
	c_seven = [0, 2, 5]
	c_eight = [0, 1, 2, 3, 4, 5, 6]
	c_nine = [0, 1, 2, 3, 5, 6]
)

pub struct AOC8 {}

pub fn (aoc AOC8) run_p1(input []string) ?u64 {
	right := parse_p1(input)?

	mut sum := 0
	for r in right {
		sum += r.filter(it.len in [2, 3, 4, 7]).len
	}

	return u64(sum)
}

fn parse_p1(input []string) ?[][]string {
	mut output := [][]string{}

	for l in input {
		s := l.split(' | ')
		right := s[1].split(' ')

		output << right
	}

	return output
}

pub fn (aoc AOC8) run_p2(input []string) ?u64 {
	lines := parse_p2(input)?

	mut sum := 0
	for l in lines {
		sum += solve_line(l)?
	}

	return u64(sum)
}

fn to_digit(input []int) ?int {
	match input {
		c_zero { return 0 }
		c_one { return 1 }
		c_two { return 2 }
		c_three { return 3 }
		c_four { return 4 }
		c_five { return 5 }
		c_six { return 6 }
		c_seven { return 7 }
		c_eight { return 8 }
		c_nine { return 9 }
		else { return error('digit out of range') }
	}
}

fn to_segment_id(seg byte) int {
	return int(seg) - 97
}

fn solve_line(line &Line) ?int {
	lookup := solve_signal(line)

	mut num := 0

	for i, seg in line.right {
		mut digit := []int{}
		for d in seg.segs {
			digit << lookup.index(d)
		}
		digit.sort()
		d := to_digit(digit)?

		num += int(math.powi(10, 3 - i)) * d
	}

	return num
}

fn solve_signal(line &Line) []int {
	mut ordering := []int{len: 7, init: 255}
	mut counts := [][]int{len: 7}

	for i, d in line.left {
		for v in d.segs {
			counts[v] << i
		}
	}

	one := line.left.filter(it.segs.len == 2)[0]
	seven := line.left.filter(it.segs.len == 3)[0]
	eight := line.left.filter(it.segs.len == 7)[0]

	for i in 0..7 {
		match counts[i].len {
			4 { ordering[to_segment_id('e'[0])] = i }
			6 { ordering[to_segment_id('b'[0])] = i }
			9 { ordering[to_segment_id('f'[0])] = i }
			else {}
		}
	}

	b := ordering[to_segment_id('b'[0])]
	e := ordering[to_segment_id('e'[0])]
	f := ordering[to_segment_id('f'[0])]

	if f == one.segs[0] {
		ordering[to_segment_id('c'[0])] = one.segs[1]
	} else {
		ordering[to_segment_id('c'[0])] = one.segs[0]
	}
	c := ordering[to_segment_id('c'[0])]

	if (c == seven.segs[0] && f == seven.segs[1]) || (c == seven.segs[1] && f == seven.segs[0]) {
		ordering[to_segment_id('a'[0])] = seven.segs[2]
	} else if  (c == seven.segs[1] && f == seven.segs[2]) || (c == seven.segs[2] && f == seven.segs[1]) {
		ordering[to_segment_id('a'[0])] = seven.segs[0]
	} else if  (c == seven.segs[0] && f == seven.segs[2]) || (c == seven.segs[2] && f == seven.segs[0]) {
		ordering[to_segment_id('a'[0])] = seven.segs[1]
	}
	a := ordering[to_segment_id('a'[0])]

	mut known := [a, b, c, e, f]
	mut g_filter := [][]int{}
	for seg in line.left.filter(it.segs.len == 6) {
		g_filter << seg.segs.filter(it !in known)
	}
	
	g := g_filter.filter(it.len == 1)[0][0]
	ordering[to_segment_id('g'[0])] = g
	known.prepend(g)

	d := eight.segs.filter(it !in known)[0]
	ordering[to_segment_id('d'[0])] = d

	return ordering
}

struct Line {
	left []Segment
	right []Segment
}

struct Segment {
	segs []int
}

fn parse_p2(input []string) ?[]Line {
	mut output := []Line{}

	for l in input {
		s := l.split(' | ')
		left := s[0].split(' ')
			.map(Segment{
				segs: it.bytes().map(int(it - 97))
			})
		right := s[1].split(' ')
			.map(Segment{
				segs: it.bytes().map(int(it - 97))
			})

		line := Line {left: left, right: right}

		output << line
	}

	return output
}