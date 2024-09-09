import sys

input = sys.stdin.readline
print = sys.stdout.write

key_info = list(map(int, input().split()))

while key_info[0] != 0:
    key_length = key_info[0]
    key = key_info[1:]
    message = input().strip()
    encrypted = ""

    while len(message) % key_length != 0:
        message += " "

    num_chunks = int(len(message) / key_length)

    for chunk in range(num_chunks):
        for index in key:
            encrypted += message[key_length*chunk + (index - 1)]

    print("'" + encrypted + "'\n")
    key_info = list(map(int, input().split()))


