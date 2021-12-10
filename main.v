import os
import strconv

struct TestData {
	p1 int
	p2 int
	input []string
}

fn main() {
	test_input := os.read_lines("./resources/day1_test.txt")?
	input := os.read_lines("./resources/day1.txt")?

	answers := split(test_input[0], ' '[0])
	test_data := TestData{
		strconv.atoi(answers[0])?, 
		strconv.atoi(answers[1])?, 
		test_input[2..]
	}

	{
		test_answer := aoc1_p1(test_data.input)?
		if test_answer != test_data.p1 {
			println('P1 Test Failed | Got $test_answer - expected $test_data.p1')
			return
		}
		println('P1 Test Success')

		answer := aoc1_p1(input)?
		println('P1 := $answer')
	}

	{
		test_answer := aoc1_p2(test_data.input)?
		if test_answer != test_data.p2 {
			println('P2 Test Failed | Got $test_answer - expected $test_data.p2')
			return
		}
		println('P2 Test Success')

		answer := aoc1_p2(input)?
		println('P2 := $answer')
	}
}