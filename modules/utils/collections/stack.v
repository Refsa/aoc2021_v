module collections

pub struct Stack<T> {
mut:
	stack []T
}

pub fn new_stack<T>() Stack<T> {
	return Stack<T>{}
}

pub fn (stack Stack<T>) len() int {
	return stack.stack.len
}

pub fn (mut stack Stack<T>) push(value T) {
	stack.stack << value
}

pub fn (mut stack Stack<T>) pop() ?T {
	if stack.len() == 0 {
		return none
	}

	return stack.stack.pop()
}

pub fn (stack Stack<T>) peek() ?T {
	if stack.len() == 0 {
		return none
	}

	return stack.stack[stack.len() - 1]
}

pub fn (mut stack Stack<T>) rev() {
	stack.stack = stack.stack.reverse()
}

pub fn (mut stack Stack<T>) next() ?T {
	return stack.pop()
}