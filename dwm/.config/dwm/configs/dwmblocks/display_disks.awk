/\/$/ { root = $5 }
/\/home$/ { home = $5 }

END{ print "Usage: root:" root, "home:" home}
