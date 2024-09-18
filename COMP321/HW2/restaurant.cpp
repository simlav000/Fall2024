#include <iostream>
using namespace std;

int main() {
    int n;

    while (cin >> n && n != 0) {
        int s1 = 0;
        int s2 = 0;

        while (n--) {
            string command;
            int times;
            cin >> command >> times;

            if (command == "DROP") {
                cout << "DROP 2 " << times << endl;
                s2 += times;
            }

            else { // "TAKE"
                if (s1 == 0 && s2 != 0) {
                    cout << "MOVE 2->1 " << s2 << endl;

                    s1 += s2;
                    s2 = 0;

                    cout << "TAKE 1 " << times << endl;
                    s1 -= times;
                }
                else if (s1 != 0 && s2 == 0) {
                    cout << "TAKE 1 " << times << endl;
                    s1 -= times;
                } else {
                    if (times <= s1) {
                        cout << "TAKE 1 " << times << endl;
                        s1 -= times;
                    }
                    else {
                        int amount = s1;
                        cout << "TAKE 1 " << amount << endl;
                        s1 = 0;
                        int remaining = times - amount;
                        cout << "MOVE 2->1 " << s2 << endl;
                        s1 += s2;
                        s2 = 0;
                        if (s1 != 0) {
                            cout << "TAKE 1 " << remaining << endl;
                            s1 -= remaining;
                        }
                    }
                }
            }
        }
        cout << endl;
    }
}
