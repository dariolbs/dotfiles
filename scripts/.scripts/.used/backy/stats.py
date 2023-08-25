from os import environ

TIMES_RUN_IDX = 0
STATS_FILE = f'{environ["HOME"]}/.local/share/backy/stats'
BACKUPS_RUN_IDX = 1

def getStats() -> dict:
    """
    Returns de stats as a dictionary
    """
    stats = {}
    file = open(f"{STATS_FILE}", "r")
    for line in file.readlines():
        separated = line.rstrip().split(" -> ")
        config = separated[0]
        times_run = separated[1]
        backups_run = separated[2]
        stats[config] = [int(times_run), int(backups_run)]
    return stats

def increment(config, times_run: int, backups_run: int) -> None:
    """
    Increments a config file's sats as specified in the parameters
    """
    stats = getStats()
    newstats = { config: [times_run, backups_run]}
    for i in stats.keys():
        if i == config:
            newstats[config] = [
                    int(stats[config][TIMES_RUN_IDX]) + times_run,
                    int(stats[config][BACKUPS_RUN_IDX]) + backups_run,
                    ]
        else:
            newstats[i] = stats[i]
    # Write to the stats file
    file = open(f"{STATS_FILE}", "w")
    for conf in newstats.keys():
        file.write(
                f"{conf} -> "
                f"{newstats[conf][TIMES_RUN_IDX]} -> "
                f"{newstats[conf][BACKUPS_RUN_IDX]}\n"
                )
