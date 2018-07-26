import pandas
import collections as cllc
from itertools import chain

colnames = ['userId', 'movieId', 'rating', 'timestamp', 'title', 'genre']
data = pandas.read_csv('./movie_ratings.csv', names=colnames)

genres = data.genre.tolist()
genres_split = list(map(lambda ele: ele.split('|'), genres))
genres_all = list(chain(*genres_split))
#print(genres_all)

# users = data.userId.tolist()
# count_users = cllc.Counter(users)
# print(count_users)

genres_unique = list(set(genres_all))
print(genres_unique)

count_genres = cllc.Counter(genres_all)
print(count_genres)
