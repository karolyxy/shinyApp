import pandas
import collections as cllc

colnames = ['userId', 'movieId', 'rating', 'timestamp']
data = pandas.read_csv('./ml-latest-small/ratings.csv', names=colnames)


users = data.userId.tolist()

cnt = cllc.Counter(users)
print(cnt)