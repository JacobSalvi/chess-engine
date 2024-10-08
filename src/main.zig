const std = @import("std");

const BitBoard = struct {
    WHITE_PAWN: u64 = 0,
    WHITE_ROOK: u64 = 0,
    WHITE_KNIGHT: u64 = 0,
    WHITE_BISHOP: u64 = 0,
    WHITE_QUEEN: u64 = 0,
    WHITE_KING: u64 = 0,
    BLACK_PAWN: u64 = 0,
    BLACK_ROOK: u64 = 0,
    BLACK_KNIGHT: u64 = 0,
    BLACK_BISHOP: u64 = 0,
    BLACK_QUEEN: u64 = 0,
    BLACK_KING: u64 = 0,

    fn setBit(value: *u64, position: usize) void {
        if (position > 63) {
            return;
        }
        value.* |= (@as(u64, 1) << @intCast(position));
    }

    fn isBitSet(value: u64, position: usize) bool {
        return (value & (@as(u64, 1) << @intCast(position))) != 0;
    }

    pub fn fromArray(arr: [8][]const u8) BitBoard {
        var vals = [_]u64{0} ** 12;
        var i: u8 = 0;
        for (arr) |row| {
            for (row) |cell| {
                switch (cell) {
                    'p' => BitBoard.setBit(&vals[0], i),
                    'k' => BitBoard.setBit(&vals[1], i),
                    'q' => BitBoard.setBit(&vals[2], i),
                    'r' => BitBoard.setBit(&vals[3], i),
                    'n' => BitBoard.setBit(&vals[4], i),
                    'b' => BitBoard.setBit(&vals[5], i),
                    'P' => BitBoard.setBit(&vals[6], i),
                    'K' => BitBoard.setBit(&vals[7], i),
                    'Q' => BitBoard.setBit(&vals[8], i),
                    'R' => BitBoard.setBit(&vals[9], i),
                    'N' => BitBoard.setBit(&vals[10], i),
                    'B' => BitBoard.setBit(&vals[11], i),
                    else => {},
                }
                i = i + 1;
            }
        }
        return BitBoard{
            .WHITE_PAWN = vals[0],
            .WHITE_KING = vals[1],
            .WHITE_QUEEN = vals[2],
            .WHITE_ROOK = vals[3],
            .WHITE_KNIGHT = vals[4],
            .WHITE_BISHOP = vals[5],
            .BLACK_PAWN = vals[6],
            .BLACK_KING = vals[7],
            .BLACK_QUEEN = vals[8],
            .BLACK_ROOK = vals[9],
            .BLACK_KNIGHT = vals[10],
            .BLACK_BISHOP = vals[11],
        };
    }

    pub fn print(self: BitBoard) void {
        for (0..64) |pos| {
            if (BitBoard.isBitSet(self.WHITE_PAWN, pos)) {
                std.debug.print(" p ", .{});
            }
            if (BitBoard.isBitSet(self.WHITE_BISHOP, pos)) {
                std.debug.print(" b ", .{});
            }
            if (BitBoard.isBitSet(self.WHITE_KING, pos)) {
                std.debug.print(" k ", .{});
            }
            if (BitBoard.isBitSet(self.WHITE_QUEEN, pos)) {
                std.debug.print(" q ", .{});
            }
            if (BitBoard.isBitSet(self.WHITE_KNIGHT, pos)) {
                std.debug.print(" n ", .{});
            }
            if (BitBoard.isBitSet(self.WHITE_ROOK, pos)) {
                std.debug.print(" r ", .{});
            }
            if (BitBoard.isBitSet(self.BLACK_PAWN, pos)) {
                std.debug.print(" P ", .{});
            }
            if (BitBoard.isBitSet(self.BLACK_BISHOP, pos)) {
                std.debug.print(" B ", .{});
            }
            if (BitBoard.isBitSet(self.BLACK_KING, pos)) {
                std.debug.print(" K ", .{});
            }
            if (BitBoard.isBitSet(self.BLACK_QUEEN, pos)) {
                std.debug.print(" Q ", .{});
            }
            if (BitBoard.isBitSet(self.BLACK_KNIGHT, pos)) {
                std.debug.print(" N ", .{});
            }
            if (BitBoard.isBitSet(self.BLACK_ROOK, pos)) {
                std.debug.print(" R ", .{});
            }
            if (pos % 8 == 7) {
                std.debug.print("\n", .{});
            }
        }
    }
};

pub fn main() !void {
    const board = [8][]const u8{ "RNBQKBNR", "PPPPPPPP", "        ", "        ", "        ", "        ", "pppppppp", "rnbqkbnr" };
    var bitboard = BitBoard.fromArray(board);
    bitboard.print();
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
