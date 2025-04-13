/\/$/ { root = $4 }
/\/home$/ { home = $4 }
END { print root " " home }
