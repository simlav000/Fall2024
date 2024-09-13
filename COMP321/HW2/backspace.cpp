#include <iostream>

int main() {
    std::string line;
    std::string result;

    std::cin >> line;


    for (char c : line) {
        if (c == '<') {
            if (!result.empty()) {
                result.pop_back();
            }
        }
        else {
            result.push_back(c);
        }
        
    }
    std::cout << result << std::endl;
}
