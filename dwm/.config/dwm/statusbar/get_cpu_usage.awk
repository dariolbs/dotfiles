BEGIN { usage = 0; ncpu = 0 }

/^cpu[0-9]/{
    usage =+ ($5*100)/($2+$3+$4+$5+$6+$7+$8+$9+$10)
    ncpu++;
}

END {
    # Convert to percentage
    full_usage = usage / ncpu
    print full_usage "%"
}
