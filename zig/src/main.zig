const std = @import("std");
const ac = @import("ac-library");
const iter = @import("ziter");

pub fn main() !void {
    const ascii_digits = try iter.range(u8, 0, 255)
        .filter({}, iter.void_ctx(std.ascii.isDigit))
        .collect_no_allocator(std.BoundedArray(u8, 255){});
    std.debug.print("{any}\n", .{ascii_digits.slice()});
    const allocator = std.heap.page_allocator;
    var d = try ac.Dsu.init(allocator, 10);
    defer d.deinit();
    _ = d.merge(0, 1);
    try std.testing.expect(d.same(0, 1));
    _ = d.merge(1, 5);
    var g = try d.groups();
    std.debug.print("{any}\n", .{g.get(0)});
}
