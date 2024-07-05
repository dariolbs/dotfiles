/\/$/ { root = $5 }
/\/home$/ { home = $5 }

END{ print "[r:" root, "h:" home "]"}
