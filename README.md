# README

## Group Members:
Member 1 Name/UNI: Miles Blackwell, mab2459

Member 2 Name/UNI: Jacob Bowden, jpb2226

Member 3 Name/UNI: Blake Appleby, aba2176

Member 4 Name/UNI: Daniel Hu, dh3116

# FOR TAs:
Our second submission consists of the following complete features: 
- a landing page
- a user signup and login screens
- a user profile page which lists films uploaded by the user
- a home page where you can browse posts by other users and filter by school
- a video player screen that allows you to watch a video 
- a comment section for each video

#### [Deployed version](https://rocky-inlet-94258-676c28639eb3.herokuapp.com/)
#### [Repo](https://github.com/blake116th/opal)
#### Test Cov: 92.24%

To run the tests:

``` sh
bundle exec cucumber && bundle exec rspec
```

## Setup
In a terminal, cd to the repo and run `bundle`

Then pre-load the schools db and run the database migrations and asset compilations with
``` sh
bundle exec rails db:migrate
bundle exec rake assets:precompile
rake populate_schools
```

Then run the development server with
``` sh
bundle exec rails server
```

Then follow the link
``` sh
localhost:3000/login
```

### More testing info

All BDD tests can be ran with 

``` sh
bundle exec cucumber
```
consider using --fail-fast to disregard irrelevant warnings and remove bloat, and targeting a single feature. Ex:

``` sh
bundle exec cucumber features/<your_feature_file>.feature --fail-fast
```

## Git stuff

1. git checkout -b newBranch or git checkout existingBranch
2. git add -A or git add fileName
3. git status
4. git commit -m "commit message"
5. git push 
# opal-local
