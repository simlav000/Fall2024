#include <cmath>
#include <iostream>

int traverse(std::string instructions, int diff) {
    if (instructions.empty()) return diff;

    else if (instructions[0] == 'L') {
        return traverse(instructions.erase(0, 1), 2*diff);
    }

    else {
        return traverse(instructions.erase(0,1), 2*diff + 1);
    }
}

int main() {
    int height;
    std::string instructions;

    std::cin >> height;

    int root =  pow(2, height+1);
    int diff = 1;

    if (std::cin >> instructions) {
        std::cout << root - traverse(instructions, diff) << std::endl;
    }

    else {
        std::cout << root - 1 << std::endl;
    }

}
