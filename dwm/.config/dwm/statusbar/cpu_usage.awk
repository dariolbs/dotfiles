BEGIN { first = 1 }
/^cpu /{

    u=$2+$4
    t=$2+$4+$5

    if (first == 1){
        u1=u
        t1=t
        first = 0
    }
    else
        print ($2+$4-u1) * 100 / (t-t1) "%"
}
