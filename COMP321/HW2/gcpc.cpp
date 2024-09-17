#include <iostream>
#include <unordered_map>
#include <set>

using namespace std;

struct Team {
    int team_number;
    int solved;
    int penalty;

    Team(int tn = 0, int s = 0, int p = 0) : team_number(tn), solved(s), penalty(p) {}

    bool operator<(const Team& other) const {
        if (solved != other.solved) return solved >= other.solved; // More solved problems is better
        return penalty <= other.penalty; // Lower penalty is better
    }
};

int main() {
    int num_teams, num_events;
    cin >> num_teams >> num_events;

    unordered_map<int, Team> teams;
    set<Team> leaderboard;

    Team team1(1, 0, 0);
    teams[1] = team1;
    leaderboard.insert(team1);

    while (num_events--) {
        int num, pen;
        cin >> num >> pen;

        if (teams.find(num) != teams.end()) {
            leaderboard.erase(teams[num]);
        }

        teams[num].team_number = num;
        teams[num].solved++;
        teams[num].penalty += pen;

        // Reinsert team into leaderboard
        leaderboard.insert(teams[num]);

        // Find position of team 1
        auto it = leaderboard.find(teams[1]);
        int rank = distance(leaderboard.begin(), it) + 1;
        cout << rank << endl;
    }

    return 0;
}
