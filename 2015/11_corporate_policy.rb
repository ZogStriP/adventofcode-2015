INCREASING = Regexp.union [*?a..?z].each_cons(3).map(&:join)

next_password = -> (p) {
  loop {
    p.next!
    return p if p[INCREASING] && !p[/[iol]/] && p.scan(/(.)\1/).flatten.uniq.size > 1
  }
}

password = "cqjxjnds"
p password = next_password[password]
p password = next_password[password]
