import sys

input = sys.stdin.readline

alphabet = {
    "a": "@",
    "b": "8",
    "c": "(",
    "d": "|)",
    "e": "3",
    "f": "#",
    "g": "6",
    "h": "[-]",
    "i": "|",
    "j": "_|",
    "k": "|<",
    "l": "1",
    "m": r"[]\/[]",
    "n": r"[]\[]",
    "o": "0",
    "p": "|D",
    "q": "(,)",
    "r": "|Z",
    "s": "$",
    "t": "']['",
    "u": "|_|",
    "v": r"\/",
    "w": r"\/\/",
    "x": "}{",
    "y": "`/",
    "z": "2"
}

phrase = input().strip("\n")

output = ""
for char in phrase:
    if char.lower() in alphabet:
        output += alphabet[char.lower()]
    else:
        output += char
print(output)
