module aoc3

import bitfield

pub struct AOC3 {}

pub fn (aoc AOC3) run_p1 (input []string) ?u64 {
	parsed := parse(input)?

	defer {
		for p in parsed {
			unsafe { p.free() }
		}
	}

	mut gamma := bitfield.new(parsed[0].get_size())

	len := parsed[0].get_size()
	for i in 0..len {
		if count_ones(parsed, i) > (parsed.len / 2) {
			gamma.set_bit(i)
		}
	}

	epsilon := bitfield.bf_not(gamma)

	return u64(gamma.extract(0, len) * epsilon.extract(0, len))
}

pub fn (aoc AOC3) run_p2(input []string) ?u64 {
	mut oxygen_arr := parse(input)?
	mut co2_arr := oxygen_arr.clone()
	bit_len := oxygen_arr[0].get_size()

	handle_p2(mut oxygen_arr, fn (v bool) int {
		return if v {
			0
		} else {
			1
		}
	})

	handle_p2(mut co2_arr, fn (v bool) int {
		return if v {
			1
		} else {
			0
		}
	})

	oxygen := oxygen_arr[0].extract(0, bit_len)
	co2 := co2_arr[0].extract(0, bit_len)

	return oxygen * co2
}

fn handle_p2(mut input []bitfield.BitField, rem fn(bool) int) {
	mut i := 0
	for input.len != 1 {
		ones := count_ones(input, i)
		zeros := input.len - ones

		to_remove := rem(ones >= zeros)

		for j := input.len - 1; j >= 0; j -= 1 {
			if input[j].get_bit(i) == to_remove {
				input.delete(j)
			}
		}

		i += 1
	}
}

fn count_ones(input []bitfield.BitField, index int) int {
	mut ones := 0
	for p in input {
		if p.get_bit(index) == 1 {
			ones += 1
		}
	}
	return ones
}

fn parse(input []string) ?[]bitfield.BitField {
	mut parsed := []bitfield.BitField{}

	for l in input {
		parsed << bitfield.from_str(l)
	}

	return parsed
}