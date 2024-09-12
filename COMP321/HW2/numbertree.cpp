#include <cmath>
#include <iostream>

struct Node {
    int aData;
    Node* left;
    Node* right;

    Node(int root) :
        aData(root), left(nullptr), right(nullptr) {}
};

Node* createPerfectTree(int height, int& count) {
    if (height < 0) return nullptr;

    Node* root = new Node(count--);
    root->left = createPerfectTree(height - 1, count);
    root->right = createPerfectTree(height - 1, count);

    return root;
}

void printAnswer(Node pTree, std::string instructions) {
    if (instructions.empty()) {
        std::cout << pTree.aData << std::endl;
    }

    else if (instructions[0] == 'L') {
        printAnswer(pTree->left, instructions.erase(0,1));
    }

    printAnswer(pTree->right, instructions.erase(0,1));
}

int main() {
    int height;
    std::string instructions;

    std::cin >> height >> instructions;

    int root =  pow(2, height) - 1;
    int& count = root;

    Node* pTree = createPerfectTree(height, count);
}
