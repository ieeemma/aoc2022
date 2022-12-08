with open("day1.txt") as f:
    inp = f.read()

nums = [[int(n) for n in x.split("\n")[:-1]] for x in inp.split("\n\n")]

part1 = max(nums)

part2 = sum(sorted(nums)[-3:])
