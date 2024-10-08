import sys

input = sys.stdin.readline
print = sys.stdout.write

n = int(input())

students = []

for _ in range(n):
    s = list(input().strip().split())
    name = s[0]
    pss = s[1]
    pss_YYYY, pss_MM, pss_DD = map(int, pss.split("/"))
    DOB = s[2]
    DOB_YYYY, DOB_MM, DOB_DD = map(int, DOB.split("/"))
    courses = int(s[3])


    if (pss_YYYY > 2010):
        print(f"{name} eligible" + "\n")

    elif (DOB_YYYY > 1991):
        print(f"{name} eligible"+ "\n")

    elif courses > 40:
        print(f"{name} ineligible"+ "\n")

    else:
        print(f"{name}  coach petitions"+ "\n")



