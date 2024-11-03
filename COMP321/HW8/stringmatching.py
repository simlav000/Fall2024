def kmp(pattern, text):
    pattern_len = len(pattern)
    text_len = len(text)

    lps = [0] * pattern_len
    j = 0  # Length of previous longest prefix suffix
    i = 1

    while i < pattern_len:
        if pattern[i] == pattern[j]:
            j += 1
            lps[i] = j
            i += 1
        else:
            if j != 0:
                j = lps[j - 1]
            else:
                lps[i] = 0
                i += 1

    i = 0  # index for text
    j = 0  # index for pattern
    first = True
    indices = []

    while i < text_len:
        if pattern[j] == text[i]:
            i += 1
            j += 1

        if j == pattern_len:
            if first:
                first = False
            else:
                indices.append(" ")
            indices.append(str(i - j))
            j = lps[j - 1]  # Get the next position for j

        elif i < text_len and pattern[j] != text[i]:
            if j != 0:
                j = lps[j - 1]
            else:
                i += 1

    print("".join(indices))


try:
    while True:
        pattern = input()
        text = input()

        if not pattern and not text:
            break

        # Remove newline characters if present
        if pattern.endswith('\n'):
            pattern = pattern[:-1]
        if text.endswith('\n'):
            text = text[:-1]

        kmp(pattern, text)
except EOFError:
    pass
