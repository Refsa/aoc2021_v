module aoc4

import arrays
import strconv

pub struct AOC4 {}

pub fn (aoc AOC4) run_p1(input []string) ?u64 {
	draws, mut boards := parse(input)?

	for draw in draws {
		for mut board in boards {
			if board.check_num(draw) {
				if sum := board.check_bingo() {
					return sum * u64(draw)
				}
			}
		}
	}

	return none
}

pub fn (aoc AOC4) run_p2(input []string) ?u64 {
	draws, mut boards := parse(input)?

	for boards.len > 1 {
		for draw in draws {
			for i := boards.len - 1; i >= 0; i -= 1 {
				if !boards[i].check_num(draw) { continue }
				if sum := boards[i].check_bingo() {
					boards.delete(i)
					if boards.len == 0 {
						return sum * u64(draw)
					}
				}
			}
		}
	}

	return none
}

fn parse(input []string) ?([]int, []Board) {
	mut draws := []int{}

	for d in input[0].split(',') {
		draws << strconv.atoi(d)?
	}

	mut boards := []Board{}

	for b in arrays.chunk(input[1..], 6) {
		mut data := [25]int{}

		for i in 0..5 {
			rsplit := b[i + 1].split(' ').filter(it != '')
			for j in 0..5 {
				val := strconv.atoi(rsplit[j].trim_space())?
				data[j + i * 5] = val
			}
		}

		boards << Board{data, [25]int{init: 0}}
	}

	return draws, boards
}

struct Board {
	data [25]int
mut:
	marks [25]int
}

fn (mut board Board) check_num(num int) bool {
	for i in 0..25 {
		if board.data[i] == num {
			board.marks[i] = 1
			return true
		}
	}

	return false
}

fn (board Board) check_bingo() ?u64 {
	for hor in arrays.chunk(board.marks[..], 5) {
		h_bingo := arrays.sum(hor)?
		if h_bingo == 5 {
			return board.sum_unmarked()
		}
	}

	for x in 0..5 {
		mut v_bingo := 0
		for y := 0; y < 25; y += 5 {
			v_bingo += board.marks[y + x]
		}
		if v_bingo == 5 {
			return board.sum_unmarked()
		}
	}

	return none
}

fn (board Board) sum_unmarked() u64 {
	mut sum := 0
	for i in 0..25 {
		if board.marks[i] == 0 {
			sum += board.data[i]
		}
	}

	return u64(sum)
}