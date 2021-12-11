import os
import strconv

struct TestData {
	p1 int
	p2 int
	input []string
}

fn main() {
	mut runners := []Runner {}
	runners << AOC1{}

	if os.args.len < 2 {
		println('First argument should be day to run')
		return
	}

	day := strconv.atoi(os.args[1])?
	run_day(day, runners[day - 1])?
}

fn run_day(day int, runner Runner)? {
	test_txt := './resources/day${day}_test.txt'
	puzzle_txt := './resources/day${day}.txt'

	println(test_txt)

	test_input := os.read_lines(test_txt)?
	input := os.read_lines(puzzle_txt)?

	answers := split(test_input[0], ' '[0])
	test_data := TestData{
		strconv.atoi(answers[0])?, 
		strconv.atoi(answers[1])?, 
		test_input[2..]
	}

	{
		test_answer := runner.run_p1(test_data.input)?
		if test_answer != test_data.p1 {
			println('P1 Test Failed | Got $test_answer - expected $test_data.p1')
			return
		}
		println('P1 Test Success')

		answer := runner.run_p1(input)?
		println('P1 := $answer')
	}

	{
		test_answer := runner.run_p2(test_data.input)?
		if test_answer != test_data.p2 {
			println('P2 Test Failed | Got $test_answer - expected $test_data.p2')
			return
		}
		println('P2 Test Success')

		answer := runner.run_p2(input)?
		println('P2 := $answer')
	}
}