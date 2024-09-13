#include <iostream>

int main() {
    int memory;
    std::string queue;

    std::cin >> memory >> queue;

    int count = 0;
    int balance = 0; 
    // 0: Perfect balance
    // Positive: More women
    // Negative: More men

    while (!queue.empty() && abs(balance) <= memory) {
        count++;
        if (queue.length() == 1) {
            queue.at(0) == 'W' ? balance++ : balance--;
            queue.erase(0,1);
        }

        else {
            char fst = queue.at(0);
            char snd = queue.at(1);

            if (balance < 0) {
                if (fst == 'W') {
                    balance++;
                    queue.erase(0,1);
                }
                else if (snd == 'W') {
                    balance++;
                    queue.erase(1,1);
                }
                else {
                    balance--;
                    queue.erase(0,1);
                }
            }
            else if (balance > 0) {
                if (fst == 'M') {
                    balance--;
                    queue.erase(0,1);
                }
                else if (snd == 'M') {
                    balance--;
                    queue.erase(1,1);
                }
                else {
                    balance++;
                    queue.erase(0,1);
                }
            }
            else {
                fst == 'W' ? balance++ : balance--;
                queue.erase(0, 1);
            }
        }

    }

    if (abs(balance) > memory) {
        count--;
    }

    std::cout << count << std::endl;
}
