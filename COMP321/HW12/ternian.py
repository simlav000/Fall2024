def ternarian_weights(t_weight):
    results = []
    for weight in t_weight:
        left_pan = []
        right_pan = []
        power = 0

        while weight != 0:
            remainder = weight % 3
            if remainder == 1:
                right_pan.append(3**power)
                weight -= 1
            elif remainder == 2:
                left_pan.append(3**power)
                weight += 1
            weight //= 3
            power += 1

        results.append((sorted(left_pan, reverse=True), sorted(right_pan, reverse=True)))

    return results

n = int(input().strip())
t_weight = [int(input().strip()) for _ in range(n)]
results = ternarian_weights(t_weight)

for i, (left, right) in enumerate(results):
    print("left pan:", " ".join(map(str, left)))
    print("right pan:", " ".join(map(str, right)))
    if i < len(results) - 1:
        print()

