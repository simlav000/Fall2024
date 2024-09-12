#include <functional>
#include <queue>
#include <stack>
#include <stdlib.h>
#include <iostream>

int main() {
    std::stack<int> stack;
    std::queue<int> queue;
    std::priority_queue<int, std::vector<int>, std::greater<int>> lpq;
    std::priority_queue<int, std::vector<int>, std::less<int>> gpq;

    int n;

    while (std::cin >> n) {
        for (int i = 0; i < n; i++) {
            int op, num;
            std::cin >> op >> num;
            std::cout << op << num << std::endl;
        }
    }


}
