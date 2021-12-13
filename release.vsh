#!/usr/bin/env -S v run

if !exists('./target/release/') {
	mkdir('./target/release/')?
}
execute_or_panic('v -prod -gc boehm -o ./target/release/aoc2020 .')
println('Release Build Completed')