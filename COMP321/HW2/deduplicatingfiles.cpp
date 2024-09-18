#include <iostream>
#include <sstream>
#include <unordered_map>
#include <unordered_set>
#include <vector>
using namespace std;

int hashFile(string file) {
    char hash = 0;
    for (char ch : file) {
        hash ^= ch;
    }
    return hash;
}

int main() {
    stringstream output;
    int n;
    while (cin >> n && n != 0) {

        cin.ignore();

        unordered_set<string> unique;
        vector<string> all_files;

        for (int i = 0; i < n; i++) {
            string file;
            getline(cin, file);
            unique.insert(file);
            all_files.push_back(file);
        }

        int collisions = 0;

        for (int i = 0; i < n; i++) {
            string current = all_files[i];
            char hash = hashFile(current);
            for (int j = i + 1; j < n; j++) {
                string other = all_files[j]; 
                char other_hash = hashFile(other);
                if (hash == other_hash && current != other) {
                    collisions++;
                }
            }
        }
        cout << unique.size() << " " << collisions << endl;
    }
    return 0;
}

