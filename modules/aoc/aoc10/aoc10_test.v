module aoc10

fn test_is_matching() {
	a := Opening{0}
	b := Closing{1}

	assert is_matching(a, b)
}

fn test_not_is_matching() {
	a := Opening{0}
	b := Closing{3}

	assert !is_matching(a, b)
}