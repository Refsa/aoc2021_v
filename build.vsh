#!/usr/bin/env -S v run

if !exists('./target/') {
	mkdir('./target/')?
}
execute_or_panic('v -gc boehm -o ./target/aoc2020 .')
println('Build Completed')