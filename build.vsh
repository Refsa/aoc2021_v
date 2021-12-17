#!/usr/bin/env -S v run

if !exists('./target/debug/') {
	mkdir('./target/debug/')?
}
println('Doing Debug Build')
execute_or_panic('v -gc boehm -o ./target/debug/aoc2020 .')
println('Debug Build Completed')