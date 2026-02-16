import os

# get files in cwd
files = [f for f in os.listdir('.') if os.path.isfile(f)]


def process_file(file):
    contents = []
    f = open(file, 'r')

    modified = False
    for line in f:
        if line.strip().startswith("--#"):
            command = line[line.find('#')+2:].strip()
            args = command[command.find(' ')+1:].split(',')
            command = command[:command.find(' ')]
        
            for i in range(0, line.count('\t')):
                contents.append('\t')

            if command == "INC":
                contents.append(f"{args[0]} = {args[0]} + 1\n")
            elif command == "INCBY":
                contents.append(f"{args[0]} = {args[0]} + {args[1]}\n")
            elif command == "DECBY":
                contents.append(f"{args[0]} = {args[0]} - {args[1]}\n")
            elif command == "DEC":
                contents.append(f"{args[0]} = {args[0]} - 1\n")
            elif command == "ARR":
                contents.append(f"{args[0]} = {args[1]}[{args[2]}+1]\n")
            elif command == "FRE":
                contents.append(f"for i=0,#{args[0]}-1 do\n")
                for i in range(0, line.count('\t')+1):
                    contents.append('\t')
                contents.append(f"temp={args[0]}[i+1]\n\n")
                for i in range(0, line.count('\t')):
                    contents.append('\t')
                contents.append('end\n')


            modified = True
        else:
            contents.append(line)

    if not modified:
        print(f"[love_pp]: No changes detected in file '{file}'")
        return
        
    f = open(file, 'w')

    for line in contents:
        f.write(line)


for file in files:
    if file.endswith('.lua'):
        process_file(file)