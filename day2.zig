const std = @import("std");

const Outcome = enum(u4) {
    win = 6,
    draw = 3,
    loss = 0,
};

const Move = enum(u4) {
    rock = 1,
    paper = 2,
    scissors = 3,

    fn play(self: Move, other: Move) Outcome {
        if (self == other) return .draw;
        if (self == .rock and other == .scissors) return .win;
        if (self == .paper and other == .rock) return .win;
        if (self == .scissors and other == .paper) return .win;
        return .loss;
    }

    fn makeOutcome(self: Move, outcome: Outcome) Move {
        if (outcome == .draw) return self;
        return switch (self) {
            .rock => if (outcome == .win) .paper else .scissors,
            .paper => if (outcome == .win) .scissors else .rock,
            .scissors => if (outcome == .win) .rock else .paper,
        };
    }
};

pub fn main() !void {
    var part1: usize = 0;
    var part2: usize = 0;

    var f = try std.fs.cwd().openFile("day2.txt", .{});
    defer f.close();

    var r = std.io.bufferedReader(f.reader());
    var stream = r.reader();
    var buf: [4]u8 = undefined;
    while (try stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const move = @intToEnum(Move, line[0] - 'A' + 1);

        const resp = @intToEnum(Move, line[2] - 'X' + 1);
        const outc = @intToEnum(Outcome, 3 * (line[2] - 'X'));

        const respVal = @enumToInt(resp);

        part1 += @enumToInt(resp.play(move)) + respVal;
        part2 += @enumToInt(move.makeOutcome(outc)) + respVal;
    }

    std.debug.print("{}\n{}\n", .{ part1, part2 });
}
