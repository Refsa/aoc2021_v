module aoc9

import arrays

const cardinal_dirs = [Point{1, 0}, Point{0, 1}, Point{-1, 0}, Point{0, -1}]

pub struct AOC9 {}

pub fn (aoc AOC9) run_p1(input []string) ?u64 {
	mut grid := parse(input)

	low_points := grid.find_low_points().map(grid.grid[it.y][it.x] + 1)
	sum := arrays.sum(low_points)?

	return u64(sum)
}

pub fn (aoc AOC9) run_p2(input []string) ?u64 {
	mut grid := parse(input)

	mut basins := grid.find_low_points().map(grid.flood_fill(it))
	basins.sort(a > b)

	return u64(basins[0] * basins[1] * basins[2])
}

struct Point {
	x int
	y int
}

struct Grid {
	width int
	height int
	grid [][]int
}

fn (grid Grid) find_low_points() []Point {
	mut points := []Point{}

	for y in 0..grid.height {
		for x in 0..grid.width {
			curr := grid.grid[y][x]
			point := Point{x: x, y: y}
			mut lower := grid.get_neighbours(point)
				.map(grid.grid[it.y][it.x])
				.filter(it <= curr)
				.len

			if lower == 0 {
				points << point
			}
		}
	}

	return points
}

fn (grid Grid) get_neighbours(point Point) []Point {
	return cardinal_dirs
		.map(Point{x: point.x + it.x, y: point.y + it.y})
		.filter(it.x >= 0 && it.y >= 0 && it.x < grid.width && it.y < grid.height)
}

fn (grid Grid) flood_fill(point Point) int {
	mut open := []Point{}
	mut closed := []Point{}
	open << point

	for open.len != 0 {
		curr := open.pop()

		neighbours := grid.get_neighbours(curr)
			.filter(it !in closed)
			.filter(grid.grid[it.y][it.x] < 9)

		for n in neighbours {
			open.prepend(n)
			closed << n
		}
	}

	return closed.len
}

fn parse(input []string) Grid {
	return Grid{
		width: input[0].len
		height: input.len
		grid: input.map(it.bytes().map(int(it - 48)))
	}
}