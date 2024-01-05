const std = @import("std");
const stdout = std.io.getStdOut().writer();
const assert = std.debug.assert;

// TODO fix variable names. they are misleading
pub fn main() !void {
    var s1 = "sdf";

    var s1_slice = s1[0..];

    // s ... array not slice
    var s = "sdf".*;
    var s_slice = s[0..];
    // comptime assert(@TypeOf(s) == u8);

    // ++ ... array concatenation operator
    var both = s ++ "sadf".*;
    var both2 = s ++ "sadf";

    // does not work. different size for array
    // s = s ++ "sadf".*;

    try stdout.print("{s}\n", .{"test123"});
    try stdout.print("{s}", .{"\n"});

    try stdout.print("both: {s}\n", .{both});
    try stdout.print("typeof both: {s}\n", .{@typeName(@TypeOf(both))});
    try stdout.print("{s}", .{"\n"});

    try stdout.print("both2: {s}\n", .{both2});
    try stdout.print("typeof both2: {s}\n", .{@typeName(@TypeOf(both2))});

    try stdout.print("{s}", .{"\n"});
    try stdout.print("s: {s}\n", .{s});
    try stdout.print("typeof s: {s}\n", .{@typeName(@TypeOf(s))});

    try stdout.print("{s}", .{"\n"});
    try stdout.print("s1: {s}\n", .{s1});
    try stdout.print("typeof s1: {s}\n", .{@typeName(@TypeOf(s1))});

    try stdout.print("{s}", .{"\n"});
    try stdout.print("s1_slice: {s}\n", .{s1_slice});
    try stdout.print("typeof s1_slice: {s}\n", .{@typeName(@TypeOf(s1_slice))});

    try stdout.print("{s}", .{"\n"});
    try stdout.print("s_slice: {s}\n", .{s_slice});
    try stdout.print("typeof s_slice: {s}\n", .{@typeName(@TypeOf(s_slice))});
}
