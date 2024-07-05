BEGIN { getether = 0}

/^enp/ { getether = 1; next}

getether == 1 { print "E: " $2; getether = 0; next}
