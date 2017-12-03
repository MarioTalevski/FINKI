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

def sim_distance(oceni,person1,person2):
    zaednicki = set()
    for item in oceni[person1].keys():
        if item in oceni[person2]:
            zaednicki.add(item)
            
    if len(zaednicki) == 0:
        return 0
    
    sum = 0.0
    counter = 0
    
    for item in zaednicki:
        ocena1 = oceni[person1][item]
        ocena2 = oceni[person2][item]
        sum += (ocena1 - ocena2) ** 2
      
    result = 1 / (1 + sqrt(sum))
        
    return (round(result,3), len(zaednicki))

def sim_pearson(oceni,person1,person2):
    zaednicki = {}
    for item in oceni[person1]:
        if item in oceni[person2]:
            zaednicki[item] = 1
            
    n = len(zaednicki)
    
    if n == 0: 
        return 0
    
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
        
    # Presmetaj go koeficientot na korelacija
    num = pSum - sum1 * sum2 / n
    den = sqrt((sum1Sq - pow(sum1,2) / n) * (sum2Sq - pow(sum2, 2) / n))
    if den == 0:
        return 0
    
    r = num/den
    return (round(r, 3),n)


if __name__ == "__main__":

    korisnik1=input()
    korisnik2=input()
    # korisnik1='Mick LaSalle'
    # korisnik2='Lisa Rose'
    print sim_pearson(oceniPoKorisnici, korisnik1, korisnik2)
    print sim_distance(oceniPoKorisnici, korisnik1, korisnik2)