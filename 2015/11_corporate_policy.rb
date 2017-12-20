INCREASING = Regexp.union [*?a..?z].each_cons(3).map(&:join)

def next_password(password)
  loop do
    password.next!
    return password if password[INCREASING] && password !~ /[iol]/ && password.scan(/(.)\1/).flatten.uniq.size > 1
  end
end

password = "cqjxjnds"
p password = next_password(password)
p password = next_password(password)
