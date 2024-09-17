#include <iostream>
#include <unordered_set>
using namespace std;

int main() {
    while (true) {
        int N, M;
        cin >> N >> M;
        if (N == 0 && M == 0) return 0;
        unordered_set<int> collection;
        while (N--) {
            int catalog;
            cin >> catalog;
            collection.insert(catalog);
        }

        int duplicates = 0;
        while (M--) {
            int catalog;
            cin >> catalog;
            if (collection.count(catalog)) {
                duplicates++;
            }
        }
        cout << duplicates << endl;
    }

    return 0;
}
