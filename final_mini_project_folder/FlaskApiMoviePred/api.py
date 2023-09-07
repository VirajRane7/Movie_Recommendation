from flask import Flask,jsonify,request
import pickle

import pandas as pd
import numpy as np


new_df = pickle.load(open('model/movies.pkl','rb'))
similarity1 = pickle.load(open('model/similarity2.pkl','rb'))
genre_df = pickle.load(open('model/genre_df.pkl', 'rb'))





app = Flask(__name__)

@app.route('/api',methods = ['GET'])
# def returnascii():
#         d = {}
#         inputchr = str(request.args['query'])
#         answer = str(ord(inputchr))
#         d['output'] = answer
#         return d

# def predictMovie():
#     d = {}
#     movie = request.args['query']
#     new_entry = new_df[new_df['title'] == movie].index[0]
#     dist = similarity1[new_entry]

#     distances = sorted(list(enumerate(dist)), reverse=True, key=lambda x: x[1])[0:10]
#     recommended_movies = []
#     for i in distances:
#         recommended_movies.append(new_df.iloc[i[0]].title)

#     d['output'] = str(recommended_movies)
#     return d   
def recommendOnGenre():
    d = {}
    percentile = 0.85
    inputChr = str(request.args['query'])
    df = genre_df[genre_df['genres'] == inputChr]
    vote_counts = df[df['vote_count'].notnull()]['vote_count'].astype('int')
    vote_averages = df[df['vote_average'].notnull()]['vote_average'].astype('int')
    C = vote_averages.mean()
    m = vote_counts.quantile(percentile)

    selected = df[(df['vote_count'] >= m) & (df['vote_count'].notnull()) & (df['vote_average'].notnull())][['id', 'title','popularity','vote_average', 'vote_count','poster_link_w185', 'poster_link_w342', 'poster_link_w154']]
    selected['vote_count'] = selected['vote_count'].astype('int')
    selected['vote_average'] = selected['vote_average'].astype('int')
    
    selected['wr'] = selected.apply(lambda x: (x['vote_count']/(x['vote_count']+m) * x['vote_average']) + (m/(m+x['vote_count']) * C), axis=1)
    selected = selected.sort_values(['wr'], ascending=False)[['title','poster_link_w342']].head(50)
    # d['output'] = selected.values.tolist()
    # selected = selected[['id', 'title','wr','poster_link_w185']]
    # print(str(selected.values.tolist()))
    # d = selected.to_dict()
    row_dict = selected.to_dict("index")
    lst = []
    for k, v in row_dict.items():
        lst.append(v)
    return lst
#     # return selected.to_dict('index')


@app.route('/api2',methods = ['GET'])
# def returnascii():
#         d = {}
#         inputchr = str(request.args['query'])
#         answer = str(ord(inputchr))
#         d['output'] = answer
#         return d


# def recommend():

#     d = {}
#     percentile = 0.85
# inputChr = str(request.args['query'])
#     df = genre_df[genre_df['genres'] == inputChr]

def recommendMovie():
    try:
        inputChr = str(request.args['query'])
        new_entry = new_df[new_df['title']==inputChr].index[0]
        distance = similarity1[new_entry]
        movie_list = sorted(list(enumerate(distance)), reverse=True, key=lambda x:x[1])[0:20]

        sumOfSim = 0
        for i in movie_list:
            sumOfSim += i[1]
        
        thres_value = (sumOfSim-1)/19


        ret_list = []

        for j in movie_list:
            if j[1] > thres_value:
                d = {"movie_name":new_df.iloc[j[0]].title,"poster_link":new_df.iloc[j[0]].poster_link_w185}
                ret_list.append(d)
            else:
                continue
        return [ret_list,[]]
    
    except IndexError as e:
        new_entry = inputChr.lower()
        movie_list = new_df[new_df['description'].str.contains(r"\b{}\b".format(new_entry))]

        word_count = []

        for index, row in movie_list.iterrows():
            word_count.append((index, row['description'].count(new_entry),row['popularity']))
        word_count = sorted(word_count, reverse=True, key = lambda x:x[1])

        movie_ls = []
        if len(word_count) == 0:
            return [{"error":"doesnt match with any movie"}]
        elif len(word_count) > 7:
            for i in range(0, 7):
                movie_ls.append(word_count[i])
        else:
            movie_ls = word_count
        
        # movie_ls = sorted(movie_ls, reverse=True, key=lambda x :x[2])

        dist_list = []

        for i in movie_ls:
            new_entry = new_df[new_df['title'] == new_df.iloc[i[0]].title].index[0]

            distance = similarity1[new_entry]

            movie_list1  =sorted(list(enumerate(distance)), reverse =True, key=lambda x:x[1])[0:20]

            sumSim = 0

            for i in movie_list1:
                sumSim += i[1]
            
            thresValue = (sumSim-1)/19

            for j in movie_list1:
                if j[1] > thresValue:
                    dist_list.append((j[1],new_df.iloc[j[0]].temp_index,new_df.iloc[j[0]].popularity))
                else:
                    continue
        
        dist_list = sorted(dist_list, reverse = True, key = lambda x : x[0])
        temp_i_list = []
        fin_movie_list = []

        for i in dist_list:
            if i[1] not in temp_i_list:
                temp_i_list.append(i[1])
                fin_movie_list.append(i)
            else:
                continue
        fin_movie_list = sorted(fin_movie_list,reverse=True,key = lambda x : x[0])[0:25]
        fin_movie_list = sorted(fin_movie_list, reverse = True, key = lambda x : x[2])
        
        
        first_list = []
        second_list = []

        for i in fin_movie_list:
            if i[0] > 0.98:
                d1 = {"movie_name":new_df.iloc[i[1]].title,"poster_link":new_df.iloc[i[1]].poster_link_w342,"sim_score":i[0]}
                first_list.append(d1)
            else:
                d2 = {"movie_name":new_df.iloc[i[1]].title,"poster_link":new_df.iloc[i[1]].poster_link_w342,"sim_score":i[0]}
                second_list.append(d2)

        # for i in fin_movie_list:
        #     d = {"movie_name":new_df.iloc[i[1]].title,"poster_link":new_df.iloc[i[1]].poster_link_w185}
        #     ret_list.append(d)

        return [first_list, second_list]
    except:
        return [{"error":"error"}]









if __name__ == "__main__":
    app.run(host="0.0.0.0",port=5001)