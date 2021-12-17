import os
import strconv
import benchmark
import time
import term

import aoc

pub struct TestData {
	p1 i64
	p2 i64
	input []string
}

fn main() {
	if os.args.len < 2 {
		println(term.warn_message('First argument should be day to run'))
		return
	}

	// Args
	is_bench := os.args.len > 2 && os.args[2] == 'bench'
	bench_runs := if os.args.len > 3 {
		strconv.atoi(os.args[3])?
	} else {
		1_000
	}
	day := strconv.atoi(os.args[1])?

	// Data
	runner := aoc.get_runner(day) or {
		println(term.fail_message('$err'))
		return
	}
	test_data := get_test_input(day) or {
		println(term.fail_message('$err'))
		return
	}
	input := get_input(day) or {
		println(term.fail_message('$err'))
		return
	}
	
	term.clear()
	// Part 1
	{
		println(term.header_left('Day $day - Part 1', '_'))
		test_p1(test_data, runner) or {
			println(term.fail_message('$err'))
			return
		}

		if is_bench {
			mut bench := benchmark.new_benchmark()
			for _ in 0..bench_runs {
				bench.step()
				_ := runner.run_p1(input) or {
					bench.fail()
					continue
				}
				bench.ok()
			}
			print_bench(bench)
		} else {
			print_result(runner.run_p1(input)?)
		}
	}

	println('')

	// Part 2
	{
		println(term.header_left('Day $day - Part 2', '_'))
		test_p2(test_data, runner) or {
			println(term.fail_message('$err'))
			return
		}

		if is_bench {
			mut bench := benchmark.new_benchmark()
			for _ in 0..bench_runs {
				bench.step()
				_ := runner.run_p2(input) or {
					bench.fail()
					continue
				}
				bench.ok()
			}
			print_bench(bench)
		} else {
			print_result(runner.run_p2(input)?)
		}
	}
}

fn print_bench(bench benchmark.Benchmark) {
	tot_dur := format_time(bench.bench_timer, bench.nok)
	runs := term.green('$bench.nok')
	dur := term.green('${tot_dur}')
	println('Benchmark | Runs: $runs | Time: $dur')
}

fn format_time(sw time.StopWatch, div int) string {
	mut tot_dur := f64(sw.elapsed().nanoseconds()) / f64(div)
	mut w := 0
	for tot_dur > 1000.0 {
		w += 1
		tot_dur /= 1000.0
		if w == 3 {
			break
		}
	}
	id := match w {
		0 {'ns'}
		1 {'µs'}
		2 {'ms'}
		else {'s'}
	}

	return '${tot_dur:4.2f}${id}'
}

fn print_result(result u64) {
	label_c := term.bold('Result')
	result_c := term.white('$result')

	println('$label_c := $result_c')
}

fn get_test_input(day int) ?TestData {
	test_txt := './resources/day${day}_test.txt'
	test_input := os.read_lines(test_txt)?

	answers := test_input[0].split(' ')
	answer_p1 := strconv.parse_int(answers[0], 10, 64)?
	answer_p2 := strconv.parse_int(answers[1], 10, 64)?
	return TestData{
		answer_p1,
		answer_p2,
		test_input[2..]
	}
}

fn get_input(day int) ?[]string {
	puzzle_txt := './resources/day${day}.txt'
	return os.read_lines(puzzle_txt)
}

fn test_p1(test_data TestData, runner aoc.Runner) ? {
	test_answer := runner.run_p1(test_data.input)?
	if test_answer != test_data.p1 {
		return error('Test Failed | Got $test_answer - expected $test_data.p1')
	}
	println(term.ok_message('Test Success'))
}

fn test_p2(test_data TestData, runner aoc.Runner) ? {
	test_answer := runner.run_p2(test_data.input)?
	if test_answer != test_data.p2 {
		return error('Test Failed | Got $test_answer - expected $test_data.p2')
	}
	println(term.ok_message('Test Success'))
}