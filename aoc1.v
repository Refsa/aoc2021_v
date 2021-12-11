import arrays

pub struct AOC1 { }

pub fn (aoc AOC1) run_p1 (input []string) ?u64 {
	parsed := cast(input)?

	mut increases := 0
	for w in arrays.window<int>(parsed, size: 2) {
		if w[1] > w[0] {
			increases += 1
		}
	}

	return u64(increases)
}

pub fn (aoc AOC1) run_p2 (input []string) ?u64 {
	parsed := cast(input)?

	mut sums := []int{}
	for w in arrays.window<int>(parsed, size: 3) {
		sums.insert(sums.len, w[0] + w[1] + w[2])
	}

	mut increases := 0
	for w in arrays.window<int>(sums, size: 2) {
		if w[1] > w[0] {
			increases += 1
		}
	}

	return u64(increases)
}