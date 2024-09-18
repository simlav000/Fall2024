#include <iostream>
#include <unordered_set>
#include <vector>

using namespace std;

struct Team {
    int solved = 0;
    int penalty = 0;

    bool operator>=(const Team& other) const {
        if (solved != other.solved) return solved > other.solved;  
        return penalty <= other.penalty;  
    }

    void update(int pen) {
        solved++;
        penalty += pen;
    }
};

int main() {
    int num_teams, num_events;
    cin >> num_teams >> num_events;

    vector<Team> teams(num_teams);
    unordered_set<int> better;

    while (num_events--) {
        int num, pen;
        cin >> num >> pen;
        num--;

        teams[num].update(pen);

        if (num == 0) {
            unordered_set<int> discard;
            for (int t : better) {
                if (teams[0] >= teams[t]) discard.insert(t);
            }
            for (int t : discard) better.erase(t);
        }

        if (num != 0 && !(teams[0] >= teams[num])) {
            better.insert(num);
        }

        cout << better.size() + 1 << endl;
    }

    return 0;
}
