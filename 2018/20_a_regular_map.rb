DIRECTIONS = {
  "N" => [ 0, -1],
  "S" => [ 0,  1],
  "E" => [ 1,  0],
  "W" => [-1,  0],
}

map = Hash.new { |h, k| h[k] = [] }
stack = []
position = [0, 0]
instructions = DATA.read.chomp.chars

while i = instructions.shift
  if d = DIRECTIONS[i]
    n = [position[0] + d[0], position[1] +  d[1]]
    map[n] << position
    map[position] << n
    position = n
  elsif i == "("
    stack << position
  elsif i == ")"
    stack.pop
  elsif i == "|"
    position = stack[-1]
  end
end

start = [0, 0]
queue = [start]
distances = { start => 0 }

while c = queue.shift
  map[c].each { |n|
    next if distances[n]
    distances[n] = distances[c] + 1
    queue << n
  }
end

p distances.values.max
p distances.values.count { |d| d >= 1000 }

__END__
^WWSWNNWNENWWSSSESWSSWWWWSSESSWNWSWSESSSSWWNENWWNE(NNNNE(NNWWWNWNENEENNWSWWSWNNNWWNWWWNWNENWWSWNNWNNNWNENESEENNW(S|NWSWNWSSWWWSSEE(NWES|)SESSWWSEEESSWNWWWSEESESSWWSEESESSESSWSSWWSWNNEENWWWWNNWSWSWNNWSWNNENWWSSWSWNWWNENWNWWSESWWSEESEESEEE(SSESSESWWWSEEEENESSENNENNNN(ESSSSSSW(N|SWSSENEEENW(W|NEENWWNEN(W|ESEESEESSSENNNNNWSWNWN(NEN(W|ESS(W|EESSEEENWWNEEEEENNN(WNWWWSEESWS(EENSWW|)WNWSWWNNWWNNENNWNW(SSEWNN|)NEESEEESWWSEEEE(NWNN(ESNW|)WNWW(SEWN|)WNWW(NEWS|)S(W(N|SS)|E)|S(ENSW|)WWSW(S(E|S)|W(NEWS|)W))|E(SSSSWSWSW(NNEWSS|)WSEEE(N|ESWSEESENESESWSESENENWNNWNNENEEEENEESSW(SWNWWWS(W|ESWSEESSW(N|SSSWN(N|WWSSE(N|SWWSWSWWSWWWNWNWWSSE(N|SWWNWNWWNWNEESENNES(EEEENWWWNWNWNNWWWSEESWWSS(WWWWSWSEESESSSSWNWSSESSSSSEEESWWWWSWSEEEEEN(EESWSSSWSEESSSSWSWWNWNNWWNNWNNWWWNENE(SEEESWSEEE(SS(WNWSNESE|)EESSW(NWSNES|)S|NN(ES|WS))|NNWNNENNWWS(E|SSWSES(E|SWNWNNNENWWSWSSE(N|SSSWNWSWNWWSESWWNWNNE(S|NNWWWSSSSWWSSWNNNNNNNNWWWSESE(N|SSWWWWNEN(ESEWNW|)WNENNNEEES(ENESSSE(ENENNNNNWWNWNWSWNWSSESS(WNWNWNNE(S|NEENNEESS(WNSE|)EEEEESESSENENNEESWSEENESENENWWNW(NNEENESENEE(NENESES(ENNWNENNNW(NEN(N|EESSSS(WNNNSSSE|)EEN(W|EESSW(SESESEEESEESWS(EENNE(ENWNENWNWWN(WN(E|WSWNWW(SESWSEENESS(WW|EN(N|ESE(SWWEEN|)N))|NN(EES(ENSW|)W|WSWNNNEESW(ENWWSSNNEESW|))))|EE)|S)|SWN(N|W))|N)))|SWWSW(WSWSS(WNWWNNNWSSWWSWSWSSWWNNE(S|NENWWWS(SWWSWS(SEES(WW|EN(NNWSWENESS|)ESESE(NEN(WW|ENWNEE(SSSWENNN|)EEN(WW(NEWS|)W|E))|S))|WWNENENNWWS(E|SWWWSEESWSSWNWN(W(NNNE(ENWNW(NENNNW(NENWNENEEESENNENENNE(NWWWWSES(ENSW|)WS(E|SWNWWNNESENNWNNNWW(NNENESEESSENEEEE(ENENWNWWNWSSES(ENSW|)WWWNNE(NNNNESES(ENESS(W|EENWNENNWSWNNEEEENWNWSWWWSWS(SENSWN|)WWWSWWNENNEENWNENESENESES(WWWS(SWWEEN|)E|ENEENNWNWNNNWNNNENWNEENWNNEENEESWSSESWW(NNWESS|)SWSESWWSESESS(WNSE|)SEENWNNN(NENWNEEENESEEESSEEESSWWN(E|WSWWSSEEN(EEEESESS(WNWNWSSWWN(ENSW|)WSWWN(E|WNNNWN(WSSESSSESSWSSENEEESEE(NWNEEEN(ESNW|)(N|WWWWWS(WNSE|)E)|SWSWNWNWSWWSESSWNWN(WWSSSEE(NWNSES|)SSEESWSWSS(ENENESENNNNNNN(NWSSSWWSEESS(NNWWNEWSEESS|)|ESENENES(SWS(E|WSSW(SESSSW(SW(NWWEES|)SE(ENENNE(NE(NWW(NN|S)|E)|SSEESSE(N|S(E|WWWNN(ESNW|)W)))|S)|NN)|NN))|E(N|E)))|SW(SEWN|)NWNNE(N(NW(NEWS|)W(S(SSWENN|)E|W)|E)|S))|NNNWNEN(NWSNES|)E))|ENN(WSNE|)ESES(ENNW|WSSS)))|EENESESENNNW(S|NEEEESSESSWWSW(WSSENESEESWSESSWWSESEESW(WWNW(S|NNNWSWWNNN(WSSNNE|)ES(ENESE(SEWN|)N|S))|SEEES(WSEWNE|)ENNWWNNNNW(SSWENN|)NEESESSS(WNNSSE|)EENWNNNEESWSESSESSESSSENE(SSSSWWNENWWNNNWNNWWSSE(N|SESWSESS(ENSW|)(WWWNEE|SSS))|NWNENNNWNWS(SSENSWNN|)WNNEEESEENNW(NNENEESWS(ESENNENNW(WWNEEENESEEENENNNNWNWSWWWNEENEEESEENNEENEESWSSENENNEENEESSSEEESESESESWWNWWSESSSENNEESENENNNW(WNEEENNWSWWW(NENNNNESENEEEESSESSWNWW(SSE(SWSEESWWSW(SSWSWWW(N|SESESEESWWSSSWNNNNWNWSWSEESWSSWNNWSSWSWSSWNNNENENNENNWNE(E(E|S)|NWWNNE(ESWENW|)NWWSWWWSESWWNNWSWNWNENEN(EESWS(EENE(S|NNNN(E(SSSSEENN(WS|ESE)|N)|WSS(W|S)))|W)|WNNWSSWS(SSW(SSSEEEE(NWWNWS|ESWSESWWSESWWWSEESSSESESWSWNWWWNEE(E|NWWWNWNWSWWSSWWW(WNENEE(SWEN|)NWNN(ESEE(SWEN|)EENEE(SWSESEENW(ESWWNWESEENW|)|NWNWSWWW(SEEWWN|)N(WSNE|)EENWWNEN(W|EEE(SW(SEESESENNWN(EESNWW|)W|W)|N)))|WW(SESWWS(SSWNNN|E)|N))|SEESS(WWNEWSEE|)EESWSWWSWWWSSSWNWSW(NWES|)SEESEEES(WWWWS(WWN(WSS|ENE)|E)|EEESSWW(NEWS|)SSSESSWWWW(SSWSESENNEN(EEESWWSSENEESENEESSW(N|WWSEESSSSEEENESEESENNNWNWWWWW(NEEEEEEENENESEENWNWWWNEENENESS(SESESWSESENNENWNWNWNENNW(S|NNNWWSSWS(EENNSSWW|)SWSWNWSSWWWSWNNEENWNWWS(WSS(WWWNEENNWSWNNNENW(NNNNWWWNNWW(NEN(W|EEESENN(WW|EN(W|NESSSWSSS(ESWSSENENNEEESSESESWSSENENENNW(S|NEESENNNNESSSEESESWWW(NEWS|)WWSSWSSS(WW(N(ENSW|)W(S|WWWNEENWWNN(WSW(W|SSS(E(S|NN)|W))|E(ESW|NWNE)))|SS)|ENNENNEEEEEESWWSSENEEEEEEENENEESSEENNNW(SS|NNWNENNNNWWNEEESENNESSESWSSESSEENNESSENEENWNENWNNNNNNWWNENESEENNEEESEENE(NNWWS(S|E|WNWWWS(EE|WWS(ESNW|)WWWS(SSWSWWWNNWNWSSWSWNNENWWNNWSWSWWNWSSEEESWWWSESESWWNWWSESSENEESEENWNENN(NN(N|ESSSES(EEEN(W(NENSWS|)W|EEEEEEE(NWWEES|)SWSWNWWSESSEEE(S(WWW(W|SS)|S)|N(N|WW)))|WSSSSWNWSWWSSSSEENNEN(WWSSNNEE|)ESE(SSWS(EENSWW|)W(NNEWSS|)WS(WS(E|WNWSWNNWWNNNNNEEE(SSSWW(NNESNWSS|)SEESEE|N(WWNNWNNWWWSEESSS(ENSW|)SSWW(SEESNWWN|)NNE(S|NWN(E|WWSS(ENSW|)WSWWSS(EENWESWW|)WNW(SSESNWNN|)WNWSWWN(WSNE|)NNNESS(EEEE(SWEN|)EENWWWNEENWN(WWWS(SE(NE|SW)|WWNWNE(NWWNE(NWWSSWSEES(NWWNENSWSEES|)|E)|E(S|EE)))|EESE(S(S|W)|ENWNW(NENNNNNNNNENENN(ESS(SWS(E|SW(N|SSSSSESWSE(SS|ENNESSEEENE(NWNENN(EEE(NNES(S|ENN(ESENNNWSWNNEEENNNEEESSWSSSSWSSW(W(W|SSENESENNNENEEESESENES(SWWWSWNWN(NESEWNWS|)WSSSE(N|ES(EN|WSE))|ENE(EEEENNWWNNWSSWS(EEE|WWNNWWWS(EESWENWW|)WNNNW(NNEENWWNNWSWS(WNNENNNW(WWSEESWSSWS(E|SWN(WSSS(ENESNWSW|)W(W(SEWN|)W|N)|N))|NNNESSEENESENENWNNNESSENENWNENNEENNESESENEEEE(NNWNWSWS(EE|WWNENWWWNEENEEEEE(NWWNWWWS(EE|WNWNEEEEENNNEE(SWSSSENN(SSWNNNSSSENN|)|NNWNENNNWN(E|WSSWWSWSESSSSS(ENNNNNE(SSEWNN|)N(ENSW|)W|WWWWNNWSWWNWWNNWNWSWNNWNWSSESSESWSWNNWWWWSWWNENENEEE(S(E|WW)|NNNEEESESEESEEESS(WWNEWSEE|)(EEENWNW(S|NWWNNWS(WNN(EEESEEN(EESWSS(WNWWEESE|)E(S(W|SSSWSEENNN(SSSWWNSEENNN|))|NENEN(ESNW|)W)|W)|WW(SESNWN|)WWWWWSSWNNWWWSWSSENES(SWSWSWWNEN(E|WNNWWWNN(WSWWSWWWNEEN(WWWWSWWWN(EE|WWWSSSEEN(NWSNES|)ESSSWWWN(WNWNNWSWWSEESESSSWNWN(E|NWWWSSWWWWWWWSWWNNWWSWNNEEEES(ENESENENNWWS(WWWWNEENWN(WSWSWS(E|WSWNNNN(WSSSWWWWNEENE(S|NWWWWS(EE|WSSE(N|SSESSEENNW(S|N(EESE(EESSEEE(N|SESWSSWWWWWWSWNNWWWNN(EEEENNESE(SWSS(WNWWWEEESE|)EEENN(WSW|ESS)|N)|NWWNE(E|NWN(NWSWNWWNENWWWWWWN(EEEEEEEESE(SWWN|NE)|WSSSENEESENESSSENESEESSSEESSWWSWSWNWWWNWWNEENNN(ESEEE(NWWEES|)SS(EE|WNWWSES(EE|W))|WNWSSS(ENSW|)WSSWNWNNE(S|ENWNWWWSE(SSSSESSENESESWSWSWWWNEEN(E|WWWWNWNENWNEEE(NNWNWNWSWWWNNNWSSWSWNWNNESENNNWSWWWSW(SEE(SSWW(NEWS|)SEEE(N|SSSSWNNNWSSW(SSE(ESSWNWSSESESEESSWWN(WNW(N|SSESWSESSW(SSSENEEESWSSESESWSEEEEE(SE(SWS(WWWNWSSWNNN(EEEESW|WSSWWW(SSSENNEESWSSWSSE(SSWSESWW(NNN(NNN|E)|S(S|EEESENNENWN(WSSNNE|)E))|NENNEN)|NENWNNESE(NE(S|NWNWW(NEEN|SE))|SS)))|ESE(N|E))|N)|NWWNW(S|NENWW(S|NEENEE(NWWNWWWWS(EEESWENWWW|)W(NNENN(WSNE|)ESSENNNNNNEEESSWNWSSESWSSEEN(W|EE(SS(S|W(N|W))|EENEENEEENWWNWWWWNE(EEEEEEN(W|EN(W|ENWN(NWES|)EESSSWSESWW(SEEESSESSWSWWSEES(ESWSEENENWNWNENEENNWW(SEWN|)NENNNWNEEEEESSSWWNN(ESNW|)WSSSEEESWWSEESWWSSESSWW(SSW(N|SEESEE(NNN(ESSSENNNNWNW(S|NEESENEENNWSWNNEEENWNWSWNWSSW(NNNENEES(ENNWWNENEENN(WWS(E|WSWSW(NWWNNN(EESWSEE(WWNENWESWSEE|)|WWSWSWWS(W(SSSE(ESWSNENW|)NN|NN)|EEEEN(N|W)))|S(E|S)))|ESESSESWWSW(SSESESSW(N|WSSESENN(W|ENNNENNEENWW(WWS(ESWENW|)W|NEEEESWSSSSSWNW(NNESNWSS|)WSESWSSENENESESSWSSSSWSSSEENN(WSNE|)NEESWSSEEN(W|NNNWNNNNNNW(SSSSWSSEN(SWNNENSWSSEN|)|NENENEENWNWNNNNNWWNENNWSWWSWWSWN(W(W|SSEES(ENNESSEN(EESSW(N|SESWSE(SWSW(NNN|SS)|E))|NN)|W))|NEN(W|NES(EENNN(EEEESSW(NWWSEWNEES|)SESS(WNSE|)SSENESSSWW(NEWS|)SEEESSENNNENWW(S|NNNWWNENWNNEN(E(NWNEWSES|)SE(N|ESSWNW(W|SSEEEENWNNENN(EEEEENEEENWWNEN(WWSSNNEE|)E(SEEEEEE(NWES|)SENEESWSSE(N|SSEESWWSWNWWWWNWNWNEENWWN(WSSWSESESWWSSWNNN(NW(NEWS|)WSESWSSSWNNNWSSWNW(N(W|NNEES(EN|WS))|SSWSWWW(NEEWWS|)SEESESWSESSESWWSWWSSWNWN(EN(WNNWESSE|)EENENWN(SESWSWENENWN|)|WSW(SW(SESEESWSWW(SESSEENESE(SSS(WWS(EE|WW(NNNEEESWWS(NEENWWEESWWS|)|WSEESWWWWWWWNEEN(EESWENWW|)WWWWSSE(N|SEEEESWWWWS(W(S|WNENWNNNWSW(NNNENENNWSWNWNNN(EEE(SES(WWWNEWSEEE|)ES(SSSW(NNN|WS(EE|W))|ENNWN(ENEWSW|)W)|NN)|WSSWW(NEN(NEEWWS|)W|SSENESES(E|S)))|SS(WNWSNESE|)SSENNN))|EEESEEN(W|NNE(SSS|E))))))|ENEN(EESWS(SENENN|W)|W))|NNWN(WSWSNENE|)NNEN(WWNWSNESEE|)EEEEEENNWN(WSS(E|WWWNEEN(SWWSEEWWNEEN|))|NESENNNNNWNENWN(EEEN(ESEEENNW(SWEN|)NEE(SSESSSESSWSWWSWNWNWSSSE(N|ESWSSENESSWS(WNWSWWS(E|WS(S|WNWWN(WSWNWSS(WNSE|)SENEEE|EEENNEE(SWEN|)NW(NE(ESSNNW|)NWNNNE(NWNEEN(ESENESSS(WNWWEESE|)EN(NNN|E)|WW)|SS)|W))))|EENNNENWN(WSNE|)NEEEN(NESEENEENNWWS(E|W(WNW(NNW(S|NNEE(NWWWSNEEES|)S(ESWSE(ENNN(W|ENESESWWSES(EEN(ESESWWWSEEESSEESSSENNNNESSSSESESS(WNW(NWWWNWSWNWWS(E|WNWSWWWSESW(WWWNENE(S|NWN(W|EESEENN(ENEENESE(N|SS(ENESNWSW|)WNWSW(W|N))|W(S|W))))|SSEEN(NESE(NNWWEESS|)SWS(S|WWW)|W)))|S)|EEE(SWWSNEEN|)NWNNNENNWSWWW(SEES(W|SS)|NNNWWWNNW(SSSEWNNN|)NWNEEES(EESENNWNW(S|NEESEESENNNE(ESSENE(NWES|)SSWSWW(N(NN|E)|SSWWW(SS(W(SEWN|)NNWWNWS(NESEESNWWNWS|)|ENEEENEN(ESSWSES(WWNW(W|SSES(ENSW|)WS(WSNE|)E)|ENN(EE|NNN(W|E(NWNNSSES|)E)))|W))|NEN(ES|WN)))|NWWW(NENWESWS|)S(SENSWN|)W(WWWNNWSW(N|SWNWSWS(WNN(NWWEES|)E|EEES(WWSWNSENEE|)EN(ESNW|)N))|N)))|W)))|W)|W))|S)|W))|S)|S))|W)))|N)|NN)|W(NEWS|)SW(W|N|SESSS(WNN|SENN)))))|N(E|N))|N)|N)))|E)|EEESEESSESWWNW(NEWS|)(S|W)))|N)|N)))|W))|WS(S|WW))|S))))))))|NN(ENSW|)W))|W)|SESWWW))|WS(WNSE|)S)|SWS(W(NWNWESES|)S|E)))|N(NWNEWSES|)E)|WWWNNNWNENN(EESWSE(SWEN|)E|W(NNWWEESS|)SWSSSS(ENSW|)W(S|N(NNNWESSS|)W)))|N)))|NWWW(NE(NWNWNENNNWSSWSWWSESWSS(EEENW(N(E|N)|W)|WW(SEWN|)(NNNE(SS|NNNESENNWWNEE(E(SS|EEEES(E|W))|N))|W))|EE)|SSE(N|SSW(WSEEENEEN(WW|E)|N))))))|W)|SSW(SESWENWN|)N)|W)))|N))|E)|N)|NN))|N)|NNEN(W|EE(SWEN|)EEESSENNEESSSW(SSENENNENEEN(WWWSNEEE|)ESE(SSS(EE(E(EESNWW|)N|S)|WNNWSW(N|S(WNSE|)(S|E)))|N)|NN)))|SWSSEENW(ESWWNNSSEENW|)))|E))))|E))))|N)|W)))))|EE(SWSNEN|)E))|EES(EEEN(EESSW(SEE(SWWS(W|EE)|EENWWNEN(ESEEN(EEESSNNWWW|)W|W))|N)|WW)|S))|E)|S))|EE))|EE)|EES(ENE(E|SSS)|W)))|E(NNWESS|)EE))|S))|S))))))|S(WWW(W|S)|S)))|SSSWWWWN(EEENWW|WW(N|SESSESWSEENNN(W|ESSSENNNESSSSSWNWSSEESSWWWSESSSEE(SWSWSWW(SEESESE(SWWNSEEN|)NNN(WSNE|)N|NEN(E|NWSWWS(WWNENEENEENWWNENNWWWNNWNEE(NNNWN(E|NNWSSSSWS(EENSWW|)WSSE(N|SSE(SSSES(ENNN(WSNE|)E|WSWWNW(SSSS(WNNWESSE|)EE(NNWSNESS|)ES(ENSW|)S|NNEN(ESS(S|W)|WWNEN(ESNW|)(WWSS(SSENSWNN|)WWNENW|N))))|N)))|SES(EE(SEEWWN|)NNW(S|W)|W))|E)))|NWNENW))))))|E)|SWSSEN))|S)))|NNNEN(NNNEWSSS|)W)|WW))|S)|WWS(W(S(WNSE|)SE(SWEN|)N|N)|E)|NN)|S))))|E)|NW(NEWS|)SSWSW(NNEWSS|)SSSW(SESSW(SESNWN|)WN(N|E)|N))|W)))|S)))|E(N|E))))|E)|NENNWS)))|W(S|W))|E)))|SSSSWNNWWWNWSSSWSW(NNEWSS|)SSSESESESSEESENE(NWWNW(S|NNW(NW(N(WSNE|)EEEN(NWN(WSS(E|W)|E)|ESSW(SEE(SSWNWESENN|)NNN|W))|S)|S))|SSSWNWSWSESENESSWSESSWWWSWNWWWNWSSWNNWWNWSSESSE(SWWWNENWWNNNW(SWNWWWSESE(SENESSESWWWN(WWN(E|NWNN(NENSWS|)WWWSEESWWWWWNN(ESENSWNW|)WSWSESS(WNSE|)SENNEESSSSWSESENNNENNN(WSSNNE|)ESE(N|SSW(SWSSEEESWWSWSWSWWWWNNN(WWSWSSWSSEESESSWNWSSSWSEESWSEENNNWNEESSENNNNNW(NEN(WW(NW(NEN|SW)|S)|EEEEEN(W|NEEN(EESSSSESSSWSESSSSENESENNNEESENNWWNNNNWWSW(SSSE(SSWNSENN|)ENWNEN|NNWNNNNWWNEENWWWW(NEEN(NWSNES|)EES(ENEESSSWN(N|WSSEEESWWSS(WNNSSE|)ENEENNNENNEN(EENENE(SESSENNN(W|ENESE(N|SWWSESSW(SWNWWNNWSSSEESWWSESSSWSWSSEEN(W|ESSEENWNNEEE(NNNWSWWW(S(SWEN|)EEE|NEN(NEES(WSNE|)ENN(NNN|W)|W))|SSSSSWWN(ENNNWESSSW|)WSWNWSSWNWWNW(SSSEE(NWES|)SWWSSWSWSWWWNNN(WSWSWWSEEE(N|SWWWSWSSWSSEESSENESS(WWWNWN(E|WNWNWWWWNNESEENENWNEEE(SWS(E|S(W|S))|ENWWNEENWNWNWSWNWNENWNNW(SSSWSSSWSSWWWSEEEES(WSWWWSESWWNNWNE(NWNWNNENWWSWSESWWNNWSSSSWWSWNNENE(NNNENNWWNEENNNNNWSWWWWSWSEEEN(ESS(ENNSSW|)WWSESSE(SWSS(ENSW|)WNWNNE(NWWSWWNWNNESE(EN(ESNW|)WNWWWWNNNWNENNNWSSWWNENWNNWNWW(NEN(W|E(SESESES(ENNNN(ESE(NN|SESE(N|SWWSESWSESEES(SWWS(E|WWNNE(S|EE|NWNNNNN(E|N)))|EEENNEE(NWWWWS(SENSWN|)WNW(S|N)|S(WSNE|)EESSSSESEENE(NE(S|NN(WWS(WS(E|WNNENNW(NNEENENE(SSWSSSWNNW(ESSENNSSWNNW|)|N(ESNW|)NWSWNWSS(SWNNWESSEN|)E)|WW|S)|S)|E)|E))|SSSWS(EE(N|SEESE(NENNSSWS|)SWWW(NEWS|)(S|W))|WNN(E|WW(SSE(SWEN|)N|N))))))))|W(NN|W(SESNWN|)W))|W)|N))|SWW(NEWS|)WSESWSSWWNN(NESSNNWS|)WWWSSESSWWSSSSESSWSWNWWNWSSW(NNWNW(NNWSWNNW(SS|NNESESENEEENNN(EEEE(NWNSES|)SWWSE(SSSWWN(ENWNNSSESW|)WSSW(WNNESNWSSE|)SEENESE(N|S(W|E))|EE)|WWWSEESWWWNNNW(NN(NNW(W|S)|ESESE(N|E))|SS)))|S)|SESSW(WN(E|N)|SSESSSW(NN|SEENEEENWNENENENWNN(NESSEESENNNNESESEEESESWSWWWNN(ESENSWNW|)W(N|SSWWSEESSSWNWSWWW(SSENESSENNESSENNEENWNEEENWN(WSWNSENE|)EEESSESSSSENNENNNW(WNEEENENWNEN(NWNWNN(ESNW|)WSSWSEES(E|WWSEESWS(E|WW(N(E|NNWNWWNW(WNWWNNENNNWWSW(SSE(NENSWS|)SSSSW(SEWN|)NWNENWNNNWSS(NNESSSNNNWSS|)|NN(NNWESS|)EEEESSENNNENNW(SWSNEN|)NEE(N|SE(SWSSWSSEEEE(NNWSW(NN|W)|ESWS(SWWWWS(EEE(E|S(WW|S))|WNW(W|NEN(EES(EENWESWW|)W|W)))|E))|N)))|S))|W)))|ESSEE(NNWSNESS|)ESE(E|SSWWN(NWWSESSSENESE(SSWSEEESWWWS(WNWNENWWWNNNN(N|ESSSEEE(WWWNNNSSSEEE|)|WSSSSWSESS(WWN(E|WSWWNENWNENWWSW(NNEE(NN|E)|SSE(N|SWWNNNWSSWS(WWWN(EE|WWN(WSS(EE|WWNWWWNN(W(N|WWWWSWSEENEESS(W(WWWWNWWWNWNEEEE(SWWEEN|)EN(NWSWWNEN(WWSWS(E|WWNWWNWWWSEESSWSSWNWSWWS(WNWWWS(EE|WWNENEEENEES(ENEN(NWSWNWSWWNNNNN(WWSSE(SWSSWS(WNNWWSESWW(NNNNNNNEESWSEESS(WWNEWSEE|)E(S|NNNWNENNWSWWNW(S|NEE(S|EE)))|SSENESS(ENNEWSSW|)WW)|EE(NN|E))|N)|NNESESWSSENENN(NWNNNNE(WSSSSEWNNNNE|)|ESEESWS(EEEEENEENWNE(ESESWS(EEENWNNW(ESSESWENWNNW|)|SW(NWSWENES|)S)|NNW(N|SWWSESWSWWNN(E(NWES|)S|WW)))|SWN(WSWWSNEENE|)N)))|E(S|E))|W))|EEEEEENWNENE(NWES|)ESWSSEEE(EEE|NW(NN|W))))|EE)|E)|N)|E(EEE|NN)))|EEENES(ENSW|)S(S|WWW)))|E))|E))))|ENE(SE|NW)))|EEEEEEENNWWW(SEEWWN|)NWWNEEENN(WSWWEENE|)ESESS(W(W|N)|ENEE(SSSWS(WNNENSWSSE|)EEEENEEEEEES(WWWWW|EE(NWNWWWN(EE|WWW(NENWESWS|)S(WWN(WSSEWNNE|)E|EE))|E))|NWNW(S|NENWWWSES(NWNEEEWWWSES|)))))|N)|E)))|SS)|NEEN(N(WSWENE|)NN|EE)))|WSSWNNWW(NEWS|)SESWS(W|SE(SWSEWNEN|)NE(E|S)))))))|S)|S)|E)|W)|S)|EEE)|ENNWNEES(SSS|ENN(WWN(N|E)|E(E|SS))))|NEENENEN(EESWSSW(SW(S(WNSE|)ESEENN(WSNE|)E(SESWSWW(WWNSEE|)SEEE(S(E|W(SEWN|)W)|N)|NWNEN(ESNW|)NNWWNEEN(SWWSEEWWNEEN|))|N)|N)|WWSWNWSSE(WNNESEWNWSSE|)))))|EENWNNNEEESWWSEESEEENENEESWSEEEENNESSS(EENNW(S|NENWNWSWWW(SSENSWNN|)WWNWNNWWSESS(E|SWNW(SSEWNN|)N(E|NWSWWWNN(ESENEEN(EEENESSSEEEE(SWWWEEEN|)NNWWS(WNNEEENWNENNEENE(NWWWS(E|W(N|WWSSSWNWSS(WSWENE|)EEENNENW(ESWSSWENNENW|)))|SSSWW(NEWS|)SESSW(SEE(S(S|WW)|NNN)|N))|E)|WWW)|WSW(N|WSEESSWNWW(EESENNSSWNWW|))))))|WWWWWW(N|WWWWWN))))|EEE(SWWSEWNEEN|)NWN(EESSNNWW|)N)|NWWNNNNEEE(SSS(SEE(SWEN|)E|WNNWSS)|ENENWWNENNWSW(SW(SS(WWSWWEENEE|)E(N|E)|N)|NNEENW)))))|N)))|NWWSWSWN(SENENEWSWSWN|))|WWWSESWS(NENWNEWSESWS|)))|W)|W))|W)))|SS)|EN(WNENNENN(SSWSSWENNENN|)|ESES(ENE|WWSEE)))|N)))|E)|N)|NNNESEES(ENNNWSWNN(EEESSSEESS(WNWSNESE|)ENESENEN(NNNENWWSSWNN(WWSESS(EESWWEENWW|)WNW(S|N)|NN(ESNW|)N)|ESESS(E|WW(NEWS|)WW))|WSWNWNNE(ESWENW|)NNW(NEWS|)S)|W(W|SSS)))|NN))))))|WWWN(NWES|)EE))))|S(W|E))|WWSESSS(NNNWNEWSESSS|))|E(N|SSEEES(EEN(NW(S|W)|E)|WWW)))|E))|W)|SSENEEESE(WNWWWSNEEESE|)))|W)|NEN(WWNSEE|)E(SEWN|)N)))))|NNN)|E))))|NN)|N)|NW(NEESNWWS|)WWS(S|EE))|S)|SS)|S)|W)|S)))|NNNE(SE|NW))))|W))|W)))|W)|S)|SWWWSS(EEN(W|E)|WWWN(NNWWEESS|)EE))|SESWS(E|SSSS(EE|S))))|ESWSESWWSESENEESWSWSWSSEEENW(NEEN(W|NNNEESS(EENWNNWWWNWSW(SEWN|)NN|W(N|SSSWSSSS(ENEEE(SWWSNEEN|)NWWN(WSNE|)N(NN|ESENEESS(WNSE|)EN(N|ESSWSSENE(WSWNNEWSSENE|)))|WNWSWW(SESWENWN|)WNWNE(NNWSWWNNWN(NWSSSESWSSSEE(SWSEWNEN|)E(E|NWN(WSNE|)E)|EEEE(E|NWN|SWWS))|ESENEE)))))|W))|SS)|S)|SS)|SSESWSSSSS(SSS|E(N|E)))|E)))|E))|ENENEENE(WSWWSWENEENE|))|N))|WW)|SWSWS(ESSSE(SSWNWN(WSSESS(ENESSSSS(ENNNNSSSSW|)(W|S)|WNWSWWS(WWNENNN(WSW(S(E|SSWSSEE(N(W|E)|SWSES(E|WWWNENWNWW(NENNE(SS|NE(S|NWWSW(SS|NNN(ESNW|)NWW(SEWN|)W)))|W))))|N)|ESSENNES(NWSSWNSENNES|))|EE))|NN)|EN(NWS|ES))|WNW(S|W)))|S))|ENE(NWES|)EESSSW(NNWESS|)S)|SSW(SSENSWNN|)N)|WW)))))))|WWW)|ENE(S|E))|SS))))))|N))|E))))|W(S|W)))))|W(N|WWW(NWSNES|)SES(SENNESS(NNWSSWENNESS|)|W)))|N))|S)|E)$
