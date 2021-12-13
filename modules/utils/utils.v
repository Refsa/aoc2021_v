module utils

import strings.textscanner
import strconv

pub fn cast(arr []string) ?[]int {
	return arr.map(strconv.atoi(it)?)
}

pub fn split(input string, term u8) []string {
	mut values := []string{}

	mut scanner := textscanner.new(input)
	mut last_split := 0

	for scanner.remaining() != 0 {
		c := scanner.next()
		if c == term {
			pos := input.len - scanner.remaining()
			split := input[last_split..pos - 1]
			values.insert(values.len, split)

			last_split = pos
			scanner.skip()
		}
	}

	if last_split != input.len {
		split := input[last_split..input.len]
		values.insert(values.len, split)
	}

	return values
}