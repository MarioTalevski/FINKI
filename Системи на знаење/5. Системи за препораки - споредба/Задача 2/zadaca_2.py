oceniPoKorisnici={
    'Lisa Rose': {'Catch Me If You Can': 3.0 , 'Snakes on a Plane': 3.5, 'Superman Returns': 3.5, 'You, Me and Dupree': 2.5, 'The Night Listener': 3.0, 'Snitch': 3.0},
    'Gene Seymour': {'Lady in the Water': 3.0, 'Snakes on a Plane': 3.5, 'Just My Luck': 1.5,  'The Night Listener': 3.0,'You, Me and Dupree': 3.5},
    'Michael Phillips': {'Catch Me If You Can': 2.5, 'Lady in the Water': 2.5,'Superman Returns': 3.5, 'The Night Listener': 4.0, 'Snitch': 2.0},
    'Claudia Puig': {'Snakes on a Plane': 3.5, 'Just My Luck': 3.0,'The Night Listener': 4.5, 'Superman Returns': 4.0,'You, Me and Dupree': 2.5},
    'Mick LaSalle': {'Lady in the Water': 3.0, 'Snakes on a Plane': 4.0,'Just My Luck': 2.0, 'Superman Returns': 3.0, 'You, Me and Dupree': 2.0},
    'Jack Matthews': {'Catch Me If You Can': 4.5, 'Lady in the Water': 3.0, 'Snakes on a Plane': 4.0,'The Night Listener': 3.0, 'Superman Returns': 5.0, 'You, Me and Dupree': 3.5, 'Snitch': 4.5},
    'Toby': {'Snakes on a Plane':4.5, 'Snitch': 5.0},
    'Michelle Nichols': {'Just My Luck' : 1.0, 'The Night Listener': 4.5, 'You, Me and Dupree': 3.5, 'Catch Me If You Can': 2.5, 'Snakes on a Plane': 3.0},
    'Gary Coleman': {'Lady in the Water': 1.0, 'Catch Me If You Can': 1.5, 'Superman Returns': 1.5, 'You, Me and Dupree': 2.0},
    'Larry': {'Lady in the Water': 3.0, 'Just My Luck': 3.5, 'Snitch': 1.5, 'The Night Listener': 3.5}
    }

from math import sqrt

# Vrakja merka za slicnost bazirana na rastojanieto za person1 i person2
def sim_distance(prefs,person1,person2):
    # Se pravi lista na zaednicki predmeti (filmovi)
    si={}
    for item in prefs[person1]:
        if item in prefs[person2]:
            si[item]=1
    # ako nemaat zaednicki rejtinzi, vrati 0
    if len(si)==0: return 0
    # Soberi gi kvadratite na site razliki
    sum_of_squares=sum([pow(prefs[person1][item]-prefs[person2][item],2)
        for item in prefs[person1] if item in prefs[person2]])
    return 1/(1+sqrt(sum_of_squares))

def sim_pearson(oceni,person1,person2):
    zaednicki = {}
    for item in oceni[person1]:
        if item in oceni[person2]: zaednicki[item] = 1
    n = len(zaednicki)
    if n == 0: return 0
    
    sum1 = 0
    sum2 = 0
    
    sum1Sq = 0
    sum2Sq = 0
    
    pSum = 0
    for item in zaednicki.keys():
        ocena1 = oceni[person1][item]
        ocena2 = oceni[person2][item]
        sum1 += ocena1
        sum1Sq += ocena1 ** 2
        sum2 += ocena2
        sum2Sq += ocena2 ** 2
        pSum += ocena1 * ocena2
    
    num = pSum - (sum1 * sum2 / n)
    den = sqrt((sum1Sq - pow(sum1, 2) /n) * (sum2Sq - pow(sum2, 2)/n))
    if den == 0: return 0
    r = num / den
    return r
    
def transformPrefs(oceni):
    result = {}
    for person in oceni.keys():
        for item in oceni[person]:
            result.setdefault(item, {})
            result[item][person] = oceni[person][item]
    return result


def topMatches(prefs,person,n=7,similarity=sim_pearson):
    scores=[(similarity(prefs,person,other),other) for other in prefs if other!=person]
    scores.sort()
    scores.reverse()
    return scores[0:n]

def getUserBasedRecomendations(oceni,person,similarity=sim_pearson):
    totals = {}
    simSums = {}
    for person2 in oceni.keys():
        if person2 == person : continue
        sim = similarity(oceni, person, person2)
        # ne se zemaat vo predvid rezultati <= 0
        if sim <= 0: continue
        for item in oceni[person2].keys():
            # za tekovniot korisnik gi zemame samo filmovite sto gi nemame vekje gledano
            if item not in oceni[person] or oceni[person][item] == 0:
                totals.setdefault(item, 0)
                totals[item] += oceni[person2][item] * sim
                simSums.setdefault(item, 0)
                simSums[item] += sim
    rankings = []
    rankings=[(total/simSums[item],item) for item,total in totals.items()]
    rankings.sort()
    rankings.reverse()
    rankings=rankings[0:3]
    return sorted([x[1] for x in rankings], key=str.lower)
    
def getItemBasedRecomendations(critics,person1,similarity=sim_pearson):
    oceni_po_film = transformPrefs(critics)
    similarity_per_item = {}
    for item in critics[person1].keys():
        similar_items = topMatches(oceni_po_film, item, n=None)
        my_rating = critics[person1][item]
        for similarity, item in similar_items:
            if item in critics[person1] or similarity <= 0:
                continue
            similarity_per_item.setdefault(item, [])
            # similarity_per_item[item].append(similarity)
            similarity_per_item[item].append(similarity * my_rating)
    similarity_per_item_avg = []
    import numpy as np
    for item in similarity_per_item:
        avg_sim = np.mean(similarity_per_item[item])
        similarity_per_item_avg.append((avg_sim, item))
    similarity_per_item_avg.sort(reverse=True)
    return sorted([x[1] for x in similarity_per_item_avg][0:3], key=str.lower)
    
def recomend_movie(oceni,korsinik,n,similarity=sim_pearson):
    
    if n > len(oceni[korisnik]):
        print "item-based"
        print getItemBasedRecomendations(oceniPoKorisnici, korisnik)
    else:
        print "user-based"
        print getUserBasedRecomendations(oceniPoKorisnici, korisnik)
    

if __name__ == "__main__":
    korisnik=input()
    n=input()
    recomend_movie(oceniPoKorisnici,korisnik,n)