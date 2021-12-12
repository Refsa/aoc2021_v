module aoc6
import strconv
import arrays

pub struct AOC6 {}

pub fn (aoc AOC6) run_p1(input []string) ?u64 {
	initial_state := parse(input)?

	mut buckets := [9]u64{}
	for ins in initial_state {
		buckets[ins] += 1
	}

	for _ in 0..80 {
		cnt := buckets[0]
		shift_left(mut buckets)

		buckets[6] += cnt
		buckets[8] = cnt
	}

	return u64(arrays.sum<u64>(buckets[..])?)
}

pub fn (aoc AOC6) run_p2(input []string) ?u64 {
	initial_state := parse(input)?

	mut buckets := [9]u64{}
	for ins in initial_state {
		buckets[ins] += 1
	}

	for _ in 0..256 {
		cnt := buckets[0]
		shift_left(mut buckets)

		buckets[6] += cnt
		buckets[8] = cnt
	}

	return u64(arrays.sum<u64>(buckets[..])?)
}

fn parse(input []string) ?[]u64 {
	mut output := []u64{}

	for l in input[0].split(',') {
		val := strconv.parse_uint(l, 10, 64)?
		output << val
	}

	return output
}

[direct_array_access]
fn shift_left(mut arr [9]u64) {
	for i in 0..arr.len - 1 {
		arr[i] = arr[i + 1]
	}
}