#include <iostream>
#include <vector>

using namespace std;

void printSky(vector<string>* sky, int m, int n) {
    for (int k = 0; k < n; k++) {
        cout << ' ' << endl;
    }
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
                cout << sky->at(i).at(j);
        }
        cout << endl;
    }
}

void obscureStar(vector<string>* sky, int i, int j, int m, int n) {
    char pixel = sky->at(i).at(j);
    if (pixel == '#') return;

    if (pixel == '-') sky->at(i).at(j) = '#';
    printSky(sky, m, n);
    if (i - 1 >= 0) obscureStar(sky, i - 1, j, m, n);
    if (j - 1 >= 0) obscureStar(sky, i, j - 1, m, n);
    if (i + 1 <= m - 1) obscureStar(sky, i + 1, j, m, n);
    if (j + 1 <= n - 1) obscureStar(sky, i, j + 1, m, n);
}

int main() {
    int m, n;
    
    int case_number = 1;
    while (cin >> m >> n) {
        vector<string> sky;
        
        string line;
        for (int k = 0; k < m; k++) {
            cin >> line;
            sky.push_back(line);
        }

        int num_stars = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (sky.at(i).at(j) == '-') {
                    num_stars++;
                    obscureStar(&sky, i, j, m, n);
                }
            }
        }

        cout << "Case "<< case_number << ": " << num_stars << endl;
        case_number++;
    }
}
