/\/$/ { root = $5 }
/\/home$/ { home = $5 }

END{ print "💾" root, "🏠" home}
