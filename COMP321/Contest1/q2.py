import sys

input = sys.stdin.readline

n_cases = int(input())

for _ in range(n_cases):
    n, m, l = map(int, input().split())

    pushed = []
    dominoes = [False] * (n + 1)
    effect = dict()
    for _ in range(m):
        d1, d2 = map(int, input().split())
        if d1 not in effect:
            effect[d1] = [d2]
        else:
            effect[d1].append(d2)

    count = 0
    for _ in range(l):
        p = int(input())
        pushed.append(p)
        if dominoes[p] is False:
            count += 1
        dominoes[p] = True

    while len(pushed) > 0:
        p = pushed[-1]
        del pushed[-1]

        if p not in effect:
            continue
        fall = effect[p]
        for knocked_over in fall:
            if not dominoes[knocked_over]:
                count += 1
                dominoes[knocked_over] = True
                pushed.append(knocked_over)

    print(count)
