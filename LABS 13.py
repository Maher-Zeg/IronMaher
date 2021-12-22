#!/usr/bin/env python
# coding: utf-8

# In[1]:



import requests
r=requests.get('https://xkcd.com/')
r.status_code


# In[2]:


#check headers
r.headers


# In[3]:


#check headers value
r.headers['Expires']


# In[4]:


#Provide HTML codes
r.text


# In[ ]:


#Get it via API
receive = requests.get('https://imgs.xkcd.com/comics/tv_problems_2x.png')

#Save it to your computer
with open (r'/Users/carrie/Downloads/image_lab13.png','wb') as f:
    f.write(receive.content)


# In[6]:


#Challenge 2: Get a password
r=requests.get('https://httpbin.org/get')
r.headers


# In[7]:


#get information from the website => use 'get'
ploads={'things':2,'total':25}
r=requests.get('https://httpbin.org/get',params=ploads)

print(r.text)
print(r.url)
#args:argument, when you add element inside, it turns from parameters to arguments


# In[8]:


#send information to the website => so use 'post'
ploads={'username':'Maher','password':'Iron'}
r=requests.post('https://httpbin.org/post',data=ploads)

print(r.text)


# In[9]:


#Export username and password as dictionary
ploads={'username':'Maher','password':'Iron'}
r=requests.post('https://httpbin.org/post',data=ploads)

#turn the result of request.post (<class 'requests.models.Response'>) into => <class 'dict'>
a=r.json()
print(a['form'])


# In[10]:


#Challenge 3: Hidden Cold Joke
import pandas as pd

r1=requests.get('https://github.com/ironhack-datalabs/scavenger')
print(r1.status_code)
#print(r1.text)

a1=r1.json()
d1 = pd.DataFrame(a1)

#print(type(r1))
#print(a1)


# In[11]:


#Challenge fork
#https://api.github.com/users/Ironhack/repos

import json
import requests

#Use the get method to send a request to the JSONPlaceholder API
response = requests.get('https://api.github.com/users/Ironhack/repos')

print(response.status_code)

#print(response.text)

results = response.json()
#print(results)

data = pd.DataFrame(results)
data
#flattened_data = pd.json_normalize(results)
#flattened_data


# In[12]:


#No. of fork?
print(data.fork.value_counts())


# In[13]:


#No. of commit?

print(len(data.git_commits_url))
#print(len(data.commits_url))

#flattened_data = pd.json_normalize(results)
#flattened_data


# In[14]:


#languages used?
#for i in data:
#    print(i)
#print(data.language)

l_set=set(i for i in data.language if i != None)
print(l_set)


# In[ ]:




