module aoc5

import strconv
import math
import math.util

pub struct AOC5 {}

pub fn (aoc AOC5) run_p1(input []string) ?u64 {
	lines := parse(input)?.filter(it.is_cardinal())
	max_x, max_y := find_max(lines)
	mut grid := make_grid(max_x, max_y)

	for line in lines {
		iter := new_line_iterator(line)
		for point in iter {
			grid.mark(point)
		}
	}

	return u64(grid.grid.filter(it >= 2).len)
}

pub fn (aoc AOC5) run_p2(input []string) ?u64 {
	lines := parse(input)?
	max_x, max_y := find_max(lines)
	mut grid := make_grid(max_x, max_y)

	for line in lines {
		iter := new_line_iterator(line)
		for point in iter {
			grid.mark(point)
		}
	}

	return u64(grid.grid.filter(it >= 2).len)
}

fn parse(input []string) ?[]Line {
	mut output := []Line{}

	for line in input {
		points := line.split(' -> ')

		a := parse_point(points[0])?
		b := parse_point(points[1])?

		output << Line {
			a: a,
			b: b
		}
	}

	return output
}

fn parse_point(input string) ?Point {
	pos := input.split(',')

	x := strconv.atoi(pos[0])?
	y := strconv.atoi(pos[1])?

	return Point {
		x: x,
		y: y
	}
}

struct Grid {
	width int
	height int
mut:
	grid []int
}

fn make_grid(width int, height int) Grid {
	grid := []int{len: height * width, init: 0}

	return Grid {
		width: width,
		height: height,
		grid: grid
	}
}

fn (mut grid Grid) mark(point Point) {
	idx := grid.to_idx(point)
	grid.grid[idx] += 1
}

fn (grid Grid) to_point(idx int) Point {
	return Point {
		x: idx / grid.height,
		y: idx % grid.height
	}
}

fn (grid Grid) to_idx(point Point) int {
	return grid.width * point.y + point.x
}

struct Point {
	x int
	y int
}

fn (point Point) sub(other Point) Point {
	return Point {
		x: point.x - other.x,
		y: point.y - other.y
	}
}

fn (point Point) add(other Point) Point {
	return Point {
		x: point.x + other.x,
		y: point.y + other.y
	}
}

fn (point Point) normalized() Point {
	len := int(math.sqrti(point.x * point.x + point.y * point.y))
	return Point {
		x: point.x / len,
		y: point.y / len
	}
}

fn (point Point) sign() Point {
	return Point {
		x: if point.x > 0 { 1 } else if point.x == 0 { 0 } else { -1 }
		y: if point.y > 0 { 1 } else if point.y == 0 { 0 } else { -1 }
	}
}

fn (point Point) equals(other Point) bool {
	return point.x == other.x && point.y == other.y
}

struct Line {
	a Point
	b Point
}

fn (line Line) is_cardinal() bool {
	return line.a.x == line.b.x || line.a.y == line.b.y
}

fn (line Line) is_vertical() bool {
	return line.a.x == line.b.x
}

fn (line Line) is_horizontal() bool {
	return line.a.y == line.b.y
}

fn find_max(lines []Line) (int, int) {
	mut max_x := 0
	mut max_y := 0

	for line in lines {
		max_x = util.imax(max_x, line.a.x)
		max_x = util.imax(max_x, line.b.x)

		max_y = util.imax(max_y, line.a.y)
		max_y = util.imax(max_y, line.b.y)
	}

	return max_x + 1, max_y + 1
}

struct LineIterator {
	end Point
	step Point
mut:
	idx Point
}

fn new_line_iterator(line Line) LineIterator {
	start := line.a
	end := line.b

	step := if line.is_cardinal() {
	 	end.sub(start).normalized()
	} else {
		end.sub(start).sign()
	}

	return LineIterator {
		end: end,
		idx: start,
		step: step
	}
}

fn (mut iter LineIterator) next() ?Point {
	if iter.idx.equals(iter.end.add(iter.step)) {
		return none
	}
	defer {
		iter.idx = iter.idx.add(iter.step)
	}

	return iter.idx
}