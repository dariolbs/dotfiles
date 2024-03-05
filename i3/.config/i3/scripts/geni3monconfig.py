import fileinput

primary_mon = ""
sec_mon = []

for line in fileinput.input(encoding="utf-8"):
    sline = line.split(" ")
    if sline[1] == "connected":
        if sline[2] == "primary":
            primary_mon = sline[0]
        else:
            sec_mon.append(sline[0])

for i in range(1,11):
    print(f"workspace {i} output {primary_mon}")

if sec_mon != []:
    b = 11;
    for m in sec_mon:
        for i in range(1, 5):
            print(f"workspace {b} output {m}")
            b += 1
