use std::{io::stdin, u32};

fn main() {
    let stdin = stdin();
    let mut s = String::new();
    stdin.read_line(&mut s).unwrap();
    let dogs = s
        .split_whitespace()
        .skip(1)
        .map(|v| v.parse::<u32>().unwrap())
        .collect::<Vec<u32>>();

    s.clear();
    stdin.read_line(&mut s).unwrap();
    let buns: Vec<u32> = s
        .split_whitespace()
        .skip(1)
        .map(|v| v.parse().unwrap())
        .collect();
    let bun_sum: u32 = buns.iter().sum();
    let dog_sum: u32 = dogs.iter().sum();
    let table_size = std::cmp::max(bun_sum, dog_sum) + 1;
    let dogs_dp = solve(table_size, dogs);
    let buns_dp = solve(table_size, buns);

    let last_dogs = &dogs_dp[dogs_dp.len() - 1];
    let last_buns = &buns_dp[buns_dp.len() - 1];

    let mut min_pack = u32::MAX;
    for (&b, &d) in last_buns.iter().zip(last_dogs.iter()) {
        if b == u32::MAX || d == u32::MAX {
            continue;
        }
        if b == 0 || d == 0 {
            continue;
        }
        min_pack = std::cmp::min(min_pack, b + d);
    }
    if min_pack == u32::MAX {
        println!("impossible");
        return;
    }
    println!("{}", min_pack);
}

fn solve(table_size: u32, list: Vec<u32>) -> Vec<Vec<u32>> {
    let mut dp: Vec<Vec<u32>> = vec![vec![u32::MAX; table_size as usize]; list.len() + 1];
    // Initializes value to 0 when target is 0
    for i in 0..list.len() + 1 {
        dp[i][0] = 0;
    }
    for i in 1..list.len() + 1 {
        for j in 1..(table_size as usize) {
            let index = j as i32 - (list[i - 1] as i32);
            let value = if index < 0 {
                u32::MAX
            } else {
                let v = dp[i - 1][index as usize];
                if v == u32::MAX {
                    v
                } else {
                    1 + v
                }
            };
            dp[i][j] = std::cmp::min(dp[i - 1][j], value);
        }
    }
    dp

