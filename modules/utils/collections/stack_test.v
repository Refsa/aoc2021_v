module collections

fn test_stack_push_pop()? {
	mut stack := new_stack<int>()

	stack.push(1)
	stack.push(2)
	stack.push(3)
	stack.push(4)

	assert stack.pop()? == 4
	assert stack.pop()? == 3
	assert stack.pop()? == 2
	assert stack.pop()? == 1
}

fn test_stack_peek()? {
	mut stack := new_stack<int>()

	stack.push(1)
	stack.push(2)
	stack.push(3)

	assert stack.peek()? == 3
	assert stack.len() == 3
}