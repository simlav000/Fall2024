#include <iostream>
#include <functional>
#include <queue>
#include <stack>

int main() {
    int n;

    while (std::cin >> n) {
        int cmd, inp;

        std::queue<int> q;
        std::stack<int> s;
        std::priority_queue<int, std::vector<int>, std::less<int>> pq;

        bool is_q = true;
        bool is_s = true;
        bool is_pq = true;

        while (n--) {
            std::cin >> cmd >> inp;

            if (cmd == 1) {
                q.push(inp);
                s.push(inp);
                pq.push(inp);
            }

            if (cmd == 2) {
                if (q.empty() || s.empty() || pq.empty()) {
                    is_q = false; is_s = false; is_pq = false;
                }
                else {
                    int q_front = q.front(); q.pop();
                    int s_top = s.top(); s.pop();
                    int pq_top = pq.top(); pq.pop();

                    if (inp != q_front) is_q = false;
                    if (inp != s_top) is_s = false;
                    if (inp != pq_top) is_pq = false;
                }
            }
        }

        if (!is_q && !is_s && !is_pq) std::cout << "impossible" << std::endl;
        else if (is_q && is_s || is_s && is_pq || is_q && is_pq ) std::cout << "not sure" << std::endl;
        else if (is_q)  std::cout << "queue" << std::endl;
        else if (is_s)  std::cout << "stack" << std::endl;
        else if (is_pq) std::cout << "priority queue" << std::endl;
    }
}
